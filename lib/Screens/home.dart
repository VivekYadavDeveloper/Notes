import 'package:flutter/material.dart';
import 'package:notes/DB/database_provider.dart';
import 'package:provider/provider.dart';

import '../Model/note_model.dart';
import '../Themes/theme_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _toggleTheme() {
    final setting = Provider.of<ThemeModel>(context, listen: false);
    setting.toggleTheme();
  }

  //*** Getting All The Notes.
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Notes"),
          actions: <IconButton>[
            IconButton(
              onPressed: _toggleTheme,
              icon: const Icon(Icons.sunny),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return FutureBuilder(
              future: getNotes(),
              builder: (context, AsyncSnapshot noteData) {
                switch (noteData.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return const Center(child: CircularProgressIndicator());
                    }
                  case ConnectionState.done:
                    {
                      if (noteData.data == Null) {
                        return const Center(
                          child: Text("You Have No Data"),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: noteData.data.length,
                            itemBuilder: (context, index) {
                              //*** Setting the Different Item.
                              String title = noteData.data[index]['title'];
                              String body =
                                  noteData.data[index]['body'].toString();
                              String creation_date = noteData.data[index]
                                      ['creation_date']
                                  .toString();
                              int id = noteData.data[0]['id'];
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/ShowNote",
                                      arguments: NoteModel(
                                        title: title,
                                        body: body,
                                        creation_date:
                                            DateTime.parse(creation_date),
                                        id: id,
                                      ),
                                    );
                                  },
                                  title: Text(title),
                                  subtitle: Text(body),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    break;
                  case ConnectionState.active:
                    // TODO: Handle this case.
                    break;
                }
                return const Text("He");
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/CreateNote');
          },
          child: const Icon(Icons.note_add_rounded),
        ),
      ),
    );
  }
}
