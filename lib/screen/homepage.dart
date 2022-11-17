import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/notes_database.dart';
import '../model/notes.dart';
import '../widget/note_card.dart';
import 'edit_note_page.dart';
import 'note_detail.dart';

class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/20/f7/1c/20f71cdde62e168737cd5f4573a7eccd.jpg'),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : notes.isEmpty
                      ? const Text(
                          'No Notes',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )
                      : buildNotes(),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 80.0,
          width: 80.0,
          child: FloatingActionButton(
            backgroundColor: const Color(0xffff206e),
            child: const Icon(
              Icons.note_add_rounded,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AddEditNotePage()),
              );

              refreshNotes();
            },
          ),
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
