$(document).ready(function() {
	
	$("#tabs-container").tabsX({
	    enableCache: true,
	    maxTitleLength: 10,
	    successCallback: {
	        'technology': function (data, status, jqXHR) {
	        	console.log("yeah 1!!");
	        },
	        'enterprise': function (data, status, jqXHR) {
	        	console.log("yeah 2!!");
	        },
	        'people': function (data, status, jqXHR) {
	        	console.log("yeah 3!!");
	        }        
	    },
	    errorCallback: {
	        'technology': function (data, status, jqXHR) {
	        	console.log("pas yeah 1!!");
	        },
	        'enterprise': function (data, status, jqXHR) {
	        	console.log("pas yeah 2!!");
	        },
	        'people': function (data, status, jqXHR) {
	        	console.log("pas yeah 3!!");
	        }        
	    },
	});
});
