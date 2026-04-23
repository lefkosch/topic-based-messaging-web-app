package hua.dit.web.project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uname = request.getParameter("uname");
        String upass = request.getParameter("upass");

        // Κρυπτογράφηση του password
        String upasshash = Util.getHash256(upass);

        try (Connection con = getConnection()) {
            String sql = "SELECT id FROM users WHERE uname = ? AND upasshash = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, uname);
                stmt.setString(2, upasshash);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    int userId = rs.getInt("id");
                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", userId);
                    response.sendRedirect("main_menu.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=1");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=1");
        }
    }

    private static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mariadb://localhost:3306/lab",
                "root",
                ""
            );
        } catch (ClassNotFoundException e) {
            throw new SQLException("MariaDB JDBC Driver not found", e);
        }
    }
}
