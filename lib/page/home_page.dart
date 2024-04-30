import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:popato_notes/domain/note.dart';
import 'package:popato_notes/page/credit_page.dart';
import 'package:popato_notes/page/note_page.dart';
import 'package:popato_notes/service/note_service.dart';
import 'package:popato_notes/widget/note/notes_listview.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  final NoteService _noteService = GetIt.instance.get<NoteService>();

  @override
  void initState() {
    super.initState();
    refreshNoteList();
  }

  void refreshNoteList() {
    _noteService.load().then((value) {
      setState(() {
        _notes = _noteService.getAll();
        _notes.sort();
        _filteredNotes = _notes;
      });
    });
  }

  void _filterNotes(String searchText) {
    setState(() {
      _filteredNotes = _notes
          .where((note) =>
              note.title.toLowerCase().contains(searchText.toLowerCase()) ||
              note.content.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  refreshNoteList();
                },
                icon: const Icon(Icons.sync)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreditPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.info_outline))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NotePage(note: _noteService.createEmpty()),
              ),
            ).then((value) => refreshNoteList());
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SearchAnchor(
                builder: (context, SearchController searchController) {
                  return SearchBar(
                      controller: searchController,
                      onChanged: _filterNotes,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      leading: const Icon(Icons.search));
                },
                suggestionsBuilder: (context, searchController) {
                  return List<ListTile>.generate(0, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          searchController.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
              Expanded(
                  child: NotesListview(
                notes: _filteredNotes,
                onUpdated: () {
                  refreshNoteList();
                },
              ))
            ])));
  }
}
