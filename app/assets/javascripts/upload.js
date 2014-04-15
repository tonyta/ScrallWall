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

$(document).ready( function() {

  function toggleUploader() {
    $("#headline").toggle();
    $("#uploader").toggle();
  }

  $("#upload").on("click", function() {
    toggleUploader()
  });

  function parseFileName(string) {
    var reString = string.replace(/\\/g, "/");
    var fileName = reString.substr(reString.lastIndexOf("/") + 1);
    return "... " + fileName.substr(fileName.length - 30);
  };

  var fileInput = $("input[type='file']");

  $(fileInput).change( function() {
    var parsedString = parseFileName(fileInput.val());
    $(".file-input .text").html(parsedString);
  })

  $('.cancel').on('click', function(){
    fileInput.val("");
    $(".file-input .text").html("click or drag here");
    toggleUploader();
  })
});
