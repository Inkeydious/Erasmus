<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Erasmus Application</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
    <script type="text/javascript" src="jquery-2.1.3.js"></script>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 80%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #panelderecherche {
      	position: absolute;
        top: 12%;
        left: 81%;
        background-color: #fff;
        padding: 10px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      #informations{
      	position: absolute;
        top: 20%;
        left: 81%;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        font-size: small;
        line-height: 30px;
        padding-left: 10px;
      }
      
      #listVille{
      	position: absolute;
        top: 40%;
        left: 81%;
        width: 15%;
        height: 70%;
        background-color: #fff;
        padding: 5px;
        border: 1px  #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        font-size: small;
        line-height: 30px;
        padding-left: 10px;
        }
      #dropdownlist{
      	position: absolute;
        top: 60%;
        left: 81%;
        width: 17%;
        height: 20%;
        background-color: #fff;
        border: 1px  #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        font-size: small;
        line-height: 30px;
     }      
      
		h2 {
		color : BLACK;
		}
		
		
		ul {
   		 margin: 0;
  		 padding: 0;
  	     list-style-type: none;
  		  
		}

			/* Style the list items */
		ul li {
		    cursor: pointer;
		    position: relative;
		    padding: 12px 8px 12px 40px;
		    font-size: 18px;
		    transition: 0.2s;
		
		    /* make the list items unselectable */
		    -webkit-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		    user-select: none;
		}
		
		/* Set all odd list items to a different color (zebra-stripes) */
		ul li:nth-child(odd) {
		    background: #f9f9f9;
		}
		
		/* Darker background-color on hover */
		ul li:hover {
		    background: #ddd;
		}
		
		.header {
	    background-color: #f44336;
	    padding: 30px 40px;
	    color: white;
	    text-align: center;
		}
		
		/* Clear floats after the header */
		.header:after {
		    content: "";
		    display: table;
		    clear: both;
		}
		.close {
	    position: absolute;
	    right: 0;
	    top: 0;
	    padding: 12px 16px 12px 16px;
		}

		.close:hover {
		    background-color: #f44336;
		    color: white;
		}
		
    </style>
