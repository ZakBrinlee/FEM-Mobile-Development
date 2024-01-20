import 'package:coffee_masters_zak/datamodel.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final ItemInCart item;
  final Function onRemove;
  const OrderItem({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("${item.quantity}x"),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "\$${(item.product.price * item.quantity).toStringAsFixed(2)}",
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  onRemove(item.product);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
