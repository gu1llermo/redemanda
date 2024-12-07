import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Construction Icon
              Icon(
                Icons.construction,
                size: 100,
                color: colorScheme.primary,
              ),

              const SizedBox(height: 20),

              // Main Title
              Text(
                'Página en Construcción',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Descriptive Message
              Text(
                'Estamos trabajando arduamente para mejorar esta sección. Pronto estará lista para ti.',
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Additional Details
              Text(
                'Disculpa las molestias. Vuelve pronto para ver las novedades.',
                style: textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Return to Home Button
              ElevatedButton(
                onPressed: () => context.go('/'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Regresar',
                  style: textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
