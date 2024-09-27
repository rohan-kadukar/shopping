<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="connect.DBConnection" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ include file="navbar.jsp" %>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <title>MyShop</title>
</head>

<body>
    <div class="hero-section text-center">
        <h1>Welcome to MyShop!</h1>
        <p>Explore our top products below!</p>
    </div>

    <div class="container my-5">
        <div class="row">
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    con = DBConnection.getConnection(); // Using the connection utility
                    stmt = con.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM products");

                    // Get the current session to check login status
                    Boolean isLoggedIn = (session.getAttribute("user") != null);

                    while (rs.next()) {
            %>
            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                <div class="card h-100 shadow-sm">
                    <img class="card-img-top" src="product-images/<%= rs.getString("image")%>" alt="<%= rs.getString("name")%>" />
                    <div class="card-body d-flex flex-column justify-content-between">
                        <h5 class="card-title"><%= rs.getString("name")%></h5>
                        <p class="card-text">Category: <%= rs.getString("category")%></p>
                        <p class="card-text">Price: $<%= rs.getDouble("price")%></p>

                        <% if (isLoggedIn) {%>
                        <!-- Add to Cart Form -->
                        <form action="CartServlet" method="post" class="mt-auto">
                            <input type="hidden" name="productId" value="<%= rs.getInt("id")%>" />
                            <button type="submit" name="action" value="add" class="btn btn-success btn-block">Add to Cart</button>
                        </form>

                        <!-- Buy Now Form -->
                        <form action="DeliveryServlet" method="post" class="mt-2">
                            <input type="hidden" name="productId" value="<%= rs.getInt("id")%>" />
                            <button type="submit" name="action" value="buy" class="btn btn-primary btn-block">Buy Now</button>
                        </form>
                        <% } else { %>
                        <!-- Disabled Button if not logged in -->
                        <button type="button" class="btn btn-secondary btn-block" disabled title="Please login to add to cart or buy">Login to Buy</button>
                        <% } %>
                    </div>
                </div>
            </div>

            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
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
            %>
        </div>
    </div>

    <style>
        .hero-section {
            background-color: #007bff;
            color: white;
            padding: 50px 0;
            margin-bottom: 50px;
            font-family: 'Arial', sans-serif;
        }

        .hero-section h1 {
            font-size: 3rem;
            font-weight: bold;
        }

        .hero-section p {
            font-size: 1.3rem;
            margin-top: 10px;
        }

        .card {
            border-radius: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .card-body h5 {
            font-size: 1.25rem;
            color: #333;
        }

        .card-body p {
            font-size: 1rem;
            color: #666;
        }

        .btn {
            margin-top: 10px;
            border-radius: 30px;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.2rem;
            }

            .hero-section p {
                font-size: 1rem;
            }

            .card-img-top {
                height: 150px;
            }

            .card-body h5 {
                font-size: 1.1rem;
            }

            .card-body p {
                font-size: 0.9rem;
            }
        }
    </style>
</body>
