# dot_shorthand_helper

[![pub package](https://img.shields.io/pub/v/dot_shorthand_helper.svg)](https://pub.dev/packages/dot_shorthand_helper)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A helper package/CLI that automatically refactors common Flutter enum usages into the new Dart/Flutter 3.38+ dot-shorthand form.

## Overview

**dot_shorthand_helper** converts verbose enum usages like:

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  textAlign: TextAlign.center,
)
```

into the concise dot-shorthand form:

```dart
Column(
  mainAxisAlignment: .start,
  crossAxisAlignment: .center,
  textAlign: .center,
)
```

This package works as a simple string-based codemod over your Dart files, making it fast and easy to modernize your Flutter codebase.

## Features

- ✅ **Automatic refactor**: Converts `EnumName.value` into `.value` for 100+ common Flutter enums
- ✅ **Safe by default**: Skips non-Dart files and common tool/build folders (`.dart_tool`, `build`, `.git`)
- ✅ **Library + CLI**: Use it programmatically or via `dart run`
- ✅ **Zero dependencies**: Pure Dart implementation, no Flutter analyzer required
- ✅ **Customizable**: Provide your own set of enum types to convert

## Installation

Add `dot_shorthand_helper` to your `dev_dependencies` in `pubspec.yaml`:

```yaml
dev_dependencies:
  dot_shorthand_helper: ^0.0.1
```

Then install it:

```bash
dart pub get
```

## Quick Start

Run the CLI from the root of your Flutter app/package:

```bash
dart run dot_shorthand_helper lib/
```

This will walk all `.dart` files under `lib/` and rewrite common enum usages to use dot-shorthand.

## CLI Usage

### Refactor a directory

```bash
dart run dot_shorthand_helper lib/
```

### Refactor a single file

```bash
dart run dot_shorthand_helper lib/my_widget.dart
```

### Refactor current directory

If you omit the path, it defaults to the current working directory:

```bash
dart run dot_shorthand_helper
```

## Library Usage

You can also use the core transformer directly in Dart code:

```dart
import 'package:dot_shorthand_helper/dot_shorthand_helper.dart';

void main() {
  const before = 'mainAxisAlignment: MainAxisAlignment.start,';
  final after = convertToDotShorthand(before);
  
  print(after); // 'mainAxisAlignment: .start,'
}
```

### Custom Enum Types

Provide your own set of enum-type names to customize what gets converted:

```dart
final custom = convertToDotShorthand(
  sourceCode,
  enumTypes: {
    'MainAxisAlignment',
    'CrossAxisAlignment',
    'MyCustomEnum',
  },
);
```

## Supported Enums

The package includes support for 100+ common Flutter enums, including:

- **Layout & Alignment**: `MainAxisAlignment`, `CrossAxisAlignment`, `Axis`, `WrapAlignment`, etc.
- **Text & Typography**: `TextAlign`, `TextDirection`, `TextOverflow`, `FontWeight`, etc.
- **Material Design**: `FloatingLabelBehavior`, `MaterialTapTargetSize`, `SnackBarBehavior`, etc.
- **Painting & Decoration**: `BoxFit`, `BlendMode`, `BorderStyle`, `Clip`, etc.
- **Scrolling**: `ScrollDirection`, `ScrollViewKeyboardDismissBehavior`, etc.
- **And many more...**

See [`lib/dot_shorthand_helper.dart`](lib/dot_shorthand_helper.dart) for the complete list.

## Requirements

- Dart SDK: `^3.9.2`
- Flutter: `>=1.17.0` (for Flutter projects)

## How It Works

This package uses regex-based pattern matching to find and replace enum usages. It's designed to be:
- **Fast**: No AST parsing or type analysis required
- **Safe**: Only matches known enum patterns in typical Flutter widget contexts
- **Simple**: Pure string transformation, works on any Dart code

## Limitations

- This is a **text-based transformer**, not a full AST analyzer
- It may occasionally be too aggressive if you use the same enum names in unusual contexts
- In typical Flutter widget trees, it should be safe and accurate

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
