import 'package:uuid/uuid.dart';
import 'package:popato_notes/domain/note.dart';
import 'package:popato_notes/utility/date_utility.dart';

class NoteFactory {
  Note create(String title, String content) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateUtility.formatDate(currentDate);
    return Note(
        id: const Uuid().v4(),
        title: title,
        content: content,
        lastUpdated: formattedDate,
        pinned: false);
  }
}
