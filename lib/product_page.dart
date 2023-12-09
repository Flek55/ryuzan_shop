import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'db.dart';

class ProductPage extends StatefulWidget {
  final int productIndex;
  final Future<void> notifyParent;

  const ProductPage({Key? key, required this.productIndex, required this.notifyParent}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final Map<String, dynamic> pageData;

  @override
  void initState() {
    pageData = ProductInfo.data[widget.productIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(pageData["name"],
              style: const TextStyle(
                  fontFamily: "Roboto", fontSize: 20, color: Colors.white)),
          backgroundColor: const Color(0xFF333333),
          actions: [
            IconButton(
              onPressed: () async {
                await ProductInfo.updateCart(
                    Supabase.instance.client.auth.currentUser?.id,
                    Supabase.instance.client.auth.currentUser?.email,
                    widget.productIndex, "+");
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 15)),
          ],
        ),
        body: Column(children: [
          const Padding(padding: EdgeInsets.all(20)),
          FittedBox(
              child: Image.network(
            ProductInfo.data[widget.productIndex]["link"],
            scale: 6,
            fit: BoxFit.fill,
            height: 350,
            width: 350,
          )),
          Row(children: [
            const Padding(padding: EdgeInsets.only(left: 30)),
            const Text("\nОписание: ",
                style: TextStyle(
                    fontFamily: "Roboto", fontSize: 16, color: Colors.black)),
            Text("\n\n${pageData["description"]}\n",
                style: const TextStyle(
                    fontFamily: "Roboto", fontSize: 16, color: Colors.black))
          ]),
          Row(children: [
            const Padding(padding: EdgeInsets.only(left: 30, top: 20)),
            const Text("Цена:\t",
                style: TextStyle(
                    fontFamily: "Roboto", fontSize: 16, color: Colors.black)),
            Text("₽${pageData["price"]}",
                style: const TextStyle(
                    fontFamily: "Roboto", fontSize: 16, color: Colors.black))
          ]),
          IconButton(onPressed: () async {
            await ProductInfo.updateCart(
                Supabase.instance.client.auth.currentUser?.id,
                Supabase.instance.client.auth.currentUser?.email,
                widget.productIndex, "-");
            widget.notifyParent;
          }, icon: Icon(Icons.remove))
        ]));
  }
}
