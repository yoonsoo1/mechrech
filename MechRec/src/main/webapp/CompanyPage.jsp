<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
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
			<!-- comapny info -->
			<div class="title1">
				<h1 id="companyName"></h1>
				<h2 id="rating"></h2>
				<h3 id="phone"></h3>
				<h3 id="address"></h3>
				<h3 id="services"></h3>
			</div>
			
			<!-- reviews -->
			<div class="title2">
				<h2>customer reviews</h2>
				<div class="underline"></div>
			</div>
			<article class="review">
				<div class="img-container">
					<img src="companyImg/mechanic1.jpeg" id="revImg" alt=""> 
				</div>
				<h4 id="author">John Jones</h4>
				<p id="service">oil change</p>
				<p id="info">
				Everti maiorum eam at, ei nulla consequat liberavisse sit. Nam an minim phaedrum, ne persecuti accommodare duo, 
				id quo eros vidisse. Corrumpit disputationi at has, eam nibh mnesarchum scriptorem ex. Fabulas dolorem 
				interesset nam ne, eam accusam pertinacia cu. Sea ei mutat dictas nonumes. Sed ea wisi euismod disputationi, 
				summo labitur moderatius vim in.
				</p>
				<!--  prev next buttons -->
				<div class="button-container">
					<button class="prev-btn">prev</button>
					<button class="next-btn">next</button>
				</div>
			</article>
		</section>
	</main>
	<script src="companyPage.js"></script>
</body>
</html>