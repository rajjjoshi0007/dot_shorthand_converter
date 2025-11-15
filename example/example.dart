import 'package:dot_shorthand_converter/dot_shorthand_converter.dart';
import 'package:flutter/foundation.dart';

void main() {
  // Example 1: Basic conversion
  const before1 = '''
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text('Hello', textAlign: TextAlign.center),
  ],
)
''';

  final after1 = convertToDotShorthand(before1);
  if (kDebugMode) {
    print('Example 1 - Basic conversion:');

    print('Before:');
    print(before1);
    print('After:');
    print(after1);
    print('');
  }

  // Example 2: Custom enum types
  const before2 = '''
Container(
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
)
''';

  final after2 = convertToDotShorthand(
    before2,
    enumTypes: {'MainAxisAlignment', 'CrossAxisAlignment', 'TextAlign'},
  );
  if (kDebugMode) {
    print('Example 2 - Custom enum types:');
    print('Before:');
    print(before2);
    print('After:');
    print(after2);
    print('');
  }

  // Example 3: Multiple enum usages
  const before3 = '''
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  mainAxisSize: MainAxisSize.max,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  textDirection: TextDirection.ltr,
  verticalDirection: VerticalDirection.down,
  children: [
    Expanded(
      child: Text(
        'Left',
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      ),
    ),
    Expanded(
      child: Text(
        'Right',
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
    ),
  ],
)
''';

  final after3 = convertToDotShorthand(before3);
  if (kDebugMode) {
    print('Example 3 - Multiple enum usages:');
    print('Before:');
    print(before3);
    print('After:');
    print(after3);
  }
}
