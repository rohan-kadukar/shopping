<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Something Went Wrong</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #333;
        }
        .error-container {
            text-align: center;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 3rem;
            color: #e74c3c;
        }
        p {
            font-size: 1.2rem;
            color: #555;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #2980b9;
        }
        .icon {
            font-size: 50px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        @media (max-width: 600px) {
            .error-container {
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="icon">⚠️</div> <!-- You can replace this with an image if needed -->
        <h1>Oops! Something went wrong</h1>
        <p><%= request.getParameter("message") != null ? request.getParameter("message") : "An unexpected error occurred." %></p>
        <a href="index.jsp">Return to Home</a>
    </div>
</body>
</html>
