<%-- 
    Document   : change-password
    Created on : Nov 28, 2025, 10:54:29 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change password</title>
         <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .error {
            color: red;
            margin-bottom: 10px;
            display: block;
        }
        
        label {
            font-size: 16px;
            margin-bottom: 5px;
        }
        button {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        a {
            margin-top: 15px;
            color: white;
            text-decoration: none;
            font-size: 20px;
            background: #34495e;
            padding: 10px 15px;
            border-radius: 5px;
            width: fit-content;
            
        }
        .toggle-password {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-left: 5px;

        }
        

        form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            display:flex;
            flex-direction: column;
            
        }

        .form-group {
            margin-bottom: 20px;
            display: flex;
            flex-direction: row;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        </style>
    </head>
    <body>
         <script>
            function togglePassword(fieldId) {
                const field = document.getElementById(fieldId);
                if (field.type === "password") {
                    field.type = "text";
                } else {
                    field.type = "password";
                }
            }
        </script>
      
        <div>
              <c:if test="${not empty param.message}">
                <div class="alert  alert-success">${param.message}</div>
             </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert  alert-error">${param.error}</div>
            </c:if>
            
             <form action="change-password" method="post">

            <label for="currentPassword">Current Password:</label>
            <div class="form-group">
                <input type="password" id="currentPassword" name="currentPassword" >
                <button type="button" class="toggle-password" onclick="togglePassword('currentPassword')">👁️</button>
            </div>
             <span class="error">
                    <c:if test="${not empty errorCurrentPassword}">
                        ${errorCurrentPassword}
                    </c:if>
                </span>

            <label for="newPassword">New Password:</label>
            <div class="form-group">
                
                <input type="password" id="newPassword" name="newPassword" >
                <button type="button" class="toggle-password" onclick="togglePassword('newPassword')">👁️</button>
            </div>
             <span class="error">
                    <c:if test="${not empty errorNewPassword}">
                        ${errorNewPassword}
                    </c:if>
                </span>
            <label for="confirmPassword">Confirm New Password:</label>
            <div class="form-group">
                
                <input type="password" id="confirmPassword" name="confirmPassword" >
                <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword')">👁️</button>
            </div>
             <span class="error">
                    <c:if test="${not empty errorConfirmPassword}">
                        ${errorConfirmPassword}
                    </c:if>
                </span>
            
            <button type="submit">Change Password</button>
            <a href="dashboard"> return </a>
</form>
        
            
        </div>
        
       

       

    </body>
</html>
