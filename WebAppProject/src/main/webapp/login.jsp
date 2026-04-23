<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Users</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>

<div class="page-container">
    <h1 class="title">User Login</h1>

    <div class="form-container">
        <form method="post" action="LoginServlet">

            <!-- Username field with icon -->
            <div class="input-group">
                <img src="images/user.png" class="input-icon" alt="User Icon">
                <input type="text" id="uname" name="uname" placeholder="Username" required>
            </div>

            <!-- Password field with icon and toggle -->
            <div class="input-group">
                <img src="images/unlock.png" class="input-icon" alt="Password Icon">
                <input type="password" id="upass" name="upass" placeholder="Password" required>
                <span class="toggle-password" onclick="togglePassword()">Show</span>
            </div>

            <!-- Submit button -->
            <input type="submit" value="Login" class="login-button">

        </form>

        <!-- Error message -->
        <% 
    		String error = request.getParameter("error");
   				 if ("1".equals(error)) { 
		%>
    		<p class="error-message">Incorrect username or password.</p>
		<% 
   			 } 
		%>

    </div>
</div>

<script>
    function togglePassword() {
        const pw = document.getElementById("upass");
        const toggle = document.querySelector(".toggle-password");

        if (pw.type === "password") {
            pw.type = "text";
            toggle.textContent = "Hide";
        } else {
            pw.type = "password";
            toggle.textContent = "Show";
        }
    }
</script>

</body>

<%
    String success = request.getParameter("success");
    if ("password".equals(success)) {
%>
    <div id="successMessage" class="bottom-success-message">
        Ο κωδικός άλλαξε με επιτυχία. Κάντε είσοδο με τον νέο σας κωδικό.
    </div>
<%
    }
%>

</html>
