package hua.dit.web.project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("user_id") : null;

        // Παίρνουμε username, current & new pass
        String username = request.getParameter("username");
        String currentPassword = request.getParameter("current");
        String newPassword = request.getParameter("newpass");

        // Έλεγχος συμπλήρωσης πεδίων
        if (username == null || currentPassword == null || newPassword == null ||
                username.trim().isEmpty() || currentPassword.trim().isEmpty() || newPassword.trim().isEmpty()) {
            response.sendRedirect("change_password.jsp?error=1");
            return;
        }

        // Κρυπτογράφηση
        String currentHash = Util.getHash256(currentPassword);
        String newHash = Util.getHash256(newPassword);

        try (Connection con = getConnection()) {
            String sql = "SELECT * FROM users WHERE uname = ? AND upasshash = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, currentHash);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    int dbUserId = rs.getInt("id");

                    // Ενημέρωση νέου κωδικού
                    String updateSql = "UPDATE users SET upasshash = ? WHERE id = ?";
                    try (PreparedStatement updateStmt = con.prepareStatement(updateSql)) {
                        updateStmt.setString(1, newHash);
                        updateStmt.setInt(2, dbUserId);
                        updateStmt.executeUpdate();

                        // Αν υπάρχει session (χρήστης είναι logged in), redirect στο main_menu.jsp
                        if (userId != null && userId.equals(dbUserId)) {
                            response.sendRedirect("main_menu.jsp?success=password");
                        } else {
                            // Αν ΔΕΝ είναι logged in (π.χ. από index.jsp), redirect στο login με μήνυμα
                            response.sendRedirect("login.jsp?success=password");
                        }
                        return;
                    }
                } else {
                    response.sendRedirect("change_password.jsp?error=1");
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("change_password.jsp?error=1");
        }
    }

    private static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mariadb://localhost:3306/lab", "root", "");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MariaDB JDBC Driver not found", e);
        }
    }
}
