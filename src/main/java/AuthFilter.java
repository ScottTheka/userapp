

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Optional: init code
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI();

        // Allow public pages like login, register, index.jsp
        if (path.endsWith("login.jsp") || path.endsWith("register.jsp") || path.endsWith("index.jsp")
                || path.endsWith("LoginServlet") || path.endsWith("register")) {
            chain.doFilter(request, response); // continue
            return;
        }

        // Check if session exists
        if (session == null || session.getAttribute("username") == null) {
            res.sendRedirect("login.jsp?message=Please login first");
            return;
        }

        // Example: protect admin pages
        if (path.contains("/admin.jsp")) {
            String role = (String) session.getAttribute("role");
            if (!"admin".equals(role)) {
                res.sendRedirect("error.jsp?message=Access denied");
                return;
            }
        }

        // All checks passed, continue to requested page
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Optional: cleanup
    }
}
