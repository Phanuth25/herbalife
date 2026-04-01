import 'package:project2/herbalife/public/model/product_model.dart';

class CartModel {
  static List<Product> items = [];

  static void add(Product product) {
    items.add(product);
  }
}