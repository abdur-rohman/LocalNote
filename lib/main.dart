import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:local_note/entities/note_entity.dart';
import 'package:local_note/mappers/note_mapper.dart';
import 'package:local_note/providers/note_provider.dart';
import 'package:local_note/repos/note_repository.dart';
import 'package:local_note/utils/color_util.dart';
import 'package:local_note/views/notes_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  final injector = MyApp.injector;

  // Setup hive
  await () async {
    WidgetsFlutterBinding.ensureInitialized();

    final path = (await getApplicationDocumentsDirectory()).path;

    Hive.init(path);
    Hive.registerAdapter(NoteEntityAdapter());

    final Box<NoteEntity> box = await Hive.openBox("notes");

    injector.registerSingleton<Box<NoteEntity>>(box);
  }();

  // Register Depedencies
  await () async {
    // Mapper
    injector.registerSingleton<NoteMapper>(NoteMapperImpl());

    // Repo
    injector.registerSingleton<NoteRepository>(NoteRepositoryImpl(
        injector.get<Box<NoteEntity>>(), injector.get<NoteMapper>()));
  }();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => NoteProvider(injector.get<NoteRepository>()))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static GetIt get injector => GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: colorBackground),
      home: NotesView(),
    );
  }
}
