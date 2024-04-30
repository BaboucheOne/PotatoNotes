import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:popato_notes/domain/note.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  final Function(Note) onNoteUpdated;

  const NoteTile({super.key, required this.note, required this.onNoteUpdated});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  void _togglePin() {
    setState(() {
      widget.note.setPin(!widget.note.isPinned());
      widget.onNoteUpdated(widget.note);
    });
  }

  IconData _getPinIcon() {
    if (widget.note.isPinned()) {
      return CupertinoIcons.pin_fill;
    }

    return CupertinoIcons.pin_slash_fill;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          onPressed: () {
            _togglePin();
          },
          icon: Icon(_getPinIcon())),
      title: Text(
        widget.note.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4.0),
          Text(
            widget.note.content,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            "${AppLocalizations.of(context)!.lastModified}: ${widget.note.lastUpdated}",
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
