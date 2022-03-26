import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:v_care/services/api/healthNews/health_model.dart';

Future<List<NewsApiModel>> getNews() async {
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/everything?q=medicine&from=2022-03-23&to=2022-03-23&sortBy=popularity&apiKey=8370d8a0ab4b4ac3826de3ac63402aca");

  final response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);

    List _articalsList = map['articles'];

    List<NewsApiModel> newsList = _articalsList
        .map((jsonData) => NewsApiModel.fromJson(jsonData))
        .toList();

    print(_articalsList);

    return newsList;
  } else {
    print("error");
    return [];
  }
}
