import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.47.10"
import PizZip from 'npm:pizzip@3.1.7'
import Docxtemplater from 'npm:docxtemplater@3.55.5'
import { encode as encodeBase64 } from "https://deno.land/std@0.168.0/encoding/base64.ts";

serve(async (req) => {
  try {
    const { name_template, data } = await req.json()
    
    const authHeader = req.headers.get('Authorization')?.split(' ')[1]
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'No authorization header' }), { status: 401 })
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser(authHeader)
    if (userError || !user) {
      return new Response(JSON.stringify({ error: 'Invalid token' }), { status: 401 })
    }

    const { data: userData, error: creditsError } = await supabaseClient
      .from('users')
      .select('current_credits')
      .eq('id', user.id)
      .single()

    if (creditsError || !userData || userData.current_credits < 1) {
      return new Response(JSON.stringify({ error: 'Insufficient credits' }), { status: 403 })
    }

    const { data: templateData, error: templateError } = await supabaseClient
      .storage
      .from('templates')
      .download(name_template)

    if (templateError) {
      return new Response(JSON.stringify({ error: 'Template not found' }), { status: 404 })
    }

    const content = await templateData.arrayBuffer()
    const zip = new PizZip(content)
    const doc = new Docxtemplater(zip, {
      paragraphLoop: true,
      linebreaks: true
    })

    doc.render(data)

    const buf = doc.getZip().generate({
      type: 'uint8array',
      compression: 'DEFLATE'
    })

    const base64Doc = encodeBase64(buf)

    const { error: transactionError } = await supabaseClient.rpc('handle_document_creation', {
      user_id: user.id,
      doc_type: name_template,
      credits_used: 1
    })

    if (transactionError) {
      return new Response(JSON.stringify({ error: 'Transaction failed' }), { status: 500 })
    }

    return new Response(
      JSON.stringify({ docxBase64: base64Doc }),
      { headers: { 'Content-Type': 'application/json' }, status: 200 }
    )

  } catch (error) {
    return new Response(JSON.stringify({ error: (error as Error).message }), { status: 500 })
  }
})