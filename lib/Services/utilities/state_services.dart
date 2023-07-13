import 'dart:convert';

import 'package:covidapp/Model/WorldStatemodel.dart';
import 'package:covidapp/Services/utilities/app_url.dart';

import 'package:http/http.dart' as http;

class StateServices {
  // with model
  Future<WorldstateModel> fatchWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldstateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  // ignore: non_constant_identifier_names
  Future<List<dynamic>> CountriesListApi() async {
    //without model
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
