var areaName = [];

$(document).ready(function () {
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(37.86929522057436, 127.75075349778074), // 지도의 중심좌표
            level: 6, // 지도의 확대 레벨
            draggable : false, // 지도 확대 불가능
            disableDoubleClickZoom : true
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);

    $.getJSON('./js/CC_JSON_COORD.geojson', function (geojson) {
        var data = geojson.features;

        $.each(data, function (i, data) {
            var name = data.properties.EMD_NM;
            var coords = data.geometry.coordinates[0][0];
            // console.log(data.geometry.coordinates[0][0])
            areaName.push(name)
            displayPolygon(coords, name, i)
        });
    });

    var polygons = [];
    var overToggle = false; 

    function displayPolygon(coords, name, indexOfArea) {
        var path = [],
            points = [];
        
        $.each(coords, function (i, coord) {
            var point = new Object();
            point.x = coord[0];
            point.y = coord[1];
            points.push(point);
            path.push(new kakao.maps.LatLng(coord[1], coord[0]));
        })

        var polygon = new kakao.maps.Polygon({
            path: path,
            strokeWeight: 3, // 선의 두께입니다
            strokeColor: '#674836', // 선의 색깔입니다
            strokeOpacity: 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
            fillColor: '#674836', // 채우기 색깔입니다
            fillOpacity: 0.2 // 채우기 불투명도 입니다
        });

        kakao.maps.event.addListener(polygon, 'mouseover', function(event) {
            polygon.setOptions({
                fillOpacity: 0.7
            });

            const toolTip = document.getElementById('mapToolTip');

            toolTip.style.left = event.point.x + 'px';
            toolTip.style.top = event.point.y + 'px';
            toolTip.innerText = name;
            toolTip.hidden = false;

            overToggle = true;
        })

        kakao.maps.event.addListener(polygon, 'mouseout', function(event) {
            polygon.setOptions({
                fillOpacity: 0.2
            });
            document.getElementById('mapToolTip').hidden = true;
            overToggle = false;
        })

        kakao.maps.event.addListener(polygon, 'click', function(event) {
            // alert('Click on ' + indexOfArea);
            clickOnArea(indexOfArea);
        })

        polygon.setMap(map)
    }

    kakao.maps.event.addListener(map, 'mousemove', function(event) {
        const toolTip = document.getElementById('mapToolTip');
        toolTip.style.left = event.point.x + 10 + 'px';
        toolTip.style.top = event.point.y + 10 + 'px';
    });
});

const districtName = document.getElementsByClassName('districtName')[0];

function clickOnArea(index) {
    districtName.innerText = areaName[index];
    location.href = './?area=' + index;
}

function clickOnList(area, index) {
	 location.href = './?area=' + area + '&cafeId=' + index;
}