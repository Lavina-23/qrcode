import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode/routes/router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PRODUCTS PAGE"),
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  // Routing Dynamic => pake path
                  // Gaiso lempar data, mbo gkro knopo, intine gnok queryparameter
                  // context.go("/products/${index + 1}");

                  // Routing Dynamic => pake route named
                  // Disarankan pake route named
                  context.goNamed(Routes.detailProduct, pathParameters: {
                    "id": "${index + 1}"
                  }, queryParameters: {
                    "id": "${index + 1}",
                    "title": "PRODUCT ${index + 1}",
                    "deskripsi": "Deskripsi product ${index + 1}"
                  });
                },
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: const Text("PRODUCT"),
                subtitle: Text("Deskripsi product ${index + 1}"),
              );
            }));
  }
}
