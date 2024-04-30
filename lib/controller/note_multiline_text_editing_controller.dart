import 'package:flutter/material.dart';

class NoteMultilineTextEditingController extends StatefulWidget {
  final TextEditingController controller;
  const NoteMultilineTextEditingController(
      {super.key, required this.controller});

  @override
  State<NoteMultilineTextEditingController> createState() =>
      _NoteMultilineTextEditingControllerState();
}

class _NoteMultilineTextEditingControllerState
    extends State<NoteMultilineTextEditingController> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}
