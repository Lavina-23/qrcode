part of 'product_bloc.dart';

abstract class ProductEvent {}

// action
// 1. add product
// 2. edit product
// 3. delete product

class ProductEventAddProduct extends ProductEvent {
  ProductEventAddProduct(
      {required this.code, required this.name, required this.qty, required this.price});

  String code;
  String name;
  int qty;
  int price;
}

class ProductEventEditProduct extends ProductEvent {}

class ProductEventDeleteProduct extends ProductEvent {}
