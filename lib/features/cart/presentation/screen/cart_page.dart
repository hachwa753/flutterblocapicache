import 'package:flutter/material.dart';
import 'package:flutterapiecommerce/features/products/presentation/widgets/golo_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart Page")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    "https://m.media-amazon.com/images/I/61PwUsi+OgL._AC_SX522_.jpg",
                  ),
                  title: Text("Title"),
                  subtitle: Text("\$${2000}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GoloIcon(icon: Icon(Icons.remove), onTap: () {}),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "1",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GoloIcon(icon: Icon(Icons.add), onTap: () {}),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
