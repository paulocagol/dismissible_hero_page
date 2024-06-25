import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'model/product.dart';
import 'page/product_detail.dart';
import 'page/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ProductList(),
    ),
    GoRoute(
      path: '/product/:name',
      pageBuilder: (context, state) {
        final product = state.extra as Product;
        return CustomTransitionPage(
          key: state.pageKey,
          child: ProductDetail(product: product),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          barrierColor: Colors.transparent,
          barrierDismissible: true,
          opaque: false,
        );
      },
    ),
  ],
);
