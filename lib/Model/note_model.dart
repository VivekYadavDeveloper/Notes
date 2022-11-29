//*** To Create a Note We Gonna Make Model Class
//**! @VivekYadavDev Github.

class NoteModel {
  int? id;
  String title;
  String body;
  DateTime creation_date;

  NoteModel(
      {this.id,
      required this.title,
      required this.body,
      required this.creation_date});

  //*? Create a function to convert our item into map
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creation_date": creation_date.toString()
    });
  }
}

///**! 28:04
///TODO
///https://www.youtube.com/watch?v=RGa4HJutK48
//! Fix Error 9:40
