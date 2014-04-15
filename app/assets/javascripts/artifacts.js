$(document).ready(function() {

  var layer = L.mapbox.tileLayer('examples.map-9ijuk24y');
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
