import 'package:flutter/material.dart';
import 'package:qrcode/bloc/auth/auth_bloc.dart';
import 'package:qrcode/routes/router.dart';
import 'package:qrcode/theme.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        title: Text(
          "Create a QR code for your product",
          style: bold,
          maxLines: 2,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Add Products";
              icon = Icons.post_add_rounded;
              onTap = () {
                context.goNamed(Routes.addProduct);
              };
              break;
            case 1:
              title = "Products";
              icon = Icons.list_alt;
              onTap = () => context.goNamed(Routes.products);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code_rounded;
              onTap = () {};
              break;
            case 3:
              title = "Catalog";
              icon = Icons.document_scanner_rounded;
              onTap = () {};
              break;
          }
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 4.0, color: Colors.black),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: semiBold,
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: primary,
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
            return const Icon(
              Icons.logout,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
