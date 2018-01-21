function initMap() {
  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: new google.maps.LatLng(47, 10)
  });




  $.get("api/battles", function(data) {
    let points = $.map(data["data"], function(battle) {
      coordinates = battle.location
      return new google.maps.LatLng(coordinates.lat, coordinates.lng);
    });

		let heatmap = new google.maps.visualization.HeatmapLayer({
			data: points,
      map: map,
			radius: 15,
			opacity: 0.75
		});

    let markers = $.map(data["data"], function(battle) {
      coordinates = battle.location;
      return createMarker(map, battle);
    });

    map.addListener('zoom_changed', function() {
      if(map.getZoom() >= 6) {
        heatmap.setMap(null);
        $.each(markers, function(_, marker) {
          marker.setMap(map);
				});
      } else {
        heatmap.setMap(map);
        $.each(markers, function(_, marker) {
          marker.setMap(null);
        });
      }
    });
  });
}

function createMarker(map, battle) {
  let infowindow = new google.maps.InfoWindow({
    content: '<div id="content">' +
               '<h4>' + battle.name + '</h4>' +
               '<p>' + battle.start_date + ' - ' + battle.end_date +  '</p>' +
             '</div>'
  });

  let marker = new google.maps.Marker({
    position: battle.location,
    map: null,
    title: battle.name
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });

  return marker;
}
