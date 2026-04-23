package hua.dit.web.project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/NewTopicServlet")
public class NewTopicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Έλεγχος session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Ανάκτηση δεδομένων
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // Έλεγχος για κενά πεδία
        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
            response.sendRedirect("new_topic.jsp?error=1");
            return;
        }

        // Εισαγωγή στη βάση
        try (Connection con = getConnection()) {
            String sql = "INSERT INTO topics (NAME, DESCRIPTION) VALUES (?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, title.trim());
                stmt.setString(2, content.trim());
                stmt.executeUpdate();

                // ✅ Redirect με success=2 για εμφάνιση μηνύματος επιτυχίας
                response.sendRedirect("main_menu.jsp?success=2");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("new_topic.jsp?error=1");
        }
    }

    // Σύνδεση με βάση
    private static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mariadb://localhost:3306/lab", "root", "");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MariaDB JDBC Driver not found", e);
        }
    }
}
