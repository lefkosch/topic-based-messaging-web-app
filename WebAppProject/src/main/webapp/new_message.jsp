<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String[]> topics = new ArrayList<>();
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/lab", "root", "");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT ID, NAME FROM topics ORDER BY ID");
        while (rs.next()) {
            topics.add(new String[]{rs.getString("ID"), rs.getString("NAME")});
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Send Message</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
<div class="page-container">
    <div class="form-container">
        <h2 class="title">Send Message</h2>

        <form method="post" action="NewMessageServlet">
            <div class="input-group">
                <select name="topic_id" required>
                    <option value="" disabled selected>Select Topic</option>
                    <% for (String[] topic : topics) { %>
                        <option value="<%= topic[0] %>"><%= topic[1] %></option>
                    <% } %>
                </select>
            </div>

            <div class="input-group">
                <textarea name="content" rows="5" placeholder="Write your message..." required></textarea>
            </div>

            <button type="submit" class="login-button">Send Message</button>
        </form>

        <% if ("1".equals(request.getParameter("error"))) { %>
            <p class="error-message">Something went wrong. Please try again.</p>
        <% } %>
    </div>
</div>
</body>
</html>
