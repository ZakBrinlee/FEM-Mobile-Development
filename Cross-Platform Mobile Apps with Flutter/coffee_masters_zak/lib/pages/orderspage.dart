import 'package:coffee_masters_zak/datamanager.dart';
import 'package:coffee_masters_zak/orderitem.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final DataManager dataManager;
  const OrderPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataManager.cart.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Your order is empty"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.dataManager.cart.length,
                itemBuilder: (context, index) {
                  var item = widget.dataManager.cart[index];
                  return OrderItem(
                      item: item,
                      onRemove: (product) {
                        setState(() {
                          widget.dataManager.cartRemove(product);
                        });
                      });
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Total: \$${widget.dataManager.cartTotal().toStringAsFixed(2)}"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const OrderAlert());
                    setState(() {
                      // we update the cart within setState so the current widget will get re-rendered
                      widget.dataManager.cartClear();
                    });
                  },
                  child: const Text(
                    "Send Order",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}

class OrderAlert extends StatelessWidget {
  const OrderAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Your Order"),
      content: const Text("Your order is being prepared. Thanks!"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'))
      ],
    );
  }
}
