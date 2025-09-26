import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';
import 'api_service.dart';

class CustomerService {
  // Add a new customer
  static Future<bool> addCustomer(Customer customer) async {
    try {
      final response = await ApiService.post('add_customer.php', {
        'name': customer.name,
        'email': customer.email,
        'phone': customer.phone,
      });

      // Check if the customer was added successfully
      if (response.statusCode == 200) {
        // Check if the response contains the success message
        return response.body.contains('✅ Customer added successfully!');
      }
      return false;
    } catch (e) {
      print('Error adding customer: $e');
      return false;
    }
  }
}
