import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:popato_notes/domain/note.dart';
import 'package:popato_notes/service/note_service.dart';
import 'package:popato_notes/utility/date_utility.dart';
import 'package:popato_notes/widget/toast/toast_confirmation.dart';
import 'package:popato_notes/controller/note_multiline_text_editing_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotePage extends StatefulWidget {
  final Note note;
  const NotePage({super.key, required this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late FToast fToast;
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController contentTextController = TextEditingController();
  NoteService noteService = GetIt.instance.get<NoteService>();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    setState(() {
      titleTextController.text = widget.note.title;
      contentTextController.text = widget.note.content;
    });
  }

  Future _saveNote() async {
    widget.note.setTitle(titleTextController.text);
    widget.note.setContent(contentTextController.text);
    widget.note.setLastUpdated(DateUtility.currentFormattedDate());

    noteService.addOrUpdate(widget.note);
    await noteService.save().then((value) => {
          fToast.showToast(
            child: ToastConfirmation(
                message: AppLocalizations.of(context)!.noteSaved),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 1),
          )
        });
  }

  void _togglePin() {
    setState(() {
      widget.note.setPin(!widget.note.isPinned());
    });
  }

  bool _isDirty() {
    return titleTextController.text != widget.note.title ||
        contentTextController.text != widget.note.content;
  }

  IconData _getPinIcon() {
    if (widget.note.isPinned()) {
      return CupertinoIcons.pin_fill;
    }

    return CupertinoIcons.pin_slash_fill;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          actions: [
            IconButton(
                onPressed: () {
                  _togglePin();
                },
                icon: Icon(_getPinIcon()))
          ],
        ),
        body: PopScope(
            onPopInvoked: (bool didPop) async {
              if (titleTextController.text.isNotEmpty ||
                  contentTextController.text.isNotEmpty) {
                if (_isDirty()) {
                  await _saveNote();
                }
              }
            },
            child: Column(
              children: [
                Text(
                  "${AppLocalizations.of(context)!.lastModified} ${widget.note.lastUpdated}",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                TextField(
                  controller: titleTextController,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.noteTitle,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
                Expanded(
                    child: NoteMultilineTextEditingController(
                        controller: contentTextController))
              ],
            )));
  }
}
