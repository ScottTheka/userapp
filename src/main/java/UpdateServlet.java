package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = LoggerFactory.getLogger(UpdateServlet.class);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            logger.warn("Unauthorized profile update attempt (no active session)");
            response.sendRedirect("login.jsp?message=Session expired. Please login again.");
            return;
        }

        String role = (String) session.getAttribute("role");
        String oldUsername = (String) session.getAttribute("username");
        String newUsername = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");
        String newRole = request.getParameter("role"); // optional, only for admin

        if (newUsername == null || newUsername.isEmpty() ||
            newEmail == null || newEmail.isEmpty() ||
            newPassword == null || newPassword.isEmpty()) {

            logger.warn("Profile update failed for [{}] - missing fields", oldUsername);
            request.setAttribute("message", "All fields are required!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        if (!"admin".equals(role)) {
            newRole = role;
        } else if (newRole == null || newRole.isEmpty()) {
            newRole = "user";
        }

        try (Connection conn = DatabaseConnection.getConnection()) {

            String salt = PasswordUtil.getSalt();
            String hashedPassword = PasswordUtil.hashPassword(newPassword, salt);
            String encryptedEmail = PasswordUtil.encryptAES(newEmail);

            String sql = "UPDATE users SET username=?, email=?, password=?, salt=?, role=? WHERE username=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newUsername);
            stmt.setString(2, encryptedEmail);
            stmt.setString(3, hashedPassword);
            stmt.setString(4, salt);
            stmt.setString(5, newRole);
            stmt.setString(6, oldUsername);

            int updatedRows = stmt.executeUpdate();

            if (updatedRows > 0) {
                session.setAttribute("username", newUsername);
                session.setAttribute("email", newEmail);
                session.setAttribute("role", newRole);
                logger.info("Profile updated successfully for user [{}] (role: {})", newUsername, newRole);
                request.setAttribute("message", "Profile updated successfully!");
            } else {
                logger.warn("Profile update failed - no rows updated for [{}]", oldUsername);
                request.setAttribute("message", "Profile update failed!");
            }

        } catch (SQLException e) {
            logger.error("Database error while updating profile for [{}]: {}", oldUsername, e.getMessage(), e);
            request.setAttribute("message", "Error updating profile: " + e.getMessage());
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
