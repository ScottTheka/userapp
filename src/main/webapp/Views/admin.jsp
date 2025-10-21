<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MyApp</a>
        <div class="ms-auto">
            <a href="logout.jsp" class="btn btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm text-center">
                <div class="card-header bg-light">
                    <h3>Admin Dashboard</h3>
                </div>
                <div class="card-body">
                    <h1 class="display-4">Hello World!</h1>
                    <p class="lead">This is your admin page. You can add admin-specific functionalities here.</p>
                    <a href="profile.jsp" class="btn btn-primary me-2">Go to Profile</a>
                    <a href="index.jsp" class="btn btn-secondary">Home</a>
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
