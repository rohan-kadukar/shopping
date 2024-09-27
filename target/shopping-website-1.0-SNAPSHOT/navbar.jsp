<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <a class="navbar-brand" href="index.jsp">MyShop</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <% if (session.getAttribute("user") != null) { %>
                    <a class="nav-link" href="cart.jsp" title="Cart">
                        <i class="fas fa-shopping-cart fa-2x"></i>
                    </a>
                <% } %>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-user-circle fa-2x"></i> <!-- Profile Icon with increased size -->
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                    <% if (session.getAttribute("user") == null) { %>
                        <a class="dropdown-item" href="login.jsp">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                        <a class="dropdown-item" href="register.jsp">
                            <i class="fas fa-user-plus"></i> Register
                        </a>
                    <% } else { %>
                        <a class="dropdown-item" href="LogoutServlet">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    <% } %>
                </div>
            </li>
        </ul>
    </div>
</nav>

<!-- Include Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
