import 'package:flutter/material.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/bloc/product/product_bloc.dart';
import 'package:qrcode/routes/router.dart';
import 'package:qrcode/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

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
          title: Text(
            "Add Your Product",
            style: bold,
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 20,
            ),
            Text("Product Code", style: medium),
            const SizedBox(
              height: 10,
            ),
            ReactiveForm(
                formGroup: formAddProduct,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ReactiveTextField(
                      formControlName: 'code',
                      controller: codeC,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validationMessages: {
                        'required': (error) => "Product's code must not be empty !"
                      },
                    ),
                    Text("Product Name", style: medium),
                    const SizedBox(
                      height: 10,
                    ),
                    ReactiveTextField(
                      formControlName: 'name',
                      controller: nameC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validationMessages: {
                        'required': (error) => "Product's name must not be empty !"
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Quantity", style: medium),
                    const SizedBox(
                      height: 10,
                    ),
                    ReactiveTextField(
                      formControlName: 'qty',
                      controller: qtyC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validationMessages: {
                        'required': (error) => "Product's quantity must not be empty !"
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Price", style: medium),
                    const SizedBox(
                      height: 10,
                    ),
                    ReactiveTextField(
                      formControlName: 'price',
                      controller: priceC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validationMessages: {
                        'required': (error) => "Product's price must not be empty !"
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                          height: 50,
                          width: 150,
                          child: ReactiveFormConsumer(builder: (context, formAddProduct, child) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primary),
                              onPressed: () {
                                if (codeC.text.length == 10 && int.parse(qtyC.text) > 0) {
                                  context.read<ProductBloc>().add(ProductEventAddProduct(
                                        code: formAddProduct.control('code').value,
                                        name: formAddProduct.control('name').value,
                                        qty: formAddProduct.control('qty').value,
                                        price: formAddProduct.control('price').value,
                                      ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Error'),
                                          content: Text('Invalid Quantity !'),
                                        );
                                      });
                                }
                              },
                              child: BlocConsumer<ProductBloc, ProductState>(
                                listener: (context, state) {
                                  if (state is ProductStateError) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(state.message)));
                                  }
                                  if (state is ProductStateComplete) {
                                    context.pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text((state).message)));
                                  }
                                },
                                builder: (context, state) {
                                  return Text(
                                    state is ProductStateLoading ? "Loading..." : "SAVE",
                                    style: semiBold.copyWith(color: Colors.white),
                                  );
                                },
                              ),
                            );
                          })),
                    )
                  ],
                )),
          ],
        ));
  }
}
