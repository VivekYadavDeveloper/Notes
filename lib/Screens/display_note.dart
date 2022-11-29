import 'package:flutter/material.dart';
import 'package:notes/DB/database_provider.dart';
import 'package:notes/Model/note_model.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context)?.settings.arguments as NoteModel;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Note"),
          actions: [
            IconButton(
                onPressed: () {
                  DatabaseProvider.db.deleteNote(note.id!);
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => false);
                },
                icon: const Icon(
                  Icons.delete_rounded,
                ))
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  note.title,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15.0),
                Text(
                  note.body,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
