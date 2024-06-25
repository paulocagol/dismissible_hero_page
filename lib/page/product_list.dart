import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/product.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});

  final List<Product> products = [
    Product(name: 'Product 1 with a very long name that wraps', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Product 2 with a very long name that wraps', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Product 3 with a very long name that wraps', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Product 4 with a very long name that wraps', imageUrl: 'https://via.placeholder.com/150'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 2 / 3,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/product/${product.name}',
          extra: product,
        );
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'product-image-${product.name}',
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Hero(
              tag: 'product-name-${product.name}',
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  product.name,
                  style: const TextStyle(fontSize: 14.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
