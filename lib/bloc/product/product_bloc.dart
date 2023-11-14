import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductStateInitial()) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    on<ProductEventAddProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());

        var hasil = await firestore
            .collection("products")
            .add({"code": event.code, "name": event.name, "qty": event.qty, "price": event.price});

        await firestore.collection("products").doc(hasil.id).update({
          "prodID": hasil.id,
        });
        emit(ProductStateComplete());
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidan bisa menambah produk"));
      } catch (e) {
        emit(ProductStateError("Tidak bisa menambah produk !"));
      }
    });
    on<ProductEventEditProduct>((event, emit) {
      //
    });
    on<ProductEventDeleteProduct>((event, emit) {
      //
    });
  }
}
