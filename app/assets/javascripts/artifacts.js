$(document).ready(function() {

  var oldTimey = [{"featureType":"administrative","stylers":[{"visibility":"off"}]},{"featureType":"poi","stylers":[{"visibility":"simplified"}]},{"featureType":"road","stylers":[{"visibility":"simplified"}]},{"featureType":"water","stylers":[{"visibility":"simplified"}]},{"featureType":"transit","stylers":[{"visibility":"simplified"}]},{"featureType":"landscape","stylers":[{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"visibility":"off"}]},{"featureType":"road.local","stylers":[{"visibility":"on"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"visibility":"on"}]},{"featureType":"water","stylers":[{"color":"#84afa3"},{"lightness":52}]},{"stylers":[{"saturation":-77}]},{"featureType":"road"}]
  
  var handler = Gmaps.build('Google', { markers: { clusterer: {gridSize: 10, maxZoom: 20} } } );

  handler.buildMap({
    provider: {
      maxZoom: 50,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: oldTimey
    },
    internal: {
      id: 'map'
    }
  },
  function(){
    var markers = handler.addMarkers(artifacts);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });

});
