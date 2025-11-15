/// Utilities for converting Flutter enum/property usages like
/// `MainAxisAlignment.start` into the new Dart/Flutter 3.38
/// dot-shorthand form: `.start`.
///
/// This is a **pure string transformer** – it does not depend on Flutter
/// or the Dart analyzer, so it can be used in tools, tests, or CLIs.
library;

/// Default set of enum-type names that are safe and common to shorten.
///
/// You can pass your own set to [convertToDotShorthand] if you want to
/// customize this list.

const Set<String> dotShorthandEnums = {
  // Animation
  'AnimationBehavior',
  'AnimationStatus',

  // Cupertino
  'CupertinoDatePickerMode',
  'CupertinoTimerPickerMode',
  'CupertinoUserInterfaceLevelData',
  'DatePickerDateOrder',

  // Gestures
  'DragStartBehavior',
  'MultitouchDragStrategy',

  // Layout & Alignment
  'Axis',
  'AxisDirection',
  'CrossAxisAlignment',
  'FlexFit',
  'MainAxisAlignment',
  'MainAxisSize',
  'VerticalDirection',
  'WrapAlignment',
  'WrapCrossAlignment',

  // Material Design
  'FloatingLabelBehavior',
  'ListTileControlAffinity',
  'ListTileStyle',
  'MaterialTapTargetSize',
  'MaterialType',
  'SnackBarBehavior',
  'TabBarIndicatorSize',

  // Painting & Decoration
  'BlendMode',
  'BlurStyle',
  'BorderStyle',
  'BoxFit',
  'BoxShape',
  'Clip',
  'DecorationPosition',
  'FilterQuality',
  'FlutterLogoStyle',
  'ImageRepeat',
  'PaintingStyle',
  'PathFillType',
  'ResizeImagePolicy',
  'StrokeCap',
  'StrokeJoin',
  'TileMode',
  'VertexMode',

  // Platform Services
  'ContentSensitivity',
  'DeviceOrientation',
  'FloatingCursorDragState',
  'KeyboardLockMode',
  'KeyboardSide',
  'MaxLengthEnforcement',
  'ModifierKey',
  'SelectionChangedCause',
  'SmartDashesType',
  'SmartQuotesType',
  'SwipeEdge',
  'SystemSoundType',
  'SystemUiMode',
  'SystemUiOverlay',
  'TextCapitalization',
  'TextInputAction',
  'UndoDirection',

  // Rendering
  'CacheExtentStyle',
  'GrowthDirection',
  'HitTestBehavior',
  'Orientation',
  'OverflowBoxFit',
  'PointerDeviceKind',
  'StackFit',
  'TableCellVerticalAlignment',

  // Scrolling
  'ScrollDirection',
  'ScrollViewKeyboardDismissBehavior',
  'ScrollbarOrientation',

  // Text & Typography
  'FontStyle',
  'FontWeight',
  'PlaceholderAlignment',
  'TextAffinity',
  'TextAlign',
  'TextBaseline',
  'TextDecorationStyle',
  'TextDirection',
  'TextLeadingDistribution',
  'TextOverflow',
  'TextWidthBasis',

  // Theme & Styling
  'Brightness',

  // Widget States
  'WidgetState',
};

/// Converts known enum usages like `MainAxisAlignment.start` into `.start`.
///
/// This function operates purely on text and does **not** perform full
/// type analysis, so it may occasionally be too aggressive if you use
/// the same enum names in unusual contexts. In typical Flutter widget
/// trees it should be safe.
///
/// Example:
/// ```dart
/// final before = 'mainAxisAlignment: MainAxisAlignment.start,';
/// final after = convertToDotShorthand(before);
/// // after: 'mainAxisAlignment: .start,'
/// ```
String convertToDotShorthand(String source, {Set<String>? enumTypes}) {
  final enums = enumTypes ?? dotShorthandEnums;
  if (enums.isEmpty) return source;

  // Build a single regex that matches any of the enum type names followed
  // by `.value`, e.g. `MainAxisAlignment.start`.
  //
  // \b ensures we don't match inside longer identifiers.
  final enumAlternation = enums.map(RegExp.escape).join('|');
  final pattern = RegExp(
    r'\b('
    '$enumAlternation'
    r')\.([A-Za-z_][A-Za-z0-9_]*)',
  );

  // Replace `EnumName.value` with `.value`.
  return source.replaceAllMapped(pattern, (match) => '.${match.group(2)}');
}
