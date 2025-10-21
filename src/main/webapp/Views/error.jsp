<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MyApp</a>
        <div class="ms-auto">
            <a href="index.jsp" class="btn btn-outline-light">Home</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm text-center">
                <div class="card-header bg-danger text-white">
                    <h3>Error</h3>
                </div>
                <div class="card-body">
                    <h1 class="display-4">Oops!</h1>
                    <p class="lead">Something went wrong. Please try again later.</p>
                    <a href="index.jsp" class="btn btn-primary">Go to Home</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2025 MyApp</p>
</footer>

</body>
</html>
