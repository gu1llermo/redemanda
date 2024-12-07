import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

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
              // 404 Icon
              Icon(
                Icons.error_outline,
                size: 100,
                color: colorScheme.error,
              ),

              const SizedBox(height: 20),

              // Main Error Title
              Text(
                '404',
                style: textTheme.displayLarge?.copyWith(
                  color: colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Error Description
              Text(
                'Página no encontrada',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Descriptive Message
              Text(
                'Lo sentimos, la página que estás buscando no existe o ha sido movida.',
                style: textTheme.bodyLarge,
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
