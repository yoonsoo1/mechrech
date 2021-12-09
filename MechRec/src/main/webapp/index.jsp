<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>MechRec</title>
	<link rel="stylesheet" href="index.css"/>
</head>
<body>
	<main>
		<nav>
			<div class="nav-center">
				<div class="nav-header">
					<div class="img-container">
						<img src="companyImg/logo.png" id="coLogo" alt ="">
						
						<div class="logo"><b>MechRec</b></div>
					</div>				
					<a href="index.jsp" class="button">Home</a>
					<div class="dropdown">
						<button class="dropbtn">USC Mechs</button>
						<div class="dropdown-content">
						    <button class="btn1"></button>
						    <button class="btn2"></button>
						    <button class="btn3"></button>
						</div>
					</div>	
					<div class="dropdown2">
						<button class="dropbtn2">UCLA Mechs</button>
						<div class="dropdown-content2">
						    <p>Coming Soon!</p>
						</div>
					</div>
					</div>		
					
					
						<c:choose>				
							<c:when test="${sessionScope.username != null}">
								<a href="Logout" class="logIn">Logout</a></li>
							</c:when>
							<c:otherwise>
								<a href="Login.jsp" class="logIn">Log In</a>
							</c:otherwise>
						</c:choose>
					
					
				</div>	
			</div>
			
			
		</nav>
		<section class = "container">
			<!-- static content -->
			<div class="intro">
				<h1>Find the Right Mechanic to Fit Your Needs!</h1>
				<h2>Search through our database of reviews and
				 information on all local USC mechanics.</h2>
			</div>
			<div class="row">
			  <div class="column-left">Services
			  	<p>Find services to fit your needs along with the corresponding pricing.</p>
				  <img src="companyImg/mech1.jpeg" id="serImg" alt ="">
			  </div>
			  <div class="column-center">Mechanics
			  	<p>Compare mechanics in order to find the best one for your car maintenance.</p>
				  <img src="companyImg/mech4.jpeg" id="mecImg" alt ="">
		  	  </div>
			  <div class="column-right">Customer Reviews
			  	<p>Utilize customer reviews that detail specific services, pricing,
			  	 and overall opinion of each mechanic</p>
				  <img src="companyImg/mech3.jpeg" id="cusImg" alt ="">
			  </div>
			</div>
		</section>
		
		
	</main>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js""></script>
	<script src="index.js"></script>
	
</body>

</html>