import 'dart:io';
import 'dart:async';

Future<void> runCommand(String executable, List<String> arguments) async {
  print('Running: $executable ${arguments.join(' ')}');
  final result = await Process.run(executable, arguments, runInShell: true);

  if (result.stdout.isNotEmpty) {
    print('stdout: ${result.stdout}');
  }

  if (result.stderr.isNotEmpty) {
    print('stderr: ${result.stderr}');
  }

  if (result.exitCode != 0) {
    throw Exception('Command failed with exit code ${result.exitCode}');
  }
}

void main() async {
  try {
    // Packages to install
    final packages = [
      'flutter_riverpod',
      'riverpod_annotation',
      'dev:riverpod_generator',
      'dev:build_runner',
      'dev:custom_lint',
      'dev:riverpod_lint'
    ];

    // Install packages
    for (var package in packages) {
      await runCommand('flutter', ['pub', 'add', package]);
    }

    // Update analysis_options.yaml
    final file = File('analysis_options.yaml');

    if (await file.exists()) {
      String content = await file.readAsString();

      if (!content.contains('custom_lint')) {
        content += '\n\nanalyzer:\n  plugins:\n    - custom_lint';
        await file.writeAsString(content);
        print('Updated analysis_options.yaml');
      }
    } else {
      // Create file if it doesn't exist
      await file.writeAsString('''
analyzer:
  plugins:
    - custom_lint
''');
      print('Created analysis_options.yaml');
    }

    // Generate code
    // await runCommand('dart', ['run', 'build_runner', 'build']);

    print('Setup completed successfully!');
  } catch (e) {
    print('Error during setup: $e');
    exit(1);
  }
}
