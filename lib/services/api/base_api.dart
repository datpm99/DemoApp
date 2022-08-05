import 'dart:convert';

abstract class BaseApiService {
  dynamic getDataFromResponse(dynamic response, {bool isEncode = true}) {
    var data = response is String ? jsonDecode(response) : response.data;
    if (isEncode) {
      return jsonEncode(data);
    } else {
      return data;
    }
  }
}
