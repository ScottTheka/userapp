<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Authentication check
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?message=You are not logged in.");
        return;
    }

    // Invalidate session
    session.invalidate();

    // Redirect to login page
    response.sendRedirect("login.jsp?message=You have been logged out successfully.");
%>
