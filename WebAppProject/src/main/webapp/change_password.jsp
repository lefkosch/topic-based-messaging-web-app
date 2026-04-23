<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String success = request.getParameter("success");
    String origin = request.getParameter("origin");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
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
        function validateForm() {
            const username = document.getElementById("username").value.trim();
            const current = document.getElementById("current_password").value;
            const newpass = document.getElementById("new_password").value;
            const confirm = document.getElementById("confirm_password").value;
            const errorDiv = document.getElementById("error-message");

            errorDiv.textContent = "";

            if (username === "" || current === "" || newpass === "" || confirm === "") {
                errorDiv.textContent = "Please fill in all fields.";
                return false;
            }

            if (newpass !== confirm) {
                errorDiv.textContent = "New passwords do not match.";
                return false;
            }

            if (newpass === current) {
                errorDiv.textContent = "New password must be different from the current one.";
                return false;
            }

            const strongRegex = /^(?=.*[a-zA-Z])(?=.*\d).{6,}$/;
            if (!strongRegex.test(newpass)) {
                errorDiv.textContent = "New password must be at least 6 characters and include letters and numbers.";
                return false;
            }

            return true;
        }

        function togglePassword(id, toggleId) {
            const field = document.getElementById(id);
            const toggle = document.getElementById(toggleId);
            if (field.type === "password") {
                field.type = "text";
                toggle.textContent = "Hide";
            } else {
                field.type = "password";
                toggle.textContent = "Show";
            }
        }

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

<div class="page-container">
    <h1 class="title">Change Password</h1>

    <%--  Εμφάνιση μηνύματος επιτυχίας αν η αλλαγή έγινε από το index.jsp --%>
    <% if ("password".equals(success) && "index".equals(origin)) { %>
        <div id="successMessage" class="bottom-success-message">
            Password changed successfully. Please log in again.
        </div>
    <% } %>

    <div class="form-container">
        <form method="post" action="ChangePasswordServlet" onsubmit="return validateForm();">

            <!-- Username -->
            <div class="input-group">
                <img src="images/user.png" class="input-icon" alt="User">
                <input type="text" id="username" name="username" placeholder="Username" required>
            </div>

            <!-- Current Password -->
            <div class="input-group">
                <img src="images/unlock.png" class="input-icon" alt="Current Password">
                <input type="password" id="current_password" name="current" placeholder="Current Password" required>
                <span class="toggle-password" id="toggleCurrent" onclick="togglePassword('current_password', 'toggleCurrent')">Show</span>
            </div>

            <!-- New Password -->
            <div class="input-group">
                <img src="images/new-password.png" class="input-icon" alt="New Password">
                <input type="password" id="new_password" name="newpass" placeholder="New Password" required>
                <span class="toggle-password" id="toggleNew" onclick="togglePassword('new_password', 'toggleNew')">Show</span>
            </div>

            <!-- Confirm New Password -->
            <div class="input-group">
                <img src="images/new-password.png" class="input-icon" alt="Confirm Password">
                <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm New Password" required>
                <span class="toggle-password" id="toggleConfirm" onclick="togglePassword('confirm_password', 'toggleConfirm')">Show</span>
            </div>

            <!-- Error Message -->
            <div id="error-message" style="color:red; font-weight:bold; margin-bottom: 10px;"></div>

            <!-- Submit -->
            <input type="submit" value="Change Password" class="login-button">
        </form>
    </div>
</div>

</body>
</html>
