let company = "arg";
let reviews = "ument";

function getJSON() {
	return $.ajax({
		url : 'compServlet', 
		type : 'GET', // type of the HTTP request
		dataType: 'json',
		success : function(result){ 
			company = result[0];
			reviews = result[1];
			console.log(result)
		},
		error : function() {
			console.log("Couldn't read JSON");
		}
	});
}

let currComp = 0; 
getJSON().then(function(result) {
	// company data
	const companyName = document.getElementById("companyName");
	const rating = document.getElementById("rating");
	const phone = document.getElementById("phone");
	const address = document.getElementById("address");
	
	companyName.innerHTML += company.companyName;
	rating.innerHTML = "Rating: " + company.rating;
	phone.innerHTML = "Phone: "+ company.phone;
	address.innerHTML = "Address: " + company.address;
	
	// select items for reviews
	const img = document.getElementById("revImg");
	const userID = document.getElementById("userID");
	//const service = document.getElementById("service");
	const info = document.getElementById("info");
	const postMessage = document.getElementById("postMessage");
	
	const prevBtn = document.querySelector(".prev-btn");
	const nextBtn = document.querySelector(".next-btn");
	
	
});
	// set starting item
	let currItem = 0;
	// load initial item
	window.addEventListener("DOMContentLoaded", function() {
		showPerson();
	});
	
	// show person based on item
	
	function showPerson() {
		const item = reviews[currItem];
		img.src = item.img;
		userID.textContent = item.userID;
		//service.textContent = item.service;
		info.innerHTML = "Date: " + item.postTimestamp + "<br>"
		+ "Rating: " + item.rating + "<br>"
		+ "Car Model: " + item.carModel + "<br>"
		+ "Car Make: " + item.carMake + "<br>"
		+ "Car Year: " + item.carYear + "<br>";
		postMessage.textContent = item.postMessage;
	}
	
	// show next person
	nextBtn.addEventListener("click", function() {
		currItem++;
		if(currItem > reviews.length-1)
		{
			currItem = 0;
		}
		showPerson(currItem);
	});
	// show prev person
	prevBtn.addEventListener("click", function() {
		currItem--;
		if(currItem < 0)
		{
			currItem = reviews.length-1;
		}
		showPerson(currItem);
	});


