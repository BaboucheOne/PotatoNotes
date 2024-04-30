import 'package:popato_notes/interface/clonable.dart';

class Note implements Clonable<Note>, Comparable<Note> {
  final String id;
  String title;
  String content;
  String lastUpdated;
  bool pinned;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.lastUpdated,
      required this.pinned});

  void setTitle(String title) {
    this.title = title;
  }

  void setContent(String content) {
    this.content = content;
  }

  void setLastUpdated(String lastUpdated) {
    this.lastUpdated = lastUpdated;
  }

  void setPin(bool pin) {
    pinned = pin;
  }

  bool isPinned() {
    return pinned;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'lastUpdated': lastUpdated,
      'pinned': pinned,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        lastUpdated: json['lastUpdated'],
        pinned: json.containsKey('pinned') ? json['pinned'] : false);
  }

  @override
  String toString() {
    return "$id\n$title\n$content\n$lastUpdated\n$pinned";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  Note clone() {
    return Note(
        id: id,
        title: title,
        content: content,
        lastUpdated: lastUpdated,
        pinned: pinned);
  }

  @override
  int compareTo(Note other) {
    int dateComparisonValue = lastUpdated.compareTo(other.lastUpdated);

    if (isPinned() && !other.isPinned()) {
      return -1 + dateComparisonValue;
    } else if (!isPinned() && other.isPinned()) {
      return 1 + dateComparisonValue;
    }

    return dateComparisonValue;
  }
}
