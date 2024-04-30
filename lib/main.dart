import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:popato_notes/page/home_page.dart';
import 'package:popato_notes/infra/note_factory.dart';
import 'package:popato_notes/service/note_service.dart';
import 'package:popato_notes/infra/local_storage_note_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  GetIt serviceLocator = GetIt.instance;

  NoteFactory noteFactory = NoteFactory();
  LocalStorageNoteRepository localStorageNoteRepository =
      LocalStorageNoteRepository();
  serviceLocator.registerSingleton<NoteService>(
      NoteService(noteFactory, localStorageNoteRepository));

  runApp(const PotatoNoteApp());
}

class PotatoNoteApp extends StatefulWidget {
  const PotatoNoteApp({super.key});

  @override
  State<PotatoNoteApp> createState() => _PotatoNoteAppState();
}

class _PotatoNoteAppState extends State<PotatoNoteApp> {
  _PotatoNoteAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potato Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Notes'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
    );
  }
}
