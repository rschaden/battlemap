class Map {
  constructor(map) {
    this.map = map;
    this.heatmap = null;
    this.points = null;
    this.markers = [];

    this.map.addListener('zoom_changed', () => {
      if(map.getZoom() >= 6) {
        if (this.markers[0] && this.markers[0].map === null) {
          this.heatmap.setMap(null);
          $.each(this.markers, (_, marker) => {
            marker.setMap(this.map);
          });
        }
      } else {
        if (this.heatmap.map === null) {
          this.heatmap.setMap(this.map);
          $.each(this.markers, (_, marker) => {
            marker.setMap(null);
          });
        }
      }
    });
  }

  loadBattles(earliestDate, latestDate) {
    let params = { "filter": { "earliestDate": earliestDate, "latestDate": latestDate } }
    $.get("api/battles", params, (data) => {
      this.drawHeatmap(data["data"]);
      this.drawMarkers(data["data"]);
    });
  }

  resetBattles() {
    if (this.heatmap) {
      this.heatmap.setMap(null);
    }
    $.each(this.markers, (_, marker) => {
      marker.setMap(null);
    });
  }

  drawHeatmap(battles) {
    this.points = $.map(battles, (battle) => {
      let coordinates = battle.location
      return new google.maps.LatLng(coordinates.lat, coordinates.lng);
    });

    this.heatmap = new google.maps.visualization.HeatmapLayer({
      data: this.points,
      map: this.map,
      radius: 15,
      opacity: 0.75
    });
  }

  drawMarkers(battles) {
    this.markers = $.map(battles, (battle) => {
      let coordinates = battle.location;
      return this.createMarker(battle);
    });
  }

  createMarker(battle) {
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

    marker.addListener('click', () => {
      infowindow.open(this.map, marker);
    });

    return marker;
  }
}

function refreshMap() {
  earliestDate = $('#earliestDate').val();
  latestDate = $('#latestDate').val();
  battleMap.resetBattles();
  battleMap.loadBattles(earliestDate, latestDate);
}

function initMap() {
  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: new google.maps.LatLng(47, 10)
  });

  battleMap = new Map(map);

  refreshMap();

  $('#changeDate').on('click', function() {
    refreshMap();
  })

  $('#animate').on('click', function() {
    for(let i = 0; i < 20; i++) {
      setTimeout(() => {
        year = 1000 + (i * 50);
        earliestDate = year+ "-01-01";
        latestDate = (year + 50) + "-01-01";

        $('#earliestDate').val(earliestDate);
        $('#latestDate').val(latestDate);

        refreshMap();
      }, i * 1000)
    }
  })
}
