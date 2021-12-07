let companyNames;

function getCompanies() {
	return $.ajax({
		url: 'indexServlet',
		type: 'GET',
		dataType: 'json',
		success : function(result) {
			companyNames = result;
			console.log(result);
		},
		error : function() {
			console.log("Couldn't read JSON");
		}
	});
}

getCompanies().then(function() {
	const Co1 = document.querySelector(".btn1");
	const Co2 = document.querySelector(".btn2");
	const Co3 = document.querySelector(".btn3");
	
	Co1.innerHTML += companyNames[0].companyName;
	Co2.innerHTML += companyNames[1].companyName;
	Co3.innerHTML += companyNames[2].companyName;
	
	Co1.addEventListener("click", function() {
		return sendCompPg(companyNames[0].companyID);
	});
	Co2.addEventListener("click", function() {
		return sendCompPg(companyNames[1].companyID);
	});
	Co3.addEventListener("click", function() {
		return sendCompPg(companyNames[2].companyID);
	});
	function sendCompPg(num) {
	return $.ajax({
		url:'indexServlet',
		type: 'POST',
		dataType: 'text',
		data: "companyID=" + num,
		success: function()
		{
			console.log("success " + num);	
			window.location = 'CompanyPage.jsp';
		},
		error: function (errorThrown)
	    {
			console.log(errorThrown);
	    }
	});
	}
	return;
});