<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Session & authentication check
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?message=Session expired. Please login again.");
        return;
    }

    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email"); // decrypted in servlet
    String role = (String) session.getAttribute("role");
    String message = (String) request.getAttribute("message");

    request.setAttribute("username", username);
    request.setAttribute("email", email);
    request.setAttribute("role", role);
    request.setAttribute("message", message);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MyApp</a>
        <div class="ms-auto">
            <a href="logout.jsp" class="btn btn-outline-light"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <!-- Profile Card -->
            <div class="card shadow-sm">
                <div class="card-header text-center bg-light">
                    <h4><i class="bi bi-person-circle"></i> Welcome, <c:out value="${username}"/>!</h4>
                </div>
                <div class="card-body">

                    <p><i class="bi bi-shield-lock-fill"></i> <strong>Role:</strong> <c:out value="${role}"/></p>
                    <p><i class="bi bi-envelope-fill"></i> <strong>Email:</strong> <c:out value="${email}"/></p>

                    <!-- Success / Info Message -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                            <i class="bi bi-check-circle-fill"></i> <c:out value="${message}"/>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Update Form -->
                    <h5 class="mt-4 mb-3"><i class="bi bi-pencil-square"></i> Update Profile</h5>
                    <form action="update" method="post">
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-person-fill"></i> Username</label>
                            <input type="text" class="form-control" name="username"
                                   value="<c:out value='${username}'/>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-envelope-fill"></i> Email</label>
                            <input type="email" class="form-control" name="email"
                                   value="<c:out value='${email}'/>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-lock-fill"></i> Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>

                        <!-- Admin-only role selector -->
                        <c:if test="${role eq 'admin'}">
                            <div class="mb-3">
                                <p class="text-primary"><i class="bi bi-shield-fill-check"></i> You have admin privileges.</p>
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role">
                                    <option value="user" ${role eq 'user' ? 'selected' : ''}>User</option>
                                    <option value="admin" ${role eq 'admin' ? 'selected' : ''}>Admin</option>
                                </select>
                            </div>
                        </c:if>

                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-save-fill"></i> Update Profile</button>
                    </form>
                </div>
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
