<?php
require_once 'config.php';

$method = $_SERVER['REQUEST_METHOD'];
$input = json_decode(file_get_contents('php://input'), true);

switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            getStudent($_GET['id']);
        } else {
            getAllStudents();
        }
        break;
    case 'POST':
        addStudent($input);
        break;
    case 'PUT':
        if (isset($_GET['id'])) {
            updateStudent($_GET['id'], $input);
        } else {
            echo json_encode(['success' => false, 'message' => 'Student ID required for update']);
        }
        break;
    case 'DELETE':
        if (isset($_GET['id'])) {
            deleteStudent($_GET['id']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Student ID required for delete']);
        }
        break;
    default:
        echo json_encode(['success' => false, 'message' => 'Method not allowed']);
        break;
}

function getAllStudents() {
    $conn = getConnection();
    
    $sql = "SELECT * FROM student ORDER BY id DESC";
    $result = $conn->query($sql);
    
    $students = [];
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $students[] = $row;
        }
    }
    
    echo json_encode([
        'success' => true,
        'data' => $students,
        'count' => count($students)
    ]);
    
    $conn->close();
}

function getStudent($id) {
    $conn = getConnection();
    
    $stmt = $conn->prepare("SELECT * FROM student WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $student = $result->fetch_assoc();
        echo json_encode([
            'success' => true,
            'data' => $student
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Student not found'
        ]);
    }
    
    $stmt->close();
    $conn->close();
}

function addStudent($data) {
    $conn = getConnection();
    
    // Validate required fields
    if (!isset($data['first_name']) || !isset($data['last_name']) || !isset($data['email'])) {
        echo json_encode([
            'success' => false,
            'message' => 'First name, last name, and email are required'
        ]);
        return;
    }
    
    $first_name = $data['first_name'];
    $last_name = $data['last_name'];
    $email = $data['email'];
    $date_of_birth = isset($data['date_of_birth']) ? $data['date_of_birth'] : null;
    $enrollment_date = isset($data['enrollment_date']) ? $data['enrollment_date'] : date('Y-m-d H:i:s');
    
    $stmt = $conn->prepare("INSERT INTO student (first_name, last_name, email, date_of_birth, enrollment_date) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $first_name, $last_name, $email, $date_of_birth, $enrollment_date);
    
    if ($stmt->execute()) {
        echo json_encode([
            'success' => true,
            'message' => 'Student added successfully',
            'student_id' => $conn->insert_id
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Error adding student: ' . $stmt->error
        ]);
    }
    
    $stmt->close();
    $conn->close();
}

function updateStudent($id, $data) {
    $conn = getConnection();
    
    // Check if student exists
    $check_stmt = $conn->prepare("SELECT id FROM student WHERE id = ?");
    $check_stmt->bind_param("i", $id);
    $check_stmt->execute();
    $check_result = $check_stmt->get_result();
    
    if ($check_result->num_rows == 0) {
        echo json_encode([
            'success' => false,
            'message' => 'Student not found'
        ]);
        $check_stmt->close();
        $conn->close();
        return;
    }
    $check_stmt->close();
    
    // Build update query dynamically
    $fields = [];
    $values = [];
    $types = '';
    
    if (isset($data['first_name'])) {
        $fields[] = 'first_name = ?';
        $values[] = $data['first_name'];
        $types .= 's';
    }
    if (isset($data['last_name'])) {
        $fields[] = 'last_name = ?';
        $values[] = $data['last_name'];
        $types .= 's';
    }
    if (isset($data['email'])) {
        $fields[] = 'email = ?';
        $values[] = $data['email'];
        $types .= 's';
    }
    if (isset($data['date_of_birth'])) {
        $fields[] = 'date_of_birth = ?';
        $values[] = $data['date_of_birth'];
        $types .= 's';
    }
    if (isset($data['enrollment_date'])) {
        $fields[] = 'enrollment_date = ?';
        $values[] = $data['enrollment_date'];
        $types .= 's';
    }
    
    if (empty($fields)) {
        echo json_encode([
            'success' => false,
            'message' => 'No fields to update'
        ]);
        $conn->close();
        return;
    }
    
    $values[] = $id;
    $types .= 'i';
    
    $sql = "UPDATE student SET " . implode(', ', $fields) . " WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param($types, ...$values);
    
    if ($stmt->execute()) {
        echo json_encode([
            'success' => true,
            'message' => 'Student updated successfully'
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Error updating student: ' . $stmt->error
        ]);
    }
    
    $stmt->close();
    $conn->close();
}

function deleteStudent($id) {
    $conn = getConnection();
    
    // Check if student exists
    $check_stmt = $conn->prepare("SELECT id FROM student WHERE id = ?");
    $check_stmt->bind_param("i", $id);
    $check_stmt->execute();
    $check_result = $check_stmt->get_result();
    
    if ($check_result->num_rows == 0) {
        echo json_encode([
            'success' => false,
            'message' => 'Student not found'
        ]);
        $check_stmt->close();
        $conn->close();
        return;
    }
    $check_stmt->close();
    
    $stmt = $conn->prepare("DELETE FROM student WHERE id = ?");
    $stmt->bind_param("i", $id);
    
    if ($stmt->execute()) {
        echo json_encode([
            'success' => true,
            'message' => 'Student deleted successfully'
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Error deleting student: ' . $stmt->error
        ]);
    }
    
    $stmt->close();
    $conn->close();
}
?>