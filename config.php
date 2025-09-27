<?php
// Database configuration - UPDATE WITH YOUR HOSTINGER DETAILS
define('DB_HOST', 'https://iamdesignmaker.me/');  // Usually 'localhost' for Hostinger
define('DB_USERNAME', 'u977059325_demo');
define('DB_PASSWORD', '~Lz21*wNI');
define('DB_NAME', 'u977059325_demo');

// Create connection
function getConnection() {
    $conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
    
    // Check connection
    if ($conn->connect_error) {
        die(json_encode([
            'success' => false,
            'message' => 'Connection failed: ' . $conn->connect_error
        ]));
    }
    
    return $conn;
}

// Set JSON header
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}
?>