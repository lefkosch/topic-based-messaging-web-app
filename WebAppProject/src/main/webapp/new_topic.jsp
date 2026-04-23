<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Έλεγχος αν ο χρήστης είναι συνδεδεμένος
    session = request.getSession(false);
    Integer userId = (session != null) ? (Integer) session.getAttribute("user_id") : null;
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Topic</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>

<div class="page-container">
    <div class="form-container">
        <h2 class="title">Create Topic</h2>

        <form method="post" action="NewTopicServlet">
            <!-- Topic Title -->
            <div class="input-group">
                <input type="text" id="title" name="title" placeholder="Title" required>
            </div>

            <!-- Topic Content -->
            <div class="input-group">
                <textarea id="content" name="content" placeholder="Content..." rows="5" required></textarea>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="login-button">Create Topic</button>
        </form>

        <% String error = request.getParameter("error");
           if ("1".equals(error)) {
        %>
            <p>Something went wrong. Please try again.</p>
        <% } %>

    </div>
</div>

</body>
</html>
