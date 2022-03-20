// ignore_for_file: avoid_print
/// Used to generate `enumerations.dart`.
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

/// The name of the bindings file to be imported.
const bindingsFilename = 'lib/src/sdl_bindings.dart';

/// The prefix for all constant values.
const cPrefix = 'SDL_';

/// The name of the error file to import.
const errorFilename = 'error.dart';

/// The name of the error class to throw.
const errorClassName = 'SdlError';

/// The name of the file to generate.
const enumsFilename = 'lib/src/enumerations.dart';

/// A map of enum names that don't match the prefix of their member names.
const unmatchedPrefixes = <String, String>{};

/// A map of enum names to member prefixes which should be removed.
const enumMemberPrefixes = <String, String>{
  'AssertState': 'assertion',
  'ThreadPriority': 'threadPriority_',
  'AudioStatus': 'AUDIO_',
  'PixelFormat': 'PIXELFORMAT_',
  'YuvConversionMode': 'YUV_CONVERSION_',
  'WindowFlags': 'WINDOW_',
  'WindowEventID': 'WINDOWEVENT_',
  'DisplayEventID': 'DISPLAYEVENT_',
  'DisplayOrientation': 'ORIENTATION_',
  'GLattr': 'GL_',
  'GLprofile': 'GL_CONTEXT_PROFILE_',
  'GLcontextFlag': 'GL_Context_',
  'GLcontextReleaseFlag': 'GL_CONTEXT_RELEASE_BEHAVIOR_',
  'GLContextResetNotification': 'GL_CONTEXT_RESET_',
  'HitTestResult': 'HITTEST_',
  'SystemCursor': 'SYSTEM_CURSOR_',
  'MouseWheelDirection': 'MOUSEWHEEL_',
  'JoystickType': 'JOYSTICK_TYPE_',
  'JoystickPowerLevel': 'JOYSTICK_POWER_',
  'SensorType': 'SENSOR_',
  'GameControllerType': 'CONTROLLER_TYPE_',
  'GameControllerBindType': 'CONTROLLER_BINDTYPE_',
  'GameControllerAxis': 'CONTROLLER_AXIS_',
  'GameControllerButton': 'CONTROLLER_BUTTON_',
  'TouchDeviceType': 'TOUCH_DEVICE_',
  'HintPriority': 'HINT_',
  'LogCategory': 'LOG_CATEGORY',
  'LogPriority': 'LOG_PRIORITY_',
  'MessageBoxFlags': 'MESSAGEBOX_',
  'MessageBoxButtonFlags': 'MESSAGEBOX_BUTTON_',
  'MessageBoxColorType': 'MESSAGEBOX_COLOR_',
  'RendererFlags': 'RENDERER_',
  'RendererFlip': 'FLIP_',
};

/// The enum names to ignore.
const ignoredEnumNames = [
  'DUMMY_ENUM',
  'Scancode',
  'KeyCode',
  'Keymod',
];

/// A list of reserved keywords in Dart.
///
/// Any [EnumMember] name which is found in this list will be appended with an
/// underscore (_).
const reservedKeywords = <String>[
  'abstract',
  'else',
  'import',
  'as',
  'enum',
  'in',
  'static',
  'assert',
  'export',
  'super',
  'extends',
  'is',
  'switch',
  'await',
  'extension',
  'late',
  'break',
  'library',
  'this',
  'case',
  'factory',
  'mixin',
  'throw',
  'catch',
  'false',
  'new',
  'true',
  'class',
  'final',
  'null',
  'try',
  'const',
  'finally',
  'typedef',
  'continue',
  'operator',
  'var',
  'covariant',
  'Function',
  'part',
  'void',
  'default',
  'get',
  'required',
  'while',
  'deferred',
  'rethrow',
  'with',
  'do',
  'if',
  'return',
  'yield',
  'dynamic',
  'implements',
  'set',
];

/// A map of unsavoury generated Dart enum names to more satisfactory ones.
const enumNameReplacements = <String, String>{
  'Eventaction': 'EventAction',
  'Errorcode': 'ErrorCode',
  'Bool': 'SdlBool',
  'PixelFormatEnum': 'PixelFormat',
  'YUVCONVERSIONMODE': 'YuvConversionMode',
};

/// A map of unsavoury generated Dart member names to more satisfactory ones.
const memberNameReplacements = <String, String>{};

/// A member of a [CEnum].
class EnumMember {
  /// Create an instance.
  const EnumMember({
    required this.dartName,
    required this.cName,
    required this.value,
  });

  /// The Dart name for this member.
  final String dartName;

  /// The name of the C enum member.
  final String cName;

  /// The C value for this member.
  final String value;

  /// Get the fully qualified enum member name.
  String getEnumMemberName(CEnum e) => '${e.cName}.$cPrefix$cName';

  /// Get the fully qualified Dart member name.
  String getDartMemberName(CEnum e) => '${e.dartName}.$dartName';
}

/// An enum to be written to disk.
class CEnum {
  /// Create an instance.
  const CEnum(this.name, this.members);

  /// The truncated name of this enum.
  final String name;

  /// The C name of this enum.
  String get cName => '$cPrefix$name';

  /// The Dart name for this enum.
  String get dartName =>
      getDartName(name, capitaliseFirst: true, lowerCaseRest: false);

  /// All the members of this enum.
  final List<EnumMember> members;
}

