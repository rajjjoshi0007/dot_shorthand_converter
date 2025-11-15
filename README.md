## dot_shorthand_helper

**dot_shorthand_helper** is a small helper package/CLI that automatically
refactors common Flutter enum usages like:

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
)
```

into the new Dart/Flutter 3.38 dot-shorthand form:

```dart
Column(
  mainAxisAlignment: .start,
  crossAxisAlignment: .center,
)
```

It works as a simple string-based codemod over your Dart files.

### Features

- **Automatic refactor**: converts `EnumName.value` into `.value` for a set of
  common Flutter enums (e.g. `MainAxisAlignment`, `CrossAxisAlignment`, `TextAlign`, etc.).
- **Safe by default**: skips non-Dart files and common tool/build folders.
- **Library + CLI**: use it programmatically or via `dart run`.

### Getting started

Add the package to your project (typically as a dev dependency):

```yaml
dev_dependencies:
  dot_shorthand_helper:
    git:
      url: <your-repo-or-pub-url>
```

Then run the CLI from the root of your Flutter app/package:

```bash
dart run dot_shorthand_helper lib/
```

This will walk all `.dart` files under `lib/` and rewrite common enum usages
to use dot-shorthand.

### CLI usage

- **Refactor a directory**:

  ```bash
  dart run dot_shorthand_helper lib/
  ```

- **Refactor a single file**:

  ```bash
  dart run dot_shorthand_helper lib/my_widget.dart
  ```

If you omit the path, it defaults to the current working directory.

### Library usage

You can also use the core transformer directly in Dart (e.g. for custom tools
or tests):

```dart
import 'package:dot_shorthand_helper/dot_shorthand_helper.dart';

void main() {
  const before = 'mainAxisAlignment: MainAxisAlignment.start,';
  final after = convertToDotShorthand(before);

  // after: 'mainAxisAlignment: .start,'
  print(after);
}
```

You can provide your own set of enum-type names if you want to customize what
gets converted:

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


