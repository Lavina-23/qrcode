import 'package:flutter/material.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/routes/router.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  // GoRouter.of(context).go('/settings');
                  context.goNamed(Routes.settings);
                },
                child: const Text("SETTINGS PAGE")),
            ElevatedButton(
                onPressed: () {
                  // GoRouter.of(context).go('/products');
                  context.goNamed(Routes.products);
                },
                child: const Text("PRODUCTS PAGE"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(AuthEventLogout());
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLogout) {
              context.goNamed(Routes.login);
            }
          },
          builder: (context, state) {
            return const Icon(Icons.logout);
          },
        ),
      ),
    );
  }
}
