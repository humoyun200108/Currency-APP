import 'package:currency_app/models/currency_model.dart';
import 'package:dio/dio.dart';

class GetCurrencyService {
  Future<dynamic> getCurrency() async {
    try {
      Response response =
          await Dio().get("https://javiercbk.github.io/json_to_dart/");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => CurrencyModel.fromJson(e))
            .toList();
      } else {
        return response.statusMessage.toString();
      }
    } on DioError catch (e) {
      return e.message.toString();
    }
  }
}
