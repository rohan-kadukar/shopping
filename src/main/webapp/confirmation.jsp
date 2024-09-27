<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        .confirmation-card {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .confirmation-card h2 {
            color: #28a745;
        }
        .confirmation-card p {
            margin: 20px 0;
        }
        .btn-home {
            background-color: #007bff;
            color: white;
        }
        .btn-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="confirmation-card">
        <h2>🎉 Purchase Successful!</h2>
        <p>Thank you for your purchase. We appreciate your business!</p>
        <a href="index.jsp" class="btn btn-home">Go back to Home</a>
    </div>
</body>
</html>
