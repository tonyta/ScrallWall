$(document).ready(function() {
  $("#geolocation").on("click", function(e) {
    e.preventDefault();
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else {
      $("#latlong").append("Geolocation is not supported by this browser.");
    }
    
    function showPosition(position) {
     $("#latlong").append("Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude); 
     console.log("Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude);
    }
  })
});