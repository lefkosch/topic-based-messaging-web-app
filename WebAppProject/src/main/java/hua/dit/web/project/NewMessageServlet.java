package hua.dit.web.project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/NewMessageServlet")
public class NewMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Έλεγχος αν ο χρήστης είναι συνδεδεμένος
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("user_id");
        String topicIdStr = request.getParameter("topic_id");
        String content = request.getParameter("content");

        // 2. Έλεγχος για κενά ή μη έγκυρα πεδία
        if (topicIdStr == null || topicIdStr.isEmpty() || content == null || content.trim().isEmpty()) {
            response.sendRedirect("new_message.jsp?error=1");
            return;
        }

        try {
            int topicId = Integer.parseInt(topicIdStr);

            try (Connection con = getConnection()) {

                // 3.1 Εισαγωγή μηνύματος
                String sqlInsert = "INSERT INTO messages (topic_id, user_id, msg, date_sent) VALUES (?, ?, ?, NOW())";
                try (PreparedStatement stmt = con.prepareStatement(sqlInsert)) {
                    stmt.setInt(1, topicId);
                    stmt.setInt(2, userId);
                    stmt.setString(3, content);
                    stmt.executeUpdate();
                }

                // 3.2 Υπολογισμός πλήθους μηνυμάτων για το topic
                int count = 0;
                String countSql = "SELECT COUNT(*) FROM messages WHERE topic_id = ?";
                try (PreparedStatement countStmt = con.prepareStatement(countSql)) {
                    countStmt.setInt(1, topicId);
                    ResultSet rs = countStmt.executeQuery();
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                }

                // 3.3 Επιτυχία → redirect με παραμέτρους
                response.sendRedirect("main_menu.jsp?success=1&count=" + count);
            }

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("new_message.jsp?error=1");
        }
    }

    // Σύνδεση με τη βάση
    private static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mariadb://localhost:3306/lab", "root", "");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver not found", e);
        }
    }
}
