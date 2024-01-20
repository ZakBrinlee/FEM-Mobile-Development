import 'dart:developer';

import 'package:coffee_masters_zak/datamanager.dart';
import 'package:coffee_masters_zak/datamodel.dart';
import 'package:coffee_masters_zak/menuitem.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Category>>(
        future: dataManager.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Data retrieval is successful and ready
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // EACH CATEGORY STARTS HERE
                  var category = snapshot.data![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 8.0, left: 8.0),
                        child: Text(
                          category.name,
                          style: TextStyle(color: Colors.brown.shade400),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: category.products.length,
                        itemBuilder: (context, index) {
                          var p = category.products[index];
                          return MenuItem(
                            product: p,
                            onAddToCart: (addedProduct) =>
                                dataManager.cartAdd(addedProduct),
                          );
                        },
                      )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            // Data is missing due to an error
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
