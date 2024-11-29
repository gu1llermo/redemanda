# Script para crear estructura de carpetas de Flutter en Windows

function Create-FlutterStructure {
    # Carpetas base de features
    $features = @(
        "credits",
        "documents", 
        "statistics"
    )

    $layers = @(
        "domain/datasources",
        "domain/entities",
        "domain/repositories",
        "infrastructure/datasources",
        "infrastructure/mappers",
        "infrastructure/repositories",
        "presentation/providers",
        "presentation/screens",
        "presentation/widgets"
    )

    foreach ($feature in $features) {
        foreach ($layer in $layers) {
            $path = "features\$feature\$layer"
            New-Item -Path $path -ItemType Directory -Force | Out-Null
            
            # Crear archivo .gitkeep en cada carpeta
            # New-Item -Path "$path\.gitkeep" -ItemType File -Force | Out-Null
        }
    }

    Write-Host "Estructura de carpetas de Flutter creada exitosamente 🚀" -ForegroundColor Green
}

# Ejecutar la función
Create-FlutterStructure