import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/bloc/product/product_bloc.dart';
import 'package:qrcode/models/product.dart';
import 'package:qrcode/routes/router.dart';
import 'package:qrcode/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DetailProductPage extends StatelessWidget {
  DetailProductPage(this.id, this.product, {super.key});

  final String id;
  final Products product;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formUpdateProduct = FormGroup({
      'code': FormControl<String>(value: product.code!),
      'name': FormControl<String>(value: product.name!),
      'qty': FormControl<int>(value: product.qty!),
      'price': FormControl<int>(value: product.price!),
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Product Details',
            style: bold,
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: product.code!,
                  size: 200,
                  version: QrVersions.auto,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Code',
                  style: medium,
                ),
                const SizedBox(
                  height: 10,
                ),
                ReactiveForm(
                    formGroup: formUpdateProduct,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ReactiveTextField(
                          formControlName: 'code',
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Product Name',
                          style: medium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveTextField(
                          formControlName: 'name',
                          controller: nameC,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Quantity',
                          style: medium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveTextField(
                          formControlName: 'qty',
                          controller: qtyC,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Price',
                          style: medium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveTextField(
                          formControlName: 'price',
                          controller: priceC,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          SizedBox(
                              height: 50,
                              width: 150,
                              child: ReactiveFormConsumer(
                                  builder: (context, formUpdateProduct, child) {
                                return ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<ProductBloc>()
                                          .add(ProductEventDeleteProduct(product.prodID!));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: BlocConsumer<ProductBloc, ProductState>(
                                      listener: (context, state) {
                                        if (state is ProductStateError) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(content: Text(state.message)));
                                        } else if (state is ProductStateComplete) {
                                          context.pop();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text((state).message)));
                                        }
                                      },
                                      builder: (context, state) {
                                        return Text(
                                          state is ProductStateLoading ? "Loading..." : "Delete",
                                          style: semiBold.copyWith(color: Colors.white),
                                        );
                                      },
                                    ));
                              })),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child:
                                ReactiveFormConsumer(builder: (context, formUpdateProduct, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (int.parse(qtyC.text) > 0) {
                                    context.read<ProductBloc>().add(ProductEventEditProduct(
                                          prodID: product.prodID!,
                                          name: formUpdateProduct.control('name').value,
                                          qty: formUpdateProduct.control('qty').value,
                                          price: formUpdateProduct.control('price').value,
                                        ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            title: Text('Attention !'),
                                            content: Text('There must be no empty fields'),
                                          );
                                        });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                ),
                                child: BlocConsumer<ProductBloc, ProductState>(
                                  listener: (context, state) {
                                    if (state is ProductStateError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text(state.message)));
                                    } else if (state is ProductStateComplete) {
                                      context.pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text((state).message)));
                                    }
                                  },
                                  builder: (context, state) {
                                    return Text(
                                        state is ProductStateLoading ? "Loading..." : "Update",
                                        style: semiBold.copyWith(color: Colors.white));
                                  },
                                ),
                              );
                            }),
                          ),
                        ])
                      ],
                    )),
              ],
            )
          ],
        ));
  }
}
