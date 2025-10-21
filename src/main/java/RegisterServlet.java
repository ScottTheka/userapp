package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = LoggerFactory.getLogger(RegisterServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        String role = request.getParameter("role");

        if (username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            logger.warn("Registration failed - missing fields for user [{}]", username);
            forwardWithMessage(request, response, "All fields are required!", "register.jsp");
            return;
        }

        if (role == null || role.isEmpty()) {
            role = "user";
        }

        try (Connection conn = DatabaseConnection.getConnection()) {

            String checkSql = "SELECT 1 FROM users WHERE username=? OR email=?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        logger.warn("Registration attempt failed - duplicate username/email [{}]", username);
                        forwardWithMessage(request, response, "Username or email already exists!", "register.jsp");
                        return;
                    }
                }
            }

            // Encrypt email and hash password
            String encryptedEmail = PasswordUtil.encryptAES(email);
            String salt = PasswordUtil.getSalt();
            String hashedPassword = PasswordUtil.hashPassword(password, salt);

            String insertSql = "INSERT INTO users (username, email, password, salt, role) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setString(1, username);
                ps.setString(2, encryptedEmail);
                ps.setString(3, hashedPassword);
                ps.setString(4, salt);
                ps.setString(5, role);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    logger.info("New user registered successfully: [{}] with role [{}]", username, role);
                    forwardWithMessage(request, response, "Registration successful! Please login.", "login.jsp");
                } else {
                    logger.error("Registration failed for user [{}]", username);
                    forwardWithMessage(request, response, "Registration failed. Try again.", "register.jsp");
                }
            }

        } catch (SQLException e) {
            logger.error("Database error during registration for user [{}]: {}", username, e.getMessage(), e);
            forwardWithMessage(request, response, "Registration failed: " + e.getMessage(), "register.jsp");
        } catch (Exception e) {
            logger.error("Unexpected error during registration for user [{}]: {}", username, e.getMessage(), e);
            forwardWithMessage(request, response, "An error occurred: " + e.getMessage(), "register.jsp");
        }
    }

    private void forwardWithMessage(HttpServletRequest request, HttpServletResponse response, 
                                    String message, String page) throws ServletException, IOException {
        request.setAttribute("message", message);
        request.getRequestDispatcher(page).forward(request, response);
    }
}
