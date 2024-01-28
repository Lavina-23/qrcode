import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/bloc/product/product_bloc.dart';
import 'package:qrcode/models/product.dart';
import 'package:qrcode/utils/currency_format.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = context.read<ProductBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: StreamBuilder<QuerySnapshot<Products>>(
        stream: productBloc.streamProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Tidak dapat mengambil data !"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Tidak ada data !"),
            );
          }

          List<Products> allProducts = [];
          for (var e in snapshot.data!.docs) {
            allProducts.add(e.data());
          }
          if (allProducts.isEmpty) {
            return const Center(
              child: Text("Tidak ada data !"),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: allProducts.length,
            itemBuilder: (context, i) {
              Products product = allProducts[i];
              int price = product.price!;
              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 140,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.code!,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(product.name!),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(CurrencyFormat.formatToIDR(price)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Stok : ${product.qty}")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: QrImageView(
                            data: product.code!,
                            size: 200,
                            version: QrVersions.auto,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
