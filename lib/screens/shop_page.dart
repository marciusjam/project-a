import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', price: 29.99, image: 'https://via.placeholder.com/150'),
    Product(name: 'Product 2', price: 49.99, image: 'https://via.placeholder.com/150'),
    Product(name: 'Product 3', price: 19.99, image: 'https://via.placeholder.com/150'),
    Product(name: 'Product 4', price: 39.99, image: 'https://via.placeholder.com/150'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container( 
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image,
                    height: 70,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('\$${product.price.toStringAsFixed(2)}'),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Add to Cart action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} added to cart!')),
                        );
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            
          ); 
            },
        ),
      
    );
  }
}

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}