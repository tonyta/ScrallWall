$(document).ready(function(e) {
  var lat = latitude;
  var lng = longitude;

  var layer = L.mapbox.tileLayer('examples.map-9ijuk24y');
  var map = L.map('mini-map', {
            center: [lat, lng],
            layers: layer,
            zoom: 15 // max-zoom is 19
          });

  var marker = L.mapbox.featureLayer().addTo(map);

  marker
    .setGeoJSON({
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [lng, lat]
      },
      properties: {
        'marker-color': '#000',
        'marker-symbol': 'star-stroked'
      }
    });
});
