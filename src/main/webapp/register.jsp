<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MyApp</a>
        <div class="ms-auto">
            <a href="login.jsp" class="btn btn-outline-light">Login</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header text-center bg-light">
                    <h4>Create Account</h4>
                </div>
                <div class="card-body">
                    <form action="register" method="post">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" name="role" required>
                                <option value="user" selected>User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Register</button>
                    </form>

                    <c:if test="${not empty message}">
                        <div class="alert alert-danger mt-3 text-center">
                            <c:out value="${message}"/>
                        </div>
                    </c:if>

                    <div class="text-center mt-3">
                        <p>Already have an account? <a href="login.jsp">Login here</a>.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center mt-5 mb-3">
    <p>&copy; 2025 MyApp</p>
</footer>

</body>
</html>
