import 'package:currency_app/models/currency_model.dart';
import 'package:currency_app/provider/home_provider.dart';
import 'package:currency_app/repository/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        builder: (context, child) {
          return Scaffold(
              appBar: AppBar(title: Text("Provider App")),
              body: Builder(builder: (context) {
                var provider = Provider.of<HomeProvider>(context);
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.error.isNotEmpty) {
                  return Center(
                    child: Text(provider.error),
                  );
                } else {
                  return ListView.builder(itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(provider.data!.getAt(index)!.title.toString()),
                      trailing: Text(
                          provider.data!.getAt(index)!.nbuBuyPrice.toString()),
                    );
                  });
                }
              }));
        });
  }
}
