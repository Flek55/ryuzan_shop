import 'package:supabase_flutter/supabase_flutter.dart';

class ProductInfo {
  static List<Map<String, dynamic>> data = [];

  static getData() async {
    final sbi = Supabase.instance.client;
    data = await sbi.from('products').select('*');
  }

  static updateCart(userId, userEmail, productId, operation) async {
    final sbi = Supabase.instance.client;
    List<dynamic> d =
        await sbi.from("carts").select("ids_amounts").eq("user_id", userId);
    Map<String, dynamic> amounts = d[0]["ids_amounts"];
    print(amounts);
    if (operation == "+") {
      if (amounts["${ProductInfo.data[productId]["name"]}"] != null) {
        amounts["${ProductInfo.data[productId]["name"]}"] += 1;
      } else {
        amounts["${ProductInfo.data[productId]["name"]}"] = 1;
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
    }else if(operation == "-"){
      if (amounts["${ProductInfo.data[productId]["name"]}"] == 1){
        amounts.remove(ProductInfo.data[productId]["name"]);
      }
      else if (amounts["${ProductInfo.data[productId]["name"]}"] != null) {
        amounts["${ProductInfo.data[productId]["name"]}"] -= 1;
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
  }
}
