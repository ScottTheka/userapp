<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.assignment.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head><title>Profile</title></head>
<body>
<h2>Welcome, ${user.username}!</h2>
<p>Email: ${user.email}</p>
<p>Role: ${user.role}</p>
<a href="update.jsp">Update Profile</a> | <a href="logout">Logout</a>
</body>
</html>
