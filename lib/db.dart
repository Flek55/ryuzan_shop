import 'package:supabase_flutter/supabase_flutter.dart';

class ProductInfo{
  static List<Map<String, dynamic>> data = [];

  static getData() async {
    final sbi = Supabase.instance.client;
    data = await sbi
        .from('products')
        .select('*');
  }
}