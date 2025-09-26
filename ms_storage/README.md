# SQL Server Store App

A Flutter application that connects to a SQL Server database through a PHP API.

## Features

- Add products to the database
- View all products
- Add customers to the database

## Setup Instructions

1. Make sure you have Flutter installed on your machine
2. Navigate to the project directory:
   ```
   cd ms_storage
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Update the API service URL in `lib/services/api_service.dart` to match your server URL
5. Make sure your PHP server is running with the API files
6. Run the app:
   ```
   flutter run
   ```

## Project Structure

- `lib/models/` - Data models (Product, Customer)
- `lib/services/` - API services (ProductService, CustomerService)
- `lib/screens/` - UI screens (Dashboard, Add Product, View Products, Add Customer)
- `lib/main.dart` - Entry point of the application

## API Endpoints

The app communicates with the following PHP endpoints:
- `add_product.php` - Add a new product
- `view_products.php` - View all products
- `add_customer.php` - Add a new customer

## Dependencies

- `http` - For making HTTP requests to the PHP API