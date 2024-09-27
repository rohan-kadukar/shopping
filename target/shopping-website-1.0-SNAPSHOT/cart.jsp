<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="connect.DBConnection" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<html>
    <head>
        <title>Your Cart</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .cart-header {
                margin: 20px 0;
                text-align: center;
            }
            .cart-item {
                border: 1px solid #ced4da;
                border-radius: 8px;
                background-color: white;
                margin-bottom: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .cart-image {
                width: 100%;
                height: auto;
                border-radius: 8px;
            }
            .btn-container {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }
            .summary {
                background-color: #f1f1f1;
                padding: 15px;
                border-radius: 8px;
                margin-top: 20px;
                text-align: right;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="cart-header">
                <h2>Your Cart</h2>
            </div>

            <%
                Integer userId = (Integer) session.getAttribute("user_id");
                if (userId == null) {
                    out.println("<p>You are not logged in. Please <a href='login.jsp'>login</a> to see your cart.</p>");
                } else {
                    Connection con = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    double totalPrice = 0;

                    try {
                        con = DBConnection.getConnection();
                        String sql = "SELECT products.id, products.name, products.price, products.image, cart_items.quantity "
                                + "FROM cart_items JOIN products ON cart_items.product_id = products.id "
                                + "WHERE cart_items.user_id = ?";
                        stmt = con.prepareStatement(sql);
                        stmt.setInt(1, userId);
                        rs = stmt.executeQuery();

                        if (!rs.isBeforeFirst()) {
                            out.println("<div class='alert alert-warning text-center mt-4' role='alert'>"
                                    + "<h4>Your Cart is Empty!</h4>"
                                    + "<p>Add some items from our <a href='index.jsp' class='alert-link'>product selection</a>!</p>"
                                    + "</div>");
                        } else {
                            while (rs.next()) {
                                String productId = rs.getString("id");
                                String productName = rs.getString("name");
                                double productPrice = rs.getDouble("price");
                                String productImage = rs.getString("image");
                                int quantity = rs.getInt("quantity");
                                double itemTotalPrice = productPrice * quantity;
                                totalPrice += itemTotalPrice;
            %>
            <div class="cart-item row align-items-center mb-3 p-3">
                <div class="col-4 col-md-2">
                    <img src="product-images/<%= productImage%>" alt="<%= productName%>" class="cart-image img-fluid"/>
                </div>
                <div class="col-8 col-md-10">
                    <h5><%= productName%></h5>
                    <p>Qty: <%= quantity%></p>
                    <p>Price: $<%= productPrice%> each</p>
                    <p><strong>Total: $<%= itemTotalPrice%></strong></p>
                    <div class="btn-container">
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="productId" value="<%= productId%>">
                            <button type="submit" class="btn btn-danger">Remove</button>
                        </form>
                        <form action="PaymentServlet" method="post">
                            <input type="hidden" name="productId" value="<%= productId%>">
                            <input type="hidden" name="quantity" value="<%= quantity%>">
                            <input type="hidden" name="action" value="checkout">
                            <button type="submit" class="btn btn-primary">Checkout</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            <div class="summary">
                <h4>Total Amount: $<%= totalPrice%></h4>
                <form action="CartServlet" method="post">
                    <input type="hidden" name="action" value="checkoutAll">
                    <button type="submit" class="btn btn-success">Checkout All</button>
                </form>
            </div>
            <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error retrieving cart items. Please try again later.</p>");
                    } finally {
                        if (rs != null) try {
                            rs.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        if (stmt != null) try {
                            stmt.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        if (con != null) try {
                            con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>
    </body>
</html>
