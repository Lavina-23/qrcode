import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode/pages/add_product.dart';
import 'package:qrcode/pages/detail_product.dart';
import 'package:qrcode/pages/error.dart';
import 'package:qrcode/pages/home.dart';
import 'package:qrcode/pages/login.dart';
import 'package:qrcode/pages/products.dart';

export 'package:go_router/go_router.dart';

part 'route_name.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    // cek autentikasi
    FirebaseAuth auth = FirebaseAuth.instance;
    print(auth.currentUser);
    if (auth.currentUser == null) {
      // ga login
      return "/login";
    } else {
      return null;
    }
  },
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(path: '/', name: Routes.home, builder: (context, state) => const Homepage(), routes: [
      GoRoute(
          path: 'products',
          name: Routes.products,
          builder: (context, state) => const ProductsPage(),
          routes: [
            GoRoute(
              path: ':id',
              name: Routes.detailProduct,
              builder: (context, state) => DetailProductPage(
                  state.pathParameters['id'].toString(), state.uri.queryParameters),
            ),
          ]),
      GoRoute(
        path: 'addProduct',
        name: Routes.addProduct,
        builder: (context, state) => const AddProductPage(),
      ),
    ]),
    GoRoute(
      path: '/login',
      name: Routes.login,
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
