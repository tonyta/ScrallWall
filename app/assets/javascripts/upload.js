function updateFormData(lat, lng) {
  $('#picture_latitude').val(lat);
  $('#picture_longitude').val(lng);
}

function getGeo(){
  navigator.geolocation.getCurrentPosition(function(geodata){
    var lat = geodata.coords.latitude;
    var lng = geodata.coords.longitude;
    updateFormData(lat, lng);
  });
}

$(document).ready(getGeo)
