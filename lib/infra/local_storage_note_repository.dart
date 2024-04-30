import 'dart:convert';
import 'package:popato_notes/domain/note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:popato_notes/exception/note_not_found_exception.dart';

class LocalStorageNoteRepository {
  final String _preferenceKey = "potato_notes";
  List<Note> _notes = [];

  void add(Note note) {
    if (!_notes.contains(note)) {
      _notes.add(note);
    } else {
      update(note);
    }
  }

  void update(Note note) {
    _notes.remove(note);
    _notes.add(note);
  }

  List<Note> getAll() {
    return _notes;
  }

  Note? getById(String id) {
    return _notes.firstWhere((item) => item.id == id,
        orElse: () => throw NoteNotFoundException(id));
  }

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesJson = prefs.getString(_preferenceKey);

    if (notesJson != null) {
      List<dynamic> notesListJson = jsonDecode(notesJson);
      _notes = notesListJson.map((json) => Note.fromJson(json)).toList();
    }
  }

  Future<void> save() async {
    List<Map<String, dynamic>> productListJson =
        _notes.map((note) => note.toJson()).toList();
    String notesJson = jsonEncode(productListJson);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferenceKey, notesJson);
  }

  void remove(Note note) {
    _notes.removeWhere((item) => item.id == note.id);
  }
}
