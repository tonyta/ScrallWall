$(document).ready(function() {

  var layer = L.mapbox.tileLayer('examples.map-9ijuk24y');
  // var map = L.mapbox.map('map', 'examples.map-9ijuk24y' );
  var map = L.map('map', {
      center: [41.8897866, -87.6371788],
      layers: layer,
      zoom: 13 // max-zoom is 19
    });

  function getLatLon(e) {
    console.log('hello');
  }

  function IconFactory(imageUrl){
    return L.icon({iconUrl: imageUrl});
  }

  function contentBuilder(image) {
    return "<img style='border:8px solid #222' src='" + image + "'>" +
            "<div>Title and stuff</div>" +
            "<a href='http://google.com'>Content to Click</a>"
  }

  // L.marker({lat:41.8897866, lon:-87.6371788}, {icon: myIcon, riseOnHover: true} ).addTo(map);

  $.each(artifacts, function(i, object){
    L.marker({lat: object.lat, lon: object.lon},
             {icon: new IconFactory(object.map_thumb), riseOnHover: true}
            ).addTo(map).bindPopup(contentBuilder(object.info_thumb));
  });


//   var oldTimey = [{"featureType":"administrative","stylers":[{"visibility":"off"}]},{"featureType":"poi","stylers":[{"visibility":"simplified"}]},{"featureType":"road","stylers":[{"visibility":"simplified"}]},{"featureType":"water","stylers":[{"visibility":"simplified"}]},{"featureType":"transit","stylers":[{"visibility":"simplified"}]},{"featureType":"landscape","stylers":[{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"visibility":"off"}]},{"featureType":"road.local","stylers":[{"visibility":"on"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"visibility":"on"}]},{"featureType":"water","stylers":[{"color":"#84afa3"},{"lightness":52}]},{"stylers":[{"saturation":-77}]},{"featureType":"road"}]

//   var handler = Gmaps.build('Google', { markers: { clusterer: {gridSize: 10, maxZoom: 20} } } );

//   handler.buildMap({
//     provider: {
//       maxZoom: 50,
//       mapTypeId: google.maps.MapTypeId.ROADMAP,
//       styles: oldTimey
//     },
//     internal: {
//       id: 'map'
//     }
//   },
//   function(){
//     var markers = handler.addMarkers(artifacts);
//     handler.bounds.extendWith(markers);
//     handler.fitMapToBounds();
//   });

});
