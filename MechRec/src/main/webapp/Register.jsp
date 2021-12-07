<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MechRec Registration</title>
	<link rel="stylesheet" href="Register.css">
</head>
<body>
	<main id="main-holder">
		<form id = "registration-form" method = "POST" action="registerServlet">
		  <div class="container">
		    <h1 id = "registration-id">Register</h1>
		    <p>Please fill in this form to create an account.</p>
		    <hr>
		   
		    <c:out value = "${errorMessageSign}"/>
		    <label for="username"><b>Username</b></label>
		    <input type="text" placeholder="Enter Username" name="username" id="username" required>
		
		    <label for="email"><b>Email</b></label>
		    <input type="text" placeholder="Enter Email" name="email" id="email" required>
		
		    <label for="psw"><b>Password</b></label>
		    <input type="password" placeholder="Enter Password" name="psw" id="psw" required>
		
		    <hr>
		    <button type="submit" class="registerbtn">Register</button>
		  </div>
		
		  <div class="container signin">
		    <p>Already have an account? <a href="Login.jsp">Sign in</a>.</p>
		  </div>
		</form>
	</main>
</body>

</html>