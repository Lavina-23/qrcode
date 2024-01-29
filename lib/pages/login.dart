import 'package:flutter/material.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/routes/router.dart';
import 'package:qrcode/theme.dart';
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
        body: ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/img/hero-login.png'),
              Text("Hello, \nNice To Meet You !", style: bold)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ReactiveForm(
              formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Email',
                    style: medium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReactiveTextField(
                    formControlName: 'email',
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: medium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReactiveTextField(
                    formControlName: 'password',
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ReactiveFormConsumer(builder: (context, form, child) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
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
                                  return Text("LOADING...",
                                      style: medium.copyWith(color: Colors.white));
                                }
                                return Text(
                                  "LOGIN",
                                  style: medium.copyWith(color: Colors.white),
                                );
                              },
                            ));
                      }),
                    ),
                  )
                ],
              )),
        ),
      ],
    ));
  }
}
