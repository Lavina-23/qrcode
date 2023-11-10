import 'package:flutter/material.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/routes/router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = FormGroup({
    'email': FormControl<String>(value: 'mima@gmail.com'),
    'password': FormControl<String>(value: 'password'),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("LOGIN PAGE"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ReactiveForm(
                formGroup: form,
                child: Column(
                  children: <Widget>[
                    ReactiveTextField(
                      formControlName: 'email',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Email...'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Password...'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ReactiveFormConsumer(builder: (context, form, child) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthEventLogin(
                                  form.control('email').value, form.control('password').value));
                            },
                            child: BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthStateLogin) {
                                  context.goNamed(Routes.home);
                                }
                                if (state is AuthStateError) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(state.message),
                                    duration: const Duration(seconds: 2),
                                  ));
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthStateLoading) {
                                  return const Text("LOADING...");
                                }
                                return const Text("LOGIN");
                              },
                            ));
                      }),
                    )
                  ],
                )),
          ],
        ));
  }
}
