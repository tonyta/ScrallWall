$(document).ready ->
$("#geolocation").click ->
  e.preventDefault()
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(showPosition)
  else
    $("#latlong").append "Geolocation is not supported by this browser."
    
showPosition = (position) -> $("#latlong").append
"Latitude: "  + position.coords.latitude  + "<br>" +
"Longitude: " + position.coords.longitude