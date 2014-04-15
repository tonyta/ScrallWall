$(document).ready(function(e) {

  var map = L.mapbox.map('map', 'examples.map-9ijuk24y');
  var myLocation = L.mapbox.featureLayer().addTo(map);

  map.locate();

  map.on('locationfound', function(e) {
    map.fitBounds(e.bounds);
    map.setZoom(15);

    myLocation.setGeoJSON({
        type: "Feature",
        geometry: {
          type: "Point",
          coordinates: [e.latlng.lng, e.latlng.lat]
        },
        properties: {
          'marker-color': '#000',
          'marker-symbol': 'star-stroked'
        }
    });
  });

  function IconFactory(imageUrl){
    return L.icon({iconUrl: imageUrl, className: 'artifact'});
  }

  function contentBuilder(object) {
    return "<img style='border:8px solid #222' src='" + object.info_thumb + "'>" +
            "<div>Title and stuff</div>" +
            "<a href='" + object.show_url + "'>Content to Click</a>"
  }

  $.each(artifacts, function(i, object){
    L.marker({lat: object.lat, lng: object.lng},
             {icon: new IconFactory(object.map_thumb), riseOnHover: true}
            ).addTo(map).bindPopup(contentBuilder(object));
  });
});
