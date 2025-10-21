<%@ page session="true" %>
<%
    // Session & authentication check
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?message=Session expired. Please login again.");
        return;
    }

    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="profile.jsp">MyApp</a>
        <div class="ms-auto">
            <a href="logout.jsp" class="btn btn-outline-light"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow-sm">
                <div class="card-header text-center">
                    <h4><i class="bi bi-pencil-square"></i> Update Profile</h4>
                </div>
                <div class="card-body">

                    <form action="update" method="post">
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-person-fill"></i> Username</label>
                            <input type="text" class="form-control" name="username" value="<%= username %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-envelope-fill"></i> Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-lock-fill"></i> Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-save-fill"></i> Update</button>
                    </form>

                    <% if(request.getAttribute("message") != null) { %>
                        <div class="alert alert-info mt-3 alert-dismissible fade show" role="alert">
                            <i class="bi bi-info-circle-fill"></i> <%= request.getAttribute("message") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>

                </div>
            </div>

            <div class="text-center mt-3">
                <a href="profile.jsp" class="btn btn-link"><i class="bi bi-arrow-left"></i> Back to Profile</a>
            </div>

        </div>
    </div>
</div>

<footer class="text-center mt-5 mb-3">
    <p>&copy; 2025 MyApp</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
