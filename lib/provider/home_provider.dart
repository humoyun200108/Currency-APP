import 'package:currency_app/models/currency_model.dart';
import 'package:currency_app/repository/currency_repository.dart';
import 'package:currency_app/service/get_currency_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {}
  bool isLoading = false;
  Box<CurrencyModel>? data;
  String error = "";
  CurrencyRepository currencyRepository = CurrencyRepository();
  void getCurrency() async {
    isLoading = true;
    notifyListeners();
    dynamic response = await currencyRepository.getCurrency();
    if (response is Box<CurrencyModel>) {
      data = response;
      isLoading = false;
      notifyListeners();
    } else {
      error = response;
      isLoading = false;
      notifyListeners();
    }
  }
}
