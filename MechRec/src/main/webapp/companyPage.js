// local company data
/*
const company = [
	{
		id: 1,
		name: "Yosemite Auto Body Shop",
		rating: 4.3,
		phone: "(323)737-2272",
		address: "1923 S Vermont Ave, Los Angeles, CA 90007",
		services: [ "Suspension Services", "Auto Body Restoration", "Collision Repair", "Paint Repair"]
	}
]
*/

// local reviews data

/*
const reviews = [
  {
    CompanyID: 1,
    userID: "susan smith",
    postMessage: "I'm baby meggings twee health goth +1. Bicycle rights tumeric chartreuse before they sold out chambray pop-up. Shaman humblebrag pickled coloring book salvia hoodie, cold-pressed four dollar toast everyday carry",
	postTimestamp: "currTime",
	rating: 4,
	carModel: "Honda",
	carMake: "Prius",
	carYear: 2020,
	img: "companyImg/mech1.jpeg",
  },
  {
    CompanyID: 1,
    userID: "anna johnson",
	postMessage:
      "Helvetica artisan kinfolk thundercats lumbersexual blue bottle. Disrupt glossier gastropub deep v vice franzen hell of brooklyn twee enamel pin fashion axe.photo booth jean shorts artisan narwhal.",
	postTimestamp: "currTime",
    rating: 3,
	carModel: "Honda",
	carMake: "Prius",
	carYear: 2020,  
	img:
      "companyImg/mech2.jpg",
  },
  {
    CompanyID: 1,
    userID: "peter jones",
	postMessage:
      "Sriracha literally flexitarian irony, vape marfa unicorn. Glossier tattooed 8-bit, fixie waistcoat offal activated charcoal slow-carb marfa hell of pabst raclette post-ironic jianbing swag.",
	postTimestamp: "currTime",
    rating: 2,
	carModel: "Honda",
	carMake: "Prius",
	carYear: 2020,  
	img:
      "companyImg/mech3.jpeg",
  },
  {
    CompanyID: 1,
    userID: "bill anderson",
	postMessage:
      "Edison bulb put a bird on it humblebrag, marfa pok pok heirloom fashion axe cray stumptown venmo actually seitan. VHS farm-to-table schlitz, edison bulb pop-up 3 wolf moon tote bag street art shabby chic. ",
	postTimestamp: "currTime",
    rating: 3,
	carModel: "Honda",
	carMake: "Prius",
	carYear: 2020,  
	img:
      "companyImg/mech4.jpeg",
  },
];
*/

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
	rating.innerHTML += company.rating;
	phone.innerHTML += company.phone;
	address.innerHTML += company.address;
	
	// select items for reviews
	const img = document.getElementById("revImg");
	const userID = document.getElementById("userID");
	//const service = document.getElementById("service");
	const info = document.getElementById("info");
	const postMessage = document.getElementById("postMessage");
	
	const prevBtn = document.querySelector(".prev-btn");
	const nextBtn = document.querySelector(".next-btn");
	
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
});