</head>
<body onload="access()">
  <div id="panelderecherche">
  	<input id="adresse" type="text">
  	<input id="valider" type="button" value="Search">
  </div>
  
  <div id="informations"  class="header">
  	<h2>Cities list</h2>
  	<input type="text" id="ville" placeholder="Enter your city...">
  	<button onclick="newCity()" class="addCity">Add</button>
  </div>
  
  <div id="listVille">
       <ul id="listOfCities"></ul>
  </div>
   
  	
  	
  	<script>
  	var myNodelist = document.getElementsByTagName("LI");
  	var i;
  	for (i = 0; i < myNodelist.length; i++) {
  	  var span = document.createElement("SPAN");
  	  var txt = document.createTextNode("\u00D7");
  	  span.className = "close";
  	  span.appendChild(txt);
  	  myNodelist[i].appendChild(span);
  	}

  	// Click on a close button to hide the current list item
  	var close = document.getElementsByClassName("close");
  	var i;
  	for (i = 0; i < close.length; i++) {
  	  close[i].onclick = function() {
  	    var div = this.parentElement;
  	    div.style.display = "none";
  	  }
  	}

  	

  	// Create a new list item when clicking on the "Add" button
  	function newCity() {
  	  var li = document.createElement("li");
  	  var inputValue = document.getElementById("ville").value;
  	  var t = document.createTextNode(inputValue);
  	  li.appendChild(t);
  	  if (inputValue === '') {
  	    alert("You must write something!");
  	  } else {
  	    document.getElementById("listOfCities").appendChild(li);
	  	  allCity += inputValue + ",";
  	  }
  	  document.getElementById("ville").value = "";

  	  var span = document.createElement("SPAN");
  	  var txt = document.createTextNode("\u00D7");
  	  span.className = "close";
  	  span.appendChild(txt);
  	  li.appendChild(span);

  	  for (i = 0; i < close.length; i++) {
  	    close[i].onclick = function() {
  	      var div = this.parentElement;
  	      div.style.display = "none";
  	    }
  	  }
  	}
  	</script>
    
    
    <script>
    var marker;
    var latitude;
    var longitude;
    var jsonResult;
    var markerArray = [];
    var cityArray = [];
    var allCity = "";
    var map;
    var geocoder;
    var actualCity;
    var contentString;
    var infowindow;
      function initMap() {
        var myLatlng = {lat: 50.60, lng: 3.06};

         map = new google.maps.Map(document.getElementById("map"), {
          zoom: 4,
          center: myLatlng
        });
        geocoder = new google.maps.Geocoder();
        
        document.getElementById('valider').addEventListener('click', function() {
          geocodeAddress(geocoder, map);
        });
        

        marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: 'Click to zoom'
        });
      	marker.setVisible(false);
        
      	
      	
        map.addListener('click', function(e) {
            placeMarkerAndPanTo(e.latLng, map);
            latitude = e.latLng.lat();
            longitude = e.latLng.lng();
            console.log( 'Lat: ' + latitude + ' and Longitude is: ' + longitude );
            for (var i = 0; i < markerArray.length; i++) {
                google.maps.event.addListener(markerArray[i], 'dblclick', function() {
                    this.setMap(null);
					markerArray.splice(i,1);
					cityArray.splice(i,1);
                });
                $.getJSON("http://maps.googleapis.com/maps/api/geocode/json?latlng="+latitude+","+longitude+"&sensor=false", function( data ) {
	      			  for(var i=0;i<data.results.length;i++){
	      				  var item = data.results;
	      				  for(var j=0;j<item.length;j++){
	      					  if(item[i].address_components[j].types[0] === "locality"){  
	      						  actualCity = item[i].address_components[j].long_name;
	      						}
	      					  break;
	      				  }
	      			  }
	      			});             
              google.maps.event.addListener(markerArray[i], 'rightclick', function() { 
              	 infowindow = new google.maps.InfoWindow({
		                    content: '<div id="content">'+
			                '<div id="siteNotice">'+
			                '</div>'+
			                '<h1 id="firstHeading" class="firstHeading">'+actualCity+'</h1>'+
			                '<div id="bodyContent">'+
			                '<p><b>'+ actualCity+'</b></p>'+
			                '</div>'+
			                '</div>'
		                  });
              	 infowindow.open(map, markerArray[i]);
		             console.log(actualCity+" coucou");
              });
            }
            console.log(markerArray);
            //Call to servlet
          });

       	marker.addListener('click', function() {
       	   map.setZoom(8);
       	   map.setCenter(marker.getPosition());
       	 });
      
      }
       
      function geocodeAddress(geocoder, resultsMap) {
          var address = document.getElementById('adresse').value;
          geocoder.geocode({'address': address}, function(results, status) {
            if (status === 'OK') {
              resultsMap.setCenter(results[0].geometry.location);
               marker = new google.maps.Marker({
                map: resultsMap,
                position: results[0].geometry.location
              });
            } else {
              alert('Le lieu rentr� n\'existe pas ' + status);
            }
          });
        }
      function placeMarkerAndPanTo(latLng, map) {
    	   marker = new google.maps.Marker({
    	    position: latLng,
    	    map: map
    	  });
    	   markerArray.push(marker);
    	  marker.setAnimation(google.maps.Animation.DROP);
    	  map.panTo(latLng);
    	}
      
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6m_Z5GYZIXmHgnwbhR6Qdw6n7Qg4kAU8&callback=initMap">
    </script>
       <script>
// IMPORTANT ! Otherwise the DOM is not yet created !
$(document).ready(function() {
	
	$('#map').click(function(e) {
		$.getJSON("http://maps.googleapis.com/maps/api/geocode/json?latlng="+latitude+","+longitude+"&sensor=false", function( data ) {
			  for(var i=0;i<data.results.length;i++){
				  var item = data.results;
				  for(var j=0;j<item.length;j++){
					  if(item[i].address_components[j].types[0] === "locality"){
						  cityArray.push(item[i].address_components[j].long_name);
						  allCity += item[i].address_components[j].long_name + ",";
						  console.log(allCity);
						  actualCity = item[i].address_components[j].long_name;
						}
					  break;
				  }
			  }
			});
		
		
	});
}); 

