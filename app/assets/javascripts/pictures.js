
var getNeighborNode = function() {
  return $('.neighbor-template').first().clone();
}

function updateNeighbors(pictureId, neighbors) {
  var allNeighbors = [getNeighborNode()]
  $.each(neighbors, function(i, neighbor){
    var node = getNeighborNode().removeClass('neighbor-template');
    node.attr('href', "/artifacts/"+neighbor.id+"/pictures/"+pictureId);
    node.find('img').attr('src', neighbor.picture);
    allNeighbors.push(node);
  });
  $('#neighbors').html(allNeighbors);
}

$(document).ready(function() {
  var pictureId = $('#neighbors').data().pictureId;

  var layer = L.mapbox.tileLayer('examples.map-9ijuk24y');

  var map = L.map('mini-map', {
    center: [latitude, longitude],
    layers: layer,
    zoom: 19 // max-zoom is 19
  });

  var marker = L.marker(new L.LatLng(latitude, longitude), {
    draggable: true
  });

  marker.on('dragend', function(e) {
    var lat = this._latlng.lat;
    var lng = this._latlng.lng;
    $.get('/pictures/neighbors.json', {lat: lat, lng: lng}, function(response){
      updateNeighbors(pictureId, response);
    });
    // console.log("lat: " + lat + ", long: " + lng);
  });

  marker.addTo(map);
});
