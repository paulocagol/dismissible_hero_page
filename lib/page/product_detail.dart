import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../dismissible_page.dart';
import '../model/product.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => context.pop(),
      direction: DismissDirection.horizontal,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: 'product-image-${product.name}',
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 16,
              right: 16,
              child: Hero(
                tag: 'product-name-${product.name}',
                child: Material(
                  type: MaterialType.transparency,
                  child: Center(
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 24.0, color: Colors.white, shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                        ),
                      ]),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
