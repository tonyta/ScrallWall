$(document).ready(function(e) {
  var neighborhood = null;

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

  function markerContentBuilder(object) {
    var popup = L.popup({minWidth:235}).setContent(
                  "<h4><a href='" + object.show_url + "'><img style='border:8px solid #222' src='" +
                  object.info_thumb + "'>"+object.picture_count+" Pictures Total</a></h4>"
                )
    return popup;
  }

  function neighborhoodContentBuilder(data) {
    var popup = L.popup().setContent(
                  "<div><h3>" + data.name + ":</h3><h4><a href='/neighborhoods/" +
                  data.id + "'>" + data.artifact_count + " Artifacts Found</a><h4></div>"
                )
    return popup;
  }

  map.on('click', function(e) {
    var data = {lat: e.latlng.lat, lng: e.latlng.lng}
    $.get('/neighborhoods/find.json', data, function(neighborhoodData){
      console.log(neighborhoodData);
      if (neighborhoodData) {
        updateNeighborhood(neighborhoodData);
      } else {
        console.log('no neighborhood found');
      }
    });
  });

  function updateNeighborhood(neighborhoodData) {
    if (neighborhood) {
      neighborhood._latlngs = neighborhoodData.coordinates;
      neighborhood.redraw();
    } else {
      neighborhood = L.polygon(neighborhoodData.coordinates, {color: 'red'});
      neighborhood.addTo(map);
    }
    neighborhood.bindPopup(neighborhoodContentBuilder(neighborhoodData));
    neighborhood.openPopup(neighborhood.getBounds().getCenter());
  }

  $.each(artifacts, function(i, object){
    L.marker({lat: object.lat, lng: object.lng},
             {icon: new IconFactory(object.map_thumb), riseOnHover: true}
            ).addTo(map).bindPopup(markerContentBuilder(object));
  });
});
