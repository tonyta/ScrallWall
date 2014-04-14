
var getNeighborNode = function() {
  return $('.neighbor-thumb.template').first().clone();
}

function populateNeighbors(picId, neighbors) {
  var allNeighbors = [getNeighborNode()];
  $.each(neighbors, function(i, neighbor){
    var node = getNeighborNode().removeClass('template');
    var href = "/artifacts/" + neighbor.id + "/pictures/" + picId;
    node.attr('href', href);
    node.find('img').attr('src', neighbor.pictureUrl);
    allNeighbors.push(node);
  });
  $('#neighbors').html(allNeighbors);
}

function updateFormData(lat, lng) {
  $('#picture_latitude').val(lat);
  $('#picture_longitude').val(lng);
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
  var picId = $('#neighbors').data().picId;
  var neighbors;

  updateNeighbors(picId, lat, lng);

  var layer = L.mapbox.tileLayer('examples.map-9ijuk24y');

  var map = L.map('mini-map', {
              center: [lat, lng],
              layers: layer,
              zoom: 16 // max-zoom is 19
            });

  var marker = L.marker(new L.LatLng(lat, lng), {
                 draggable: true
               });

  marker.addTo(map);

  marker.on('dragend', function(e) {
    var lat = this._latlng.lat;
    var lng = this._latlng.lng;
    updateFormData(lat, lng);
    updateNeighbors(picId, lat, lng);
  });
});
