function initMap() {
  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: new google.maps.LatLng(47, 10)
  });




  $.get("api/battles", function(data) {
    let points = $.map(data["data"], function(battle) {
      return new google.maps.LatLng(battle.lat, battle.lng);
    });

		let heatmap = new google.maps.visualization.HeatmapLayer({
			data: points,
      map: map,
			radius: 15,
			opacity: 0.75
		});
  });
}
