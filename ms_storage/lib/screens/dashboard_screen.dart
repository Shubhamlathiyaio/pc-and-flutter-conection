import 'package:flutter/material.dart';
import 'add_product_screen.dart';
import 'view_products_screen.dart';
import 'add_customer_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQL Server Store App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Store Management App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 40,
                ),
                textStyle: const TextStyle(fontSize: 18),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text('Add Product'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewProductsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 40,
                ),
                textStyle: const TextStyle(fontSize: 18),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text('View Products'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCustomerScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 40,
                ),
                textStyle: const TextStyle(fontSize: 18),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text('Add Customer'),
            ),
          ],
        ),
      ),
    );
  }
}
