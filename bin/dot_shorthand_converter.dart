import 'dart:io';

import 'package:dot_shorthand_converter/dot_shorthand_converter.dart';

/// Simple CLI that walks a file or directory and converts known enum
/// usages like `MainAxisAlignment.start` into `.start`.
///
/// Usage:
///   dart run dot_shorthand_converter [path-to-file-or-directory]
///
/// Example:
///   dart run dot_shorthand_converter lib/
Future<void> main(List<String> args) async {
  final targetPath = args.isNotEmpty ? args.first : Directory.current.path;

  final type = FileSystemEntity.typeSync(targetPath);
  if (type == FileSystemEntityType.notFound) {
    stderr.writeln('Path not found: $targetPath');
    exitCode = 2;
    return;
  }

  final files = <File>[];

  if (type == FileSystemEntityType.file) {
    final file = File(targetPath);
    if (_isDartFile(file.path)) {
      files.add(file);
    }
  } else if (type == FileSystemEntityType.directory) {
    final root = Directory(targetPath);
    await for (final entity in root.list(recursive: true, followLinks: false)) {
      if (entity is! File) continue;
      if (!_isDartFile(entity.path)) continue;
      if (_isIgnoredPath(entity.path)) continue;
      files.add(entity);
    }
  }

  if (files.isEmpty) {
    stdout.writeln('No Dart files found under $targetPath');
    return;
  }

  stdout.writeln(
    'dot_shorthand_converter: processing ${files.length} Dart file(s)...',
  );

  var changedCount = 0;

  for (final file in files) {
    final original = await file.readAsString();
    final converted = convertToDotShorthand(original);

    if (converted != original) {
      await file.writeAsString(converted);
      changedCount++;
      stdout.writeln('  updated: ${file.path}');
    }
  }

  stdout.writeln(
    'Done. Updated $changedCount file(s) with dot-shorthand enum usages.',
  );
}

bool _isDartFile(String path) => path.endsWith('.dart');

bool _isIgnoredPath(String path) {
  // Skip common tool/build directories.
  final ignoredSegments = [
    '${Platform.pathSeparator}.dart_tool${Platform.pathSeparator}',
    '${Platform.pathSeparator}build${Platform.pathSeparator}',
    '${Platform.pathSeparator}.git${Platform.pathSeparator}',
  ];

  return ignoredSegments.any(path.contains);
}
