<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String success = request.getParameter("success");
    String countStr = request.getParameter("count");
    int count = -1;

    if ("1".equals(success) && countStr != null) {
        try {
            count = Integer.parseInt(countStr);
        } catch (NumberFormatException ignored) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Menu</title>
    <link rel="stylesheet" href="CSS/style.css">
    <style>
        .bottom-success-message {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #e6ffee;
            color: #006633;
            padding: 12px 20px;
            border-radius: 10px;
            font-weight: bold;
            font-size: 15px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.3);
            transition: opacity 0.6s ease;
            z-index: 1000;
        }
        .fade-out {
            opacity: 0;
        }
    </style>
    <script>
        window.onload = function() {
            const message = document.getElementById("successMessage");
            if (message) {
                setTimeout(() => {
                    message.classList.add("fade-out");
                }, 4000);
            }
        };
    </script>
</head>
<body>
    <div class="menu-container">
        <h2 class="menu-title">Main Menu</h2>

        <div class="menu-grid">
            <a href="new_message.jsp" class="menu-box">
                <img src="images/send-message.png" alt="New Message Icon">
                <span>Send New Message</span>
            </a>

            <a href="new_topic.jsp" class="menu-box">
                <img src="images/create-new-topic.png" alt="Create Topic Icon">
                <span>Create New Topic</span>
            </a>

            <a href="change_password.jsp" class="menu-box">
                <img src="images/reset-password.png" alt="Change Password Icon">
                <span>Change Password</span>
            </a>

            <a href="logout.jsp" class="menu-box">
                <img src="images/logout.png" alt="Logout">
                <span>Log Out</span>
            </a>
        </div>
    </div>

    <%-- Εμφάνιση επιβεβαιωτικών μηνυμάτων --%>
    <% if ("1".equals(success) && count >= 0) { %>
        <div id="successMessage" class="bottom-success-message">
             The message was sent successfully. There are <strong><%= count %></strong> messages on the selected topic.
        </div>
    <% } else if ("2".equals(success)) { %>
        <div id="successMessage" class="bottom-success-message">
             The topic was created successfully.
        </div>
    <% } else if ("password".equals(success)) { %>
        <div id="successMessage" class="bottom-success-message">
             Password was successfully changed.
        </div>
    <% } %>

</body>
</html>
