import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'api_service.dart';

class ProductService {
  // Add a new product
  static Future<bool> addProduct(Product product) async {
    try {
      final response = await ApiService.post('add_product.php', {
        'name': product.name,
        'price': product.price.toString(),
        'category': product.category,
      });

      // Print response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Check if the product was added successfully
      if (response.statusCode == 200) {
        // Check if the response contains the success message
        return response.body.contains('✅ Product added successfully!');
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
      return false;
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  // Get all products
  static Future<List<Product>> getProducts() async {
    try {
      final response = await ApiService.get('view_products.php');

      print('Products response status: ${response.statusCode}');
      print('Products response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the HTML response to extract product data
        // This is a simplified parser - in a real app, you might want to use a proper HTML parser
        List<Product> products = [];

        // Extract product data from the HTML table
        // This is a basic implementation - you might need to adjust based on your actual HTML structure
        String html = response.body;

        // Find the table rows (this is a simplified approach)
        RegExp tableRegex = RegExp(
          r'<tr>\s*<td>(\d+)</td>\s*<td>([^<]+)</td>\s*<td>\$?([^<]+)</td>\s*<td>([^<]+)</td>\s*</tr>',
        );
        Iterable<RegExpMatch> matches = tableRegex.allMatches(html);

        for (var match in matches) {
          try {
            int id = int.parse(match.group(1)!);
            String name = match.group(2)!;
            double price = double.parse(match.group(3)!);
            String category = match.group(4)!;

            products.add(
              Product(id: id, name: name, price: price, category: category),
            );
          } catch (e) {
            // Skip invalid rows
            print('Error parsing product row: $e');
            continue;
          }
        }

        return products;
      } else {
        print('HTTP Error fetching products: ${response.statusCode}');
        print('Response: ${response.body}');
      }
      return [];
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
