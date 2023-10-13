// import 'package:dio/dio.dart';
// import 'package:flutter_applicatioaserwerwr/model/diomodels.dart';

// class dioDAta {
//   final Dio daio = new Dio();

//   // dioDAta(this.daio);
//   Future<List<Codeopject>> GetNews() async {
//     String basUrl = "https://newsapi.org";
//     String key = "c53536da2cb64c1c88729a1d2caeeab2";

//     Response response = await daio.get(
//         "$basUrl/v2/top-headlines?country=us&category=business&apiKey=$key");
//     Map<String, dynamic> jsondata = await response.data;

//     List<dynamic> Articals = await jsondata["articles"];
//     List<Codeopject> list_oject = [];

// // froem list <map > to list<opj>
//     for (var artical in Articals) {
//       Codeopject articlmodel = Codeopject(
//           title: artical["title"],
//           url: artical["urlToImage"],
//           subtitle: artical["description"]);
//       //add to it list_oject
//       list_oject.add(articlmodel);
//     }

//     return list_oject;
//   }
// }
