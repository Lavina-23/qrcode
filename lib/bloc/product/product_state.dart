part of 'product_bloc.dart';

abstract class ProductState {}

// state / kondisi
// 1. Product awal -> kososng
// 2. Product loading
// 3. Product complete -> berhasil dapet data product
// 4. Product error -> gagal dapet product

class ProductStateInitial extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateComplete extends ProductState {
  ProductStateComplete(this.message);

  final String message;
}

class ProductStateError extends ProductState {
  ProductStateError(this.message);

  final String message;
}
