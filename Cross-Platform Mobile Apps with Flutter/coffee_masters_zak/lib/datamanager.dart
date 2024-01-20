import 'dart:convert';
import 'dart:developer';
import 'package:coffee_masters_zak/datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    try {
      const url = 'https://firtman.github.io/coffeemasters/api/menu.json';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _menu = [];
        var decodedData = jsonDecode(response.body) as List<dynamic>;
        for (var json in decodedData) {
          _menu?.add(Category.fromJson(json));
        }
      } else {
        throw Exception("Error loading data");
      }
    } catch (e) {
      throw Exception("Error loading data");
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }

  cartAdd(Product p) {
    bool found = false;
    log('inside cartAdd with product');

    for (var item in cart) {
      log("inside cartAdd loop");

      if (item.product.id == p.id) {
        log("found item in cart = add quantity");
        item.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      log("item not in cart, call add");
      cart.add(ItemInCart(product: p, quantity: 1));
    }
  }

  cartRemove(Product p) {
    log("cartRemove");
    cart.removeWhere((item) => item.product.id == p.id);
  }

  cartClear() {
    log("cartClear");
    cart.clear();
  }

  double cartTotal() {
    double total = 0;
    for (var item in cart) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