// end document.ready
    </script>
    <div id='output'>
    </div>
      <script>$('#list').click(function(event) {
  $.ajax({
    // The URL for the request
    url:"http://maps.googleapis.com/maps/api/geocode/json?latlng="+event.latLng.lat()+","+event.latLng.lng()+"&sensor=false",
    type:"GET",
    dataType:"json",
    // Code to run if the request succeeds;
    // the response is passed to the function
    success: function(json) {
        $("#output").text(JSON.stringify(json));
        $("<h1>").text(json.title).appendTo("body");
        $("<div class=\"content\">").html(json.html).appendTo("body");
    },
    // Code to run if the request fails; the raw request and
    // status codes are passed to the function
    error: function( xhr, status, errorThrown ) {
        alert( "Sorry, there was a problem!" );
        console.log( "Error: " + errorThrown );
        console.log( "Status: " + status );
        console.dir( xhr );
    },
    // Code to run regardless of success or failure
    complete: function( xhr, status ) {
        alert( "The request is complete!" );
    }
  });
});
</script>
<header>
<h1 class="h11">Erasmus</h1> <h1 class="h12">Application</h1>
</header>

<div id="map" style="width: 80%; height: 80%; border:solid" ></div>
	


<script>
function videArrayMarker(){
	for(var i = 0; i < markerArray.length; i++){
		markerArray[i].setVisible(false);
	}
	markerArray = [];
}
function display() {
        document.getElementById("textField1").value = allCity;
    }
function access(){
	<%String attribut = "";
		if(request.getAttribute("test") != null){
			attribut = (String) request.getAttribute("test");
		}
			String [] tabville = attribut.split(",");
	%>
	var test="<%=attribut%>";
	var tabtest = [];
	tabtest = test.split(",");
		for(var i = 0; i <tabtest.length; i++){
			var newAddress;
			geocoder.geocode({'address':tabtest[i]},function(results,status){
				if(status==google.maps.GeocoderStatus.OK){
					newAddress=results[0].geometry.location;
					var latlng = new google.maps.LatLng(parseFloat(newAddress.lat()),parseFloat(newAddress.lng()));
					marker = new google.maps.Marker({
				        map : map,
				        position : newAddress
				      });
					markerArray.push(marker);
					marker.setMap(map);
					
					for (var j = 0; j < markerArray.length; j++) {        
		                $.getJSON("http://maps.googleapis.com/maps/api/geocode/json?latlng="+newAddress.lat()+","+newAddress.lng()+"&sensor=false", function( data ) {
			      			  for(var i=0;i<data.results.length;i++){
			      				  var item = data.results;
			      				  for(var j=0;j<item.length;j++){
			      					  if(item[i].address_components[j].types[0] === "locality"){  
			      						  actualCity = item[i].address_components[j].long_name;
			      						  cityArray.push(actualCity);
			      						}
			      					  break;
			      				  }
			      			  }
			      			});             
		                google.maps.event.addListener(markerArray[j], 'rightclick', function() { 
		                	console.log("marker : " + markerArray.length);
		                	console.log("ville : " + cityArray.length);

		                	 infowindow = new google.maps.InfoWindow({
				                    content: '<div id="content">'+
					                '<div id="siteNotice">'+
					                '</div>'+
					                '<h1 id="firstHeading" class="firstHeading">'+actualCity+'</h1>'+
					                '<div id="bodyContent">'+
					                '<p><b>'+ actualCity+'</b></p>'+
					                '</div>'+
					                '</div>'
				                  });
		                	 infowindow.open(map, markerArray[j]);
				             console.log(actualCity+" coucou");
		                });
		                google.maps.event.addListener(markerArray[j], 'dblclick', function() {
		                    this.setMap(null);
		                    markerArray.splice(i,1);
							cityArray.splice(i,1);
		                });
		            }
				}
			});
			
		}
		
	  
	}

</script>

<body>


<!--  <form id="form1" action="Select" method="GET" enctype="multipart/form-data">
	<input id="textField1" type="hidden" size="13" value="clear" name="textField1" /><br>

		 <input type="checkbox" name="C" /> C
         <input type="checkbox" name="Java"  /> JAVA
         <input type="checkbox" name="Cobol" /> COBOL
	<button type="submit" onclick="display()">Valide</button>
</form>-->

<div id="dropdownlist">
<form action="Select" method="GET">
<label for="mydropdown" datalabel="mydropdown">Interests</label>
<input id="textField1" type="hidden" size="13" value="clear" name="textField1" />  
<select name="textField2">
    <option value="Nothing">All</option>
    <option value="Java">Java</option>
    <option value="Cobol">Cobol</option>
    <option value="C">C</option>
</select>	
<button type="submit" onclick="display()">Valide</button>

</form>
</div>

<div id="vireMarker">
	<button type="submit" onclick="videArrayMarker()">Remove all markers</button>

</div>
  </body>
</html>