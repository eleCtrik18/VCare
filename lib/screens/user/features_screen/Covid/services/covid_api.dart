import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:v_care/screens/user/features_screen/Covid/models/world.dart';

import 'app_url.dart';

class WorldStatesViewModel {
  Future<WorldStatesModel> fetchWorldRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    print(response.statusCode.toString());
    print(data);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