/// Generate a dart name from [cName].
String getDartName(String cName,
    {bool capitaliseFirst = false, bool lowerCaseRest = true}) {
  final names = <String>[];
  for (final name in cName.split('_')) {
    var rest = name.substring(1);
    if (lowerCaseRest == true) {
      rest = rest.toLowerCase();
    }
    names.add(name[0].toUpperCase() + rest);
  }
  if (capitaliseFirst == false) {
    names[0] = names[0].toLowerCase();
  }
  final name = names.join();
  if (reservedKeywords.contains(name)) {
    return '${name}_';
  }
  final replacement = enumNameReplacements[name];
  if (replacement == null) {
    return name;
  }
  return replacement;
}

Future<void> main() async {
  final bindings = File(bindingsFilename);
  final enums = <CEnum>[];
  final classNamePattern = RegExp('^abstract class $cPrefix([^ ]+) [{]\$');
  final classMemberPattern = RegExp(
    '^  static const int $cPrefix([^ ]+) = ([^;]+);\$',
  );
  CEnum? currentEnum;
  for (final line in await bindings.readAsLines()) {
    if (currentEnum == null) {
      final match = classNamePattern.firstMatch(line);
      if (match != null) {
        final name = match.group(1)!;
        if (ignoredEnumNames.contains(name)) {
          print('Ignoring $cPrefix$name.');
          continue;
        }
        currentEnum = CEnum(name, []);
      }
    } else if (line.startsWith('}')) {
      if (currentEnum.members.isNotEmpty) {
        enums.add(currentEnum);
        print('Parsed ${currentEnum.cName} (${currentEnum.dartName}).');
      } else {
        print('Skipping empty enum ${currentEnum.name}.');
      }
      currentEnum = null;
    } else {
      final match = classMemberPattern.firstMatch(line);
      if (match != null) {
        final memberName = match.group(1)!;
        final memberValue = match.group(2)!;
        var dartMemberName = memberName;
        if (dartMemberName
            .toLowerCase()
            .startsWith(currentEnum.name.toLowerCase())) {
          dartMemberName = dartMemberName.substring(currentEnum.name.length);
          if (dartMemberName.startsWith('_')) {
            dartMemberName = dartMemberName.substring(1);
          }
        }
        final prefix = unmatchedPrefixes[currentEnum.name];
        if (prefix != null) {
          dartMemberName = dartMemberName.substring(prefix.length + 1);
        }
        final replacePrefix = enumMemberPrefixes[currentEnum.dartName];
        if (replacePrefix != null && dartMemberName.startsWith(replacePrefix)) {
          dartMemberName = dartMemberName.substring(replacePrefix.length);
          if (dartMemberName.startsWith('_')) {
            dartMemberName = dartMemberName.substring(1);
          }
        }
        if (int.tryParse(dartMemberName[0]) != null) {
          dartMemberName = currentEnum.dartName[0].toLowerCase() +
              currentEnum.dartName.substring(1) +
              dartMemberName;
        } else {
          dartMemberName = getDartName(dartMemberName);
        }
        final enumMember = EnumMember(
            dartName: dartMemberName, cName: memberName, value: memberValue);
        print('${enumMember.cName} -> ${enumMember.dartName}.');
        currentEnum.members.add(enumMember);
      }
    }
  }
  final buffer = StringBuffer()
    ..writeln('/// Automatically generated by `generate_enums.dart`.')
    ..writeln("import '$errorFilename';")
    ..writeln("import '${path.basename(bindingsFilename)}';");
  for (final e in enums) {
    buffer
      ..writeln('/// ${e.cName}.')
      ..writeln('enum ${e.dartName} {');
    for (final m in e.members) {
      buffer
        ..writeln('/// $cPrefix${m.cName} = ${m.value}')
        ..writeln('${m.dartName},');
    }
    buffer
      ..writeln('}')
      ..writeln('/// An extension for converting Dart to C values.')
      ..writeln('extension ${e.dartName}ToInt on ${e.dartName} {')
      ..writeln('/// Return an integer.')
      ..writeln('int toInt() {')
      ..writeln('switch (this) {');
    for (final m in e.members) {
      buffer
        ..writeln('case ${m.getDartMemberName(e)}: ')
        ..writeln('return ${m.getEnumMemberName(e)};');
    }
    buffer.writeln('}}}');
  }
  buffer
    ..writeln('/// An extension for converting integers to Dart values.')
    ..writeln('extension IntToC on int {');
  for (final e in enums) {
    buffer
      ..writeln('/// Convert from a [${e.cName}] member.')
      ..writeln('${e.dartName} to${e.dartName}() {')
      ..writeln('switch(this) {');
    final values = <String>[];
    for (final m in e.members) {
      if (values.contains(m.value) == true) {
        continue;
      }
      values.add(m.value);
      buffer
        ..writeln('case ${m.getEnumMemberName(e)}:')
        ..writeln('return ${m.getDartMemberName(e)};');
    }
    buffer
      ..writeln('default:')
      ..writeln('throw $errorClassName(')
      ..writeln("this, 'Unrecognised `${e.cName}` member.');")
      ..writeln('}}');
  }
  buffer.writeln('}');
  final formatter = DartFormatter();
  File(enumsFilename).writeAsStringSync(formatter.format(buffer.toString()));
  print('Done.');
}
