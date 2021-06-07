import 'package:args/args.dart';
import 'package:io/io.dart';
import 'package:io/ansi.dart';
import 'package:args/command_runner.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'
    as flutter_native_splash;
import 'package:universal_io/io.dart';

class CreateCommand extends Command<int> {
  @override
  final argParser = ArgParser();

  @override
  String get name => 'create';

  @override
  String get description =>
      'Cleans up output from previous builds. Does not clean up --output '
      'directories.';

  @override
  Future<int> run() async {
    return 0;
  }
}

void main(List<String> args) async {
  // Use the actual command runner to parse the args and immediately print the
  // usage information if there is no command provided or the help command was
  // explicitly invoked.
  var commandRunner = CommandRunner('flutter_native_splash', 'blah');
  var localCommands = [CreateCommand()];
  var localCommandNames = localCommands.map((c) => c.name).toSet();
  for (var command in localCommands) {
    commandRunner.addCommand(command);
    // This flag is added to each command individually and not the top level.

  }

  ArgResults parsedArgs;
  try {
    parsedArgs = commandRunner.parse(args);
  } on UsageException catch (e) {
    print(red.wrap(e.message));
    print('');
    print(e.usage);
    exitCode = ExitCode.usage.code;
    return;
  }

  var commandName = parsedArgs.command?.name;

  if (parsedArgs.rest.isNotEmpty) {
    print(
        yellow.wrap('Could not find a command named "${parsedArgs.rest[0]}".'));
    print('');
    exitCode = ExitCode.usage.code;
    return;
  }

  if (commandName == 'help' ||
      parsedArgs.wasParsed('help') ||
      (parsedArgs.command?.wasParsed('help') ?? false)) {
    await commandRunner.runCommand(parsedArgs);
    return;
  }

  if (commandName == null) {
    commandRunner.printUsage();
    exitCode = ExitCode.usage.code;
    return;
  }

  if (commandName == 'create') {
    flutter_native_splash.createSplash('flutter_native_splash.yaml');
  }
}
