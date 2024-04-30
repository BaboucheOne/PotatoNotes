import 'package:popato_notes/domain/note.dart';
import 'package:popato_notes/infra/note_factory.dart';
import 'package:popato_notes/infra/local_storage_note_repository.dart';
import 'package:popato_notes/utility/clone_utility.dart';

class NoteService {
  final NoteFactory _noteFactory;
  final LocalStorageNoteRepository _localStorageNoteRepository;

  NoteService(this._noteFactory, this._localStorageNoteRepository);

  Note createEmpty() {
    return _noteFactory.create("", "");
  }

  void addOrUpdate(Note note) {
    _localStorageNoteRepository.add(note);
  }

  Future<void> save() async {
    await _localStorageNoteRepository.save();
  }

  Future<void> load() async {
    await _localStorageNoteRepository.load();
  }

  List<Note> getAll() {
    return CloneUtility.deepCloneList(_localStorageNoteRepository.getAll());
  }

  Note? getById(String id) {
    return _localStorageNoteRepository.getById(id)!.clone();
  }

  void remove(Note note) {
    _localStorageNoteRepository.remove(note);
  }
}
