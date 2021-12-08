<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap" rel="stylesheet"> 
<link rel="stylesheet" href="post.css"/>
<title>Create Post</title>

</head>
<body>

<div class="title1">
				<div class="menubar">
					<ul id="menu">
						<li class="menuitem"><a href = "index.jsp">Back to Main</a></li>
						<li class="menuitem"><a href ="Login.jsp">Log-In</a></li>
					</ul>
				</div>
				<h1 id="companyName"></h1>
				<h2 id="rating"></h2>
				<h3 id="phone"></h3>
				<h3 id="address"></h3>
				<h3 id="services"></h3>
				
</div>

<div id="postContainer">
	<form action="PostServlet" method="post" id="postForm" >
	
		
		
		<div class="formItemContainer">
		<label for="message ">Post Message:</label><br>
		<textarea name="message" id="message" maxlength="255" placeholder="Message (255 characters max)" rows=3></textarea>
		</div>
		
		<div class="formItemContainer">
		<label for="CarModel ">Car Model:</label><br>
		<input type="text" name="carModel" id="message" placeholder="Car Model">
		</div>
		
		<div class="formItemContainer">
		<label for="CarMakel ">Car Make:</label><br>
		<input type="text" name="carMake" id="message" placeholder="Car Make">
		</div>
		
		<div class="formItemContainer">
		<label for="CarYear ">Car Year:</label><br>
		<input type="text" name="carYear" id="carYear" placeholder="Car Year">
		</div>
		
		<div class="formItemContainer">
		<label for="rating ">Rating:</label><br>
		<input type="text" name="rating" id="rating" placeholder="Rating (1.0-5.0)">
		</div>
		
		<div class="formItemContainer">
		<input type="submit" value="Post">
		</div>
	
		<div >
		<h4><c:out value="${errorMessage}"></c:out></h4>
		</div>
		

	
	</form>
	
</div>

</body>
</html>