class NoteNotFoundException implements Exception {
  final String id;

  NoteNotFoundException(this.id);

  @override
  String toString() {
    return 'NoteNotFoundException: Note id $id not found.';
  }
}
