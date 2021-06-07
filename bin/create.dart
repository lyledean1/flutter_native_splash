import 'package:args/args.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'
    as flutter_native_splash;

void main(List<String> arguments) {
  var parser = ArgParser();

  parser.addOption('path',
      abbr: 'p',
      defaultsTo: 'flutter_native_splash.yaml',
      help: 'Set file path');

  var results = parser.parse(['path']);

  flutter_native_splash.createSplash(results['path']);
}
