function updateFormData(lat, lng) {
  $('#picture_latitude').val(lat);
  $('#picture_longitude').val(lng);
}

function getNeighborNode() {
  return $('.neighbor-thumb.template').first().clone();
}

function buildNeighborNode(picId, neighbor) {
  var node = getNeighborNode().removeClass('template');
  var href = "/artifacts/" + neighbor.id + "/pictures/" + picId;
  var url = neighbor.pictureUrl

  node.attr('href', href);
  node.find('img').attr('src', url);
  return node;
}

function populateNeighbors(picId, neighbors) {
  var neighborNodes = [getNeighborNode()];
  $.each(neighbors, function(i, neighbor){
    neighborNodes.push( buildNeighborNode(picId, neighbor) );
  });
  $('#neighbors').html(neighborNodes);
}

function updateNeighbors(picId, lat, lng) {
  $.get('/pictures/neighbors.json', {lat: lat, lng: lng}, function(response){
    populateNeighbors(picId, response);
  });
}

$(document).ready(function() {
  // latitude & longitude was set in the HTML-script in edit.html.erb
  var lat = latitude;
  var lng = longitude;
  var picId = $('#neighbors').data().pictureId;
  var neighbors;

  updateFormData(lat, lng);
  updateNeighbors(picId, lat, lng);

  var layer = L.mapbox.tileLayer('examples.map-9ijuk24y');

  var map = L.map('mini-map', {
              center: [lat, lng],
              layers: layer,
              zoom: 16 // max-zoom is 19
            });

  var marker = L.marker(new L.LatLng(lat, lng), {
                 draggable: true,
               });

  marker.addTo(map);

  marker.on('dragend', function(e) {
    var lat = this._latlng.lat;
    var lng = this._latlng.lng;
    updateFormData(lat, lng);
    updateNeighbors(picId, lat, lng);
  });
});
