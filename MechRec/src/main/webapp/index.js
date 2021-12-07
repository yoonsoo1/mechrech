let companyNames;

function getCompanies() {
	return $.ajax({
		url: 'indexServlet',
		type: 'GET',
		dataType: 'json',
		success : function(result) {
			companyNames = result;
		},
		error : function() {
			console.log("Couldn't read JSON");
		}
	});
}

getCompanies().then(function() {
	const Co1 = document.getElementById("btn1");
	const Co2 = document.getElementById("btn2");
	const Co3 = document.getElementById("btn3");
	
	Co1.innerHTML += companyNames[0].companyName;
	Co2.innerHTML += companyNames[1].companyName;
	Co3.innerHTML += companyNames[2].companyName;
	
	Co1.addEventListener("click", function() {
		sendCompPg(companyNames[0].companyID);
	});
	Co2.addEventListener("click", function() {
		sendCompPg(companyNames[1].companyID);
	});
	Co3.addEventListener("click", function() {
		sendCompPg(companyNames[2].companyID);
	});
});

function sendCompPg(companyID) {
	return $.ajax({
		url:'indexServlet',
		type: 'POST',
		data: companyID,
		success: function()
		{
			console.log("success");	
		},
		error: function (errorThrown)
	    {
			console.log(errorThrown);
	    }
	});
}