$(document).ready(function() {

  var handler = Gmaps.build('Google', { markers: { clusterer: {gridSize: 50} } } );

  handler.buildMap({ provider: { maxZoom: 50 }, internal: {id: 'map'}}, function(){
    var markers = handler.addMarkers(hashed);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });

});
