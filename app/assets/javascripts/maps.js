var lat;
var lng;

navigator.geolocation.getCurrentPosition(function(geodata){
  lat = geodata.coords.latitude;
  lng = geodata.coords.longitude;
});
