import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:popato_notes/domain/note.dart';
import 'package:popato_notes/page/note_page.dart';
import 'package:popato_notes/service/note_service.dart';
import 'package:popato_notes/widget/note/note_tile.dart';
import 'package:popato_notes/widget/note/note_tile_remove.dart';
import 'package:popato_notes/widget/toast/toast_delete.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesListview extends StatefulWidget {
  final List<Note> notes;
  final VoidCallback onUpdated;

  const NotesListview(
      {super.key, required this.notes, required this.onUpdated});

  @override
  State<NotesListview> createState() => _NotesListviewState();
}

class _NotesListviewState extends State<NotesListview> {
  late FToast fToast;
  NoteService noteService = GetIt.instance.get<NoteService>();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void refreshNoteList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.notes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(note: widget.notes[index]),
                ),
              ).then((value) => refreshNoteList());
            },
            child: Dismissible(
                onUpdate: (details) {
                  refreshNoteList();
                },
                onDismissed: (direction) {
                  setState(() {
                    noteService.remove(widget.notes[index]);
                    widget.notes.remove(widget.notes[index]);

                    noteService.save().then((value) {
                      fToast.showToast(
                        child: ToastDelete(
                            message: AppLocalizations.of(context)!.noteDeleted),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(milliseconds: 500),
                      );
                    });
                  });
                },
                key: Key(widget.notes[index].id),
                background: const NoteTileRemove(),
                child: NoteTile(
                  note: widget.notes[index],
                  onNoteUpdated: (Note note) {
                    noteService.addOrUpdate(note);
                    noteService.save().then((value) => widget.onUpdated());
                    refreshNoteList();
                  },
                )));
      },
    );
  }
}
