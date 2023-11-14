import 'package:flutter/material.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/bloc/product/product_bloc.dart';
import 'package:qrcode/routes/router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formAddProduct = FormGroup({
    'code': FormControl<String>(validators: [Validators.required]),
    'name': FormControl<String>(validators: [Validators.required]),
    'qty': FormControl<int>(validators: [Validators.required]),
    'price': FormControl<int>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ADD PRODUCT"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ADD PRODUCT'S FORM",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ReactiveForm(
                formGroup: formAddProduct,
                child: Column(
                  children: <Widget>[
                    ReactiveTextField(
                      formControlName: 'code',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Code"),
                      validationMessages: {
                        'required': (error) => "Product's code must not be empty !"
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Product's Name"),
                      validationMessages: {
                        'required': (error) => "Product's name must not be empty !"
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'qty',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Quantity"),
                      validationMessages: {
                        'required': (error) => "Product's quantity must not be empty !"
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'price',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Price"),
                      validationMessages: {
                        'required': (error) => "Product's price must not be empty !"
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 50,
                        width: 150,
                        child: ReactiveFormConsumer(builder: (context, formAddProduct, child) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<ProductBloc>().add(ProductEventAddProduct(
                                    code: formAddProduct.control('code').value,
                                    name: formAddProduct.control('name').value,
                                    qty: formAddProduct.control('qty').value,
                                    price: formAddProduct.control('price').value,
                                  ));
                            },
                            child: BlocConsumer<ProductBloc, ProductState>(
                              listener: (context, state) {
                                if (state is ProductStateError) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(state.message)));
                                }
                                if (state is ProductStateComplete) {
                                  context.pop();
                                }
                              },
                              builder: (context, state) {
                                return Text(
                                    state is ProductStateLoading ? "Loading..." : "Add Product");
                              },
                            ),
                          );
                        }))
                  ],
                )),
          ],
        ));
  }
}
