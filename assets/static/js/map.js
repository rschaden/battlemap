function initMap() {
  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: new google.maps.LatLng(47, 10)
  });

  $.get("api/battles", function(data) {
    $.each(data["data"], function(_, battle) {
      addMarker(map, battle);
    });
  });
}

function addMarker(map, battle) {
  let infowindow = new google.maps.InfoWindow({
    content: '<div id="content">' +
               '<h4>' + battle.name + '</h4>' +
               '<p>' + battle.start_date + ' - ' + battle.end_date +  '</p>' +
             '</div>'
  });

  let marker = new google.maps.Marker({
    position: battle.location,
    map: map,
    title: battle.name
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}
