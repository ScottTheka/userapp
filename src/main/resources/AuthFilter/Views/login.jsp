<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Login</title></head>
<body>
<h2>Login</h2>
<form action="login" method="post">
    Username: <input type="text" name="username" required/><br/>
    Password: <input type="password" name="password" required/><br/>
    <input type="submit" value="Login"/>
</form>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>
<a href="register.jsp">Register</a>
</body>
</html>
