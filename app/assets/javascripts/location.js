$(document).ready(function() {
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {disableDefaultUI: true}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers([
      {
        "lat": 0,
        "lng": 0,
        "picture": {
          "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
          "width":  36,
          "height": 36
        },
        "infowindow": "hello!"
      }
    ]);
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
