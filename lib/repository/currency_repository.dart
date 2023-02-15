import 'dart:io';

import 'package:currency_app/models/currency_model.dart';
import 'package:currency_app/service/get_currency_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class CurrencyRepository {
  GetCurrencyService getCurrencyService = GetCurrencyService();
  Box<CurrencyModel>? currencyBox;
  Future<dynamic> getCurrency() async {
    dynamic response = await getCurrencyService.getCurrency();
    if (response is List<CurrencyModel>) {
      await openBox();
      await writeToBox(response);
    } else {
      return response;
    }
  }

  void registerAdapter() {
    Hive.registerAdapter(CurrencyModelAdapter());
  }

  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    currencyBox = await Hive.openBox<CurrencyModel>("currency");
  }

  Future<void> writeToBox(List<CurrencyModel> data) async {
    await currencyBox!.clear();
    for (CurrencyModel element in data) {
      await currencyBox!.add(element);
    }
  }
}
