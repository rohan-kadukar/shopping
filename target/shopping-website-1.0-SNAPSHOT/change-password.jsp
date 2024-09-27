<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Change Password</title>
    <style>
        body {
            background-color: #f4f4f9;
            font-family: 'Arial', sans-serif;
        }
        .change-password-container {
            max-width: 400px;
            margin: auto;
            padding: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }
        .change-password-header {
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
        function validatePassword() {
            const password = document.getElementById('newPassword').value;
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
        <div class="change-password-container">
            <div class="change-password-header">
                <h2>Change Password</h2>
                <p>Please enter a new password</p>
            </div>
            <form action="ChangePasswordServlet" method="post" onsubmit="return validatePassword();">
                <input type="hidden" name="email" value="<%= request.getAttribute("email") %>"/>
                <div class="form-group">
                    <label for="newPassword">New Password:</label>
                    <input type="password" name="newPassword" class="form-control" id="newPassword" placeholder="Enter your new password" required>
                </div>
                <button type="submit" class="btn btn-custom btn-block">Change Password</button>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
            </form>
            <div class="options">
                <a href="login.jsp">Remembered your password? Login</a>
            </div>
        </div>
    </div>
</body>
</html>
