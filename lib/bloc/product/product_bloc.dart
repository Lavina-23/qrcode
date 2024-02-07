import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrcode/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Products>> streamProducts() async* {
    yield* firestore
        .collection('products')
        .withConverter(
            fromFirestore: (snapshot, _) => Products.fromJson(snapshot.data()!),
            toFirestore: (product, _) => product.toJson())
        .snapshots();
  }

  ProductBloc() : super(ProductStateInitial()) {
    on<ProductEventAddProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());

        var hasil = await firestore
            .collection("products")
            .add({"code": event.code, "name": event.name, "qty": event.qty, "price": event.price});

        await firestore.collection("products").doc(hasil.id).update({
          "prodID": hasil.id,
        });
        emit(ProductStateComplete("Produk Berhasil Ditambahkan !"));
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak bisa menambah produk"));
      } catch (e) {
        emit(ProductStateError("Tidak bisa menambah produk !"));
      }
    });
    on<ProductEventEditProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());

        await firestore
            .collection("products")
            .doc(event.prodID)
            .update({"name": event.name, "qty": event.qty, "price": event.price});
        emit(ProductStateComplete("Produk Berhasil Diupdate !"));
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak bisa mengupdate produk"));
      } catch (e) {
        emit(ProductStateError("Tidak bisa mengupdate produk !"));
      }
    });
    on<ProductEventDeleteProduct>((event, emit) async {
      try {
        emit(ProductStateLoading());
        await firestore.collection("products").doc(event.id).delete();
        emit(ProductStateComplete("Produk Berhasil Dihapus !"));
      } on FirebaseException catch (e) {
        emit(ProductStateError(e.message ?? "Tidak bisa menghapus produk"));
      } catch (e) {
        emit(ProductStateError("Tidak bisa menghapus produk !"));
      }
    });
  }
}
