import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/notes.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    //final minHeight = getMinHeight(index);

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
        child: Center(
            child: ClipRect(
                child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1,
            sigmaY: 1,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
              minWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                width: 1.2,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(color: Colors.black),
                    ),
                    Icon(
                      note.isImportant ? Icons.star : null,
                      color: Colors.yellow,
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  note.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  note.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ))));
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
// Container(
//         constraints: const BoxConstraints(maxHeight: double.infinity),
//         padding: const EdgeInsets.all(8),
//         child: 
//       ),
