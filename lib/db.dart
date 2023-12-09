import 'package:ryozan_shop/start.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductInfo {
  static List<Map<String, dynamic>> data = [];
  static List<Map<String, dynamic>> cart = [];

  static getData() async {
    final sbi = Supabase.instance.client;
    data = await sbi.from('products').select('*');
  }

  static getCart(userId) async{
    cart = [];
    final sbi = Supabase.instance.client;
    List<dynamic> temp = await sbi.from("carts").select("ids_amounts").eq("user_id", userId);
    Map<String, dynamic> a = temp[0]["ids_amounts"];
    a.forEach((k, v) => cart.add({k:v}));
    StartState.cart = ProductInfo.cart;
  }

  static getCartic(userId, userEmail) async {
    final sbi = Supabase.instance.client;
    Map<String, dynamic> amounts = {};
    List<Map<String, dynamic>> ans = [];
    List<dynamic> d =
        await sbi.from("carts").select("ids_amounts").eq("user_id", userId);
    if (d.isNotEmpty) {
      amounts = d[0]["ids_amounts"];
    }
    for (final a in amounts.keys) {
      for (int j = 0; j < data.length; j++) {
        if ((data[j]["id"]).toString() == a) {
          ans.add({"${data[j]["name"]}" : amounts[a]});
        }
      }
    }
    return ans;
  }

  static updateCart(userId, userEmail, productId, operation) async {
    productId += 1;
    final sbi = Supabase.instance.client;
    Map<String, dynamic> amounts = {};
    List<dynamic> d =
        await sbi.from("carts").select("ids_amounts").eq("user_id", userId);
    if (d.isNotEmpty) {
      amounts = d[0]["ids_amounts"];
    }
    if (operation == "+") {
      if (amounts["$productId"] != null) {
        amounts["$productId"] += 1;
      } else {
        amounts["$productId"] = 1;
      }
      try {
        await sbi.from("carts").insert(
            {"user_id": userId, "email": userEmail, "ids_amounts": amounts});
      } on PostgrestException {
        await sbi.from("carts").update({
          "user_id": userId,
          "email": userEmail,
          "ids_amounts": amounts
        }).eq("user_id", userId);
      }
    } else if (operation == "-") {
      if (amounts["$productId"] == 1) {
        amounts.remove(productId.toString());
      } else if (amounts["$productId"] != null) {
        amounts["$productId"] -= 1;
      }
      try {
        await sbi.from("carts").insert(
            {"user_id": userId, "email": userEmail, "ids_amounts": amounts});
      } on PostgrestException {
        await sbi.from("carts").update({
          "user_id": userId,
          "email": userEmail,
          "ids_amounts": amounts
        }).eq("user_id", userId);
      }
    }
    await ProductInfo.getCart(userId);
    StartState.cart = ProductInfo.cart;
  }
}