import 'package:flutter/material.dart';
import 'package:notes/DB/database_provider.dart';
import 'package:notes/Model/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  //**! Create a function to add new data.

  late String title;
  late String body;
  late DateTime date;
  //**? Create a Controller for Textfield.
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print("Your Note Added Successfully");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Your Note"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: " Give Title",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      child: TextField(
                        controller: bodyController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 15,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: " Enter Your Note",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = bodyController.text;
              date = DateTime.now();
            });
            NoteModel note = NoteModel(
              title: title,
              body: body,
              creation_date: date,
            );
            addNote(note);
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
          tooltip: "Save Note",
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
