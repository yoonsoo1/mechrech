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
const company;
const reviews;

// local reviews data

/*
const reviews = [
  {
    id: 1,
    name: "susan smith",
    service: "oil change",
    img:
      "companyImg/mech1.jpeg",
    text:
      "I'm baby meggings twee health goth +1. Bicycle rights tumeric chartreuse before they sold out chambray pop-up. Shaman humblebrag pickled coloring book salvia hoodie, cold-pressed four dollar toast everyday carry",
  },
  {
    id: 2,
    name: "anna johnson",
    service: "transmission fluid",
    img:
      "companyImg/mech2.jpg",
    text:
      "Helvetica artisan kinfolk thundercats lumbersexual blue bottle. Disrupt glossier gastropub deep v vice franzen hell of brooklyn twee enamel pin fashion axe.photo booth jean shorts artisan narwhal.",
  },
  {
    id: 3,
    name: "peter jones",
    service: "wheel change",
    img:
      "companyImg/mech3.jpeg",
    text:
      "Sriracha literally flexitarian irony, vape marfa unicorn. Glossier tattooed 8-bit, fixie waistcoat offal activated charcoal slow-carb marfa hell of pabst raclette post-ironic jianbing swag.",
  },
  {
    id: 4,
    name: "bill anderson",
    service: "alignment",
    img:
      "companyImg/mech4.jpeg",
    text:
      "Edison bulb put a bird on it humblebrag, marfa pok pok heirloom fashion axe cray stumptown venmo actually seitan. VHS farm-to-table schlitz, edison bulb pop-up 3 wolf moon tote bag street art shabby chic. ",
  },
];
*/

$.ajax
({
	url : 'compServlet.java', 
	type : 'GET', // type of the HTTP request
	dataType: 'json',
	success : function(result){ 
		company = result[0];
		reviews = result[1];
	}
});

// company data
const companyName = document.getElementById("companyName");
const rating = document.getElementById("rating");
const phone = document.getElementById("phone");
const address = document.getElementById("address");
const services = document.getElementById("services");

let currComp = 0;

const comp = company[currComp];

companyName.innerHTML += comp.name;
rating.innerHTML += comp.rating;
phone.innerHTML += comp.phone;
address.innerHTML += comp.address;
services.innerHTML += comp.services;

function loadComp() {
	const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		document.getElementById("")
	}
}

// select items for reviews
const img = document.getElementById("revImg");
const author = document.getElementById("author");
const service = document.getElementById("service");
const info = document.getElementById("info");

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
	author.textContent = item.name;
	service.textContent = item.service;
	info.textContent = item.text;	
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