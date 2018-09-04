class Map {
  constructor(map) {
    this.map = map;
    this.heatmap = null;
    this.points = null;
    this.markers = [];
    this.heatMapVisible = true;

    this.map.addListener('zoom_changed', () => {
      if(map.getZoom() >= 6) {
        this.heatMapVisible = false;
        if (this.markers[0] && this.markers[0].map === null) {
          this.heatmap.setMap(null);
          $.each(this.markers, (_, marker) => {
            marker.setMap(this.map);
          });
        }
      } else {
        this.heatMapVisible = true;
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
    let params = {
      "filter": {
        "earliestDate": earliestDate.format("YYYY-MM-DD"),
        "latestDate": latestDate.format("YYYY-MM-DD")
      }
    };
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

    let currentMap = this.heatMapVisible ? this.map : null;

    this.heatmap = new google.maps.visualization.HeatmapLayer({
      data: this.points,
      map: currentMap,
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

    let currentMap = this.heatMapVisible ? null : this.map;

    let marker = new google.maps.Marker({
      position: battle.location,
      map: currentMap,
      title: battle.name
    });

    marker.addListener('click', () => {
      infowindow.open(this.map, marker);
    });

    return marker;
  }
}

function refreshMap() {
  let earliestDate = moment($("#earliestDate").val())
  let latestDate = moment($("#latestDate").val())
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
  });

  $('#animate').on('click', function() {
    let interval = 20;
    let delay = (1000 / 40 * interval);
    let earliestDate = moment("1000-01-01")
    let latestDate = moment("1020-01-01")

    for(let i = 0; i < (1000 / interval); i++) {
      setTimeout(() => {

        $('#earliestDate').val(earliestDate.format("YYYY-MM-DD"));
        $('#latestDate').val(latestDate.format("YYYY-MM-DD"));

        refreshMap();

        earliestDate = earliestDate.add(interval, "years")
        latestDate = latestDate.add(interval, "years")
      }, i * delay)
    }
  });
}
