<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<title>MechRec Login</title>
  	<link rel="stylesheet" href="Login.css">
</head>

<body>
  <main id="main-holder">
  	
  	<h1 id="login-title">MechRec</h1>
	<input type="image" id="image" alt="Logo"
       src="images/logo.png"> <!-- Put image tag -->
    
    <h2 id="login-header">Login</h2>
    
 	<c:out value="${errorMessage}"/>
    <form id="login-form" method = "POST" action = "loginServlet">
      <input type="text" name="username" id="username-field" class="login-form-field" placeholder="Username">
      <input type="password" name="password" id="password-field" class="login-form-field" placeholder="Password">
      <input type="submit" value="Login" id="login-form-submit">
    </form>
    <a HREF="Register.html" id = "register-form" >Register</a>
    <a HREF="MainPage.html" id = "guest-form">Continue as Guest...</a>
    
  
  </main>

</body>
</html>