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
    </style>
</head>
<body>
  <div id="panelderecherche">
  	<input id="adresse" type="text">
  	<input id="valider" type="button" value="Rechercher">
  </div>
  <div id="informations" style="border: solid;">
  	<ul id="texte"></ul>
  	<ul id="texte2"></ul>
  </div>
    <script>
    var marker;
    var latitude;
    var longitude;
    var jsonResult;
      function initMap() {
        var myLatlng = {lat: 50.60, lng: 3.06};

        var map = new google.maps.Map(document.getElementById("map"), {
          zoom: 4,
          center: myLatlng
        });
        var geocoder = new google.maps.Geocoder();

        document.getElementById('valider').addEventListener('click', function() {
          geocodeAddress(geocoder, map);
        });
        

        marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: 'Click to zoom'
        });
       
        
        map.addListener('click', function(e) {
            placeMarkerAndPanTo(e.latLng, map);
            latitude = e.latLng.lat();
            longitude = e.latLng.lng();
            console.log( 'Lat: ' + latitude + ' and Longitude is: ' + longitude );
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
              marker.setMap(null);
               marker = new google.maps.Marker({
                map: resultsMap,
                position: results[0].geometry.location
              });
            } else {
              alert('Le lieu rentré n\'existe pas ' + status);
            }
          });
        }
      function placeMarkerAndPanTo(latLng, map) {
    	  marker.setMap(null);
    	
    	   marker = new google.maps.Marker({
    	    position: latLng,
    	    map: map
    	  });
    	  marker.setAnimation(google.maps.Animation.DROP);
    	  map.panTo(latLng);
    	}
      
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6m_Z5GYZIXmHgnwbhR6Qdw6n7Qg4kAU8
    &callback=initMap">
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
						  console.log(item[i].address_components[j].long_name);
					  }
					  break;
				  }
			  }
			});
		/*$.ajax({ 
		    type: 'GET', 
		    url: "http://maps.googleapis.com/maps/api/geocode/json?latlng="+latitude+","+longitude+"&sensor=false", 
		    data: { get_param: 'value' }, 
		    dataType: 'json',
		    success: function (data) { 
		       var names = data
		       $('#texte').html(data);
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
		return false;*/
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
    // Whether this is a POST/GET/UPDATE/DELETE request
    type:"GET",
    // The type of data we expect back
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
  </body>
</html>