<?php
// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h2>Debug Information</h2>";

// Check if config file exists
if (file_exists('config.php')) {
    echo "<p>✅ config.php file exists</p>";
    
    // Try to include config
    try {
        require_once 'config.php';
        echo "<p>✅ config.php loaded successfully</p>";
        
        // Test database connection
        try {
            $conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
            
            if ($conn->connect_error) {
                echo "<p>❌ Database connection failed: " . $conn->connect_error . "</p>";
                echo "<p>Host: " . DB_HOST . "</p>";
                echo "<p>Username: " . DB_USERNAME . "</p>";
                echo "<p>Database: " . DB_NAME . "</p>";
            } else {
                echo "<p>✅ Database connection successful!</p>";
                
                // Check if student table exists
                $result = $conn->query("SHOW TABLES LIKE 'student'");
                if ($result->num_rows > 0) {
                    echo "<p>✅ Student table exists</p>";
                    
                    // Count students
                    $count = $conn->query("SELECT COUNT(*) as count FROM student");
                    $row = $count->fetch_assoc();
                    echo "<p>📊 Students in database: " . $row['count'] . "</p>";
                } else {
                    echo "<p>❌ Student table does not exist</p>";
                    echo "<p>Please create the student table first</p>";
                }
                
                $conn->close();
            }
        } catch (Exception $e) {
            echo "<p>❌ Database error: " . $e->getMessage() . "</p>";
        }
        
    } catch (Exception $e) {
        echo "<p>❌ Config file error: " . $e->getMessage() . "</p>";
    }
} else {
    echo "<p>❌ config.php file not found</p>";
}

echo "<p>PHP Version: " . phpversion() . "</p>";
echo "<p>Current directory: " . getcwd() . "</p>";
echo "<p>Files in directory:</p>";
echo "<ul>";
foreach (glob("*") as $file) {
    echo "<li>" . $file . "</li>";
}
echo "</ul>";
?>