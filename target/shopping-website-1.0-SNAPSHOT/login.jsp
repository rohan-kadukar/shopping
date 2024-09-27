<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <title>Login</title>
    <style>
        body {
            background-color: #f4f4f9;
            font-family: 'Arial', sans-serif;
        }
        .login-container {
            max-width: 400px;
            margin: auto;
            padding: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        .login-header {
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
        .options {
            text-align: center;
            margin-top: 20px;
        }
        .options a {
            color: #007bff;
        }
        .options a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function validateLogin() {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            // Validate email format
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
            // Validate password length
            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }
            return true; // Validation passed
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-header">
                <h2>Welcome Back!</h2>
                <p>Please login to your account</p>
            </div>
            <form action="LoginServlet" method="post" onsubmit="return validateLogin();">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" class="form-control" id="password" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn btn-custom btn-block">Login</button>
                <div class="options">
                    <a href="forgot-password.jsp">Forgot Password?</a>
                    <span class="mx-2"> | </span>
                    <a href="register.jsp">Don't have an account? Register</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>