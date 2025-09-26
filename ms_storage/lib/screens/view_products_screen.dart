import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ViewProductsScreen extends StatefulWidget {
  const ViewProductsScreen({super.key});

  @override
  State<ViewProductsScreen> createState() => _ViewProductsScreenState();
}

class _ViewProductsScreenState extends State<ViewProductsScreen> {
  late Future<List<Product>> _productsFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    _productsFuture = ProductService.getProducts();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadProducts),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Error loading products'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadProducts,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found'));
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$${product.price.toStringAsFixed(2)}'),
                              Text(product.category),
                            ],
                          ),
                          trailing: Text('#${product.id}'),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No products available'));
                }
              },
            ),
    );
  }
}
