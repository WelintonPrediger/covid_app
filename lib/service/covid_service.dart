import 'dart:developer';

import 'package:covid19/app_config/app_config_export.dart';
import 'package:covid19/model/model_export.dart';
import 'package:covid19/network/network_export.dart';

abstract class CovidServiceHelper {
  Future<List<Covid>?> fetchAllData();
  Future<List<Covid>?> filterCovid({required List<dynamic> listFilters});
}

class CovidService extends CovidServiceHelper {

  @override
  Future<List<Covid>?> fetchAllData({int? page = 1, int? pageSize = 20}) async {

    log('Fetch All Data Service');
    log('URL: ${Constant.baseUrl}?page=$page&page_size=$pageSize');

    final response = await Network.internal().get(
      url: '${Constant.baseUrl}?page=$page&page_size=$pageSize',
      headers: _getHeaders()
    );

    log(response.toString());

    if(response != null) {
      List<dynamic> list = response['results'];

      List<Covid> listCovidData = list.map((covidData) => Covid.fromMap(covidData)).toList();
      log('List Covid: $listCovidData');
      return listCovidData;
    }

    return null;
  }

  @override
  Future<List<Covid>?> filterCovid({required List listFilters, int? page = 1, int? pageSize = 20}) async {

    log('Filter Covid Service');

    List<String> header = [];
    String query = "";

    if(listFilters[0] != null) { header.add('date=${listFilters[0]}'); }
    if(listFilters[1] != null) { header.add('state=${listFilters[1]}'); }
    if(listFilters[2] != null) { header.add('city_ibge_code=${listFilters[2]}'); }
    { header.add('page=$page'); }
    { header.add('page_size=$pageSize'); }
    if(header.isNotEmpty) {
      query = "?" + header.join(("&"));
    }

    log('URL: ${Constant.baseUrl}$query');

    final response = await Network.internal().get(
      url: '${Constant.baseUrl}$query',
      headers: _getHeaders()
    );

    log(response.toString());

    if(response != null) {
      List<dynamic> list = response['results'];

      List<Covid> listFiltered = list.map((covidData) => Covid.fromMap(covidData)).toList();
      log('List Covid: $listFiltered');
      return listFiltered;
    }

    return null;
  }

  Map<String,String> _getHeaders() {
    var headers = {
      "Authorization" : Constant.apiTokenAccess
    };
    return headers;
  }

}