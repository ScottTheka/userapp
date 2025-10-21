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
<head><title>Update Profile</title></head>
<body>
<h2>Update Profile</h2>
<form action="update" method="post">
    Username: ${user.username} <br/>
    Email: <input type="email" name="email" value="${user.email}" required/><br/>
    <input type="submit" value="Update"/>
</form>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>
<a href="profile.jsp">Back to Profile</a>
</body>
</html>
