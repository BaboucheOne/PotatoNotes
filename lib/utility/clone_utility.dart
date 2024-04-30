import 'package:popato_notes/interface/clonable.dart';

class CloneUtility {
  static List<T> deepCloneList<T extends Clonable<T>>(List<T> list) {
    List<T> clonedList = [];
    for (var item in list) {
      clonedList.add(item.clone());
    }
    return clonedList;
  }
}
