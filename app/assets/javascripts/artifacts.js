$(document).ready(function(e) {
  var neighborhood = null;

  var layer = L.mapbox.tileLayer('1derfly.i9b7f5n7');
  var map = L.map('map', {
      center: [41.8897866, -87.6371788],
      layers: layer,
      zoom: 13 // max-zoom is 19
    });


  map.locate();
  map.on('locationfound', function(e) {
    var myLocation = L.mapbox.featureLayer().addTo(map);
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

    // auto-pan disabled for better show and tell :)
    // map.panTo(myLocation.getBounds().getCenter());
    // map.setZoom(15);
  });

  function IconFactory(imageUrl){
    return L.icon({iconUrl: imageUrl, className: 'artifact'});
  }

  function markerContentBuilder(object) {
    var plural = '';
    if (object.picture_count > 1) {
      plural = 's';
    }
    var popup = L.popup({minWidth:235}).setContent(
                  "<a href='" + object.show_url + "'><img style='border:8px solid #222' src='" +
                  object.info_thumb + "'><p>"+object.picture_count+" Picture"+plural+"</p></a>"
                )
    return popup;
  }

  function neighborhoodContentBuilder(data) {
    var neighborhoodLink = '';
    if (data.artifact_count > 0) {
      neighborhoodLink = "<a href='/neighborhoods/" + data.id + "'>View them</a></div>";
    }
    var popup = L.popup().setContent(
                  "<div><h3>" + data.name + ":</h3><p>" + data.artifact_count + " Artifacts Found<p>" +
                  neighborhoodLink
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
