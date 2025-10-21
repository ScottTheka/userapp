<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Register</title></head>
<body>
<h2>Register</h2>
<form action="register" method="post">
    Username: <input type="text" name="username" required/><br/>
    Email: <input type="email" name="email" required/><br/>
    Password: <input type="password" name="password" required/><br/>
    Role:
    <select name="role">
        <option value="user">User</option>
        <option value="admin">Admin</option>
    </select><br/>
    <input type="submit" value="Register"/>
</form>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>
<a href="login.jsp">Login</a>
</body>
</html>
