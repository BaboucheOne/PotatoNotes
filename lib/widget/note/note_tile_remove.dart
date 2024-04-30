import 'package:flutter/material.dart';

class NoteTileRemove extends StatelessWidget {
  final Function()? onDelete;

  const NoteTileRemove({super.key, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
