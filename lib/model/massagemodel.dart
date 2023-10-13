class classMAssge {
  final String massge;

  classMAssge(this.massge);
  //هنا بيستقبل اوبجكت
  factory classMAssge.fromjson(datJason) {
    return classMAssge(datJason["name"]);
  }
}

class Note {
  final String? nameid;
  final String? age;
  final String? url;

  Note({required this.nameid, required this.age, required this.url});

  factory Note.fromjson(jsondat) {
    return Note(
      nameid: jsondat["nameid"],
      age: jsondat["age"],
      url: jsondat["url"],
    );
  }
}
