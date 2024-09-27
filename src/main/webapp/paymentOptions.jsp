<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="connect.DBConnection" %>

<html>
<head>
    <title>Payment Options</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Select Payment Method</h2>
        <form action="PaymentServlet" method="post">
            <input type="hidden" name="totalPrice" value="<%= request.getAttribute("totalPrice") %>">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="paymentMethod" id="payNow" value="payNow" checked>
                <label class="form-check-label" for="payNow">Pay Now</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="paymentMethod" id="payOnDelivery" value="payOnDelivery">
                <label class="form-check-label" for="payOnDelivery">Pay on Delivery</label>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Proceed</button>
        </form>
    </div>
</body>
</html>
