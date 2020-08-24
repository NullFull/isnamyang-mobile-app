import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:isnamyang/model/BarcodeInfo.dart';

class BarcodeApi {
  static const HOST = 'https://isnamyang.appspot.com/api/isnamyang';

  Future<BarcodeInfo> queryBarcode(String barcode) async {
    final response = await http.get(HOST + '?barcode=' + barcode);

    if (response.statusCode == 200) {
      return BarcodeInfo.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load');
    }
  }
}