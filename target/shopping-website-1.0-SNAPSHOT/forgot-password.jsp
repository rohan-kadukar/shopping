<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Forgot Password</title>
    <style>
        body {
            background-color: #f4f4f9;
            font-family: 'Arial', sans-serif;
        }
        .forgot-password-container {
            max-width: 400px;
            margin: auto;
            padding: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }
        .forgot-password-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-control {
            border-radius: 5px;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            border-radius: 5px;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
    <script>
        function validateEmail() {
            const email = document.getElementById('email').value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
            return true; // Validation passed
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="forgot-password-container">
            <div class="forgot-password-header">
                <h2>Forgot Password</h2>
                <p>Please enter your email address to reset your password</p>
            </div>
            <form action="ForgotPasswordServlet" method="post" onsubmit="return validateEmail();">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email" required>
                </div>
                <button type="submit" class="btn btn-custom btn-block">Send Reset Link</button>
                <div class="options">
                    <a href="login.jsp">Remembered your password? Login</a>
                </div>
            </form>
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
        </div>
    </div>
</body>
</html>
