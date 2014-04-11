$(document).ready(function() {
  var handler = Gmaps.build('Google', { markers: { clusterer: {gridSize: 50} } } );

  handler.buildMap({ provider: { maxZoom: 50 }, internal: {id: 'map'}}, function(){
    var markers = handler.addMarkers(hashed);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });

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
