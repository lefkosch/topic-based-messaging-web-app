<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
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
            const msg = document.getElementById("successMessage");
            if (msg) {
                setTimeout(() => {
                    msg.classList.add("fade-out");
                }, 4000);
            }
        };
    </script>
</head>
<body>

<div class="index-container">
    <h1 class="title">Welcome</h1>
    <div class="button-group">
        <a href="login.jsp" class="index-button">
            <img src="images/log-in.png" alt="Login Icon" class="icon">
            Log in
        </a>
        <a href="change_password.jsp" class="index-button">
            <img src="images/reset-password.png" alt="Change Password Icon" class="icon">
            Change Password
        </a>
    </div>
</div>

<%-- Εμφάνιση μηνύματος επιτυχίας μετά από αλλαγή κωδικού --%>
<% if ("password".equals(success)) { %>
    <div id="successMessage" class="bottom-success-message">
        Your password was successfully changed. Please log in with your new credentials.
    </div>
<% } %>

<script>
    window.onload = function() {
        const msg = document.getElementById("successMessage");
        if (msg) {
            setTimeout(() => {
                msg.classList.add("fade-out");
            }, 4000);
        }
    };
</script>

</body>
</html>
