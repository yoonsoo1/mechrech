<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Company</title>
	<link rel="stylesheet" href="companyPage.css"/>
</head>
<body>
	<main>
		<section class="container">
			<!-- company info -->
			
			<div class="title1">
				<div class="menubar">
					<ul id="menu">
						<li class="menuitem"><a href = "index.jsp">Back to Main</a></li>
						<c:choose>				
							<c:when test="${sessionScope.username != null}">
									<li class="menuitem"><a href="Logout">Logout</a></li>
								</c:when>
							<c:otherwise>
								<li class="menuitem"><a href="Login.jsp" class="logIn">Log In</a></li>
							</c:otherwise>
						</c:choose>
						
					</ul>
				</div>
				<h1 id="companyName"></h1>
				<h2 id="rating"></h2>
				<h3 id="phone"></h3>
				<h3 id="address"></h3>
				<h3 id="services"></h3>
				
			</div>
			
			<!-- reviews -->
			<div class="title2">
				<h2>Most Recent Customer Reviews</h2>
				<div class="underline"></div>
			</div>
			<article class="review">
				<div class="img-container">
					<img src="companyImg/mech1.jpeg" id="revImg" alt=""> 
				</div>
				<h4 id="userID"></h4>
				<p id="service"></p>
				<p id="info"></p>
				<p id="postMessage">
				</p>
				<!--  prev next buttons -->
			
				<div class="button-container">
					<button class="prev-btn">prev</button>
					<button class="next-btn">next</button>
					<a href="post.jsp" class="addPosts">add posts</a>
				</div>
			</article>
		</section>
	</main>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js""></script>
	<script src="companyPage.js"></script>
	
</body>
</html>
