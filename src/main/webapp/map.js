
function initMap() {
    // Inicjalizacja mapy
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 6,
        center: {lat: 52.237049, lng: 21.017532} // Współrzędne centrum mapy (w tym wypadku Warszawy)
    });

    // znaczniki dla wybranych miast
    var marker1 = new google.maps.Marker({
        position: {lat: 52.229676, lng: 21.012229},
        map: map,
        title: 'Warszawa'
    });

    var marker2 = new google.maps.Marker({
        position: {lat: 50.064650, lng: 19.944980},
        map: map,
        title: 'Kraków'
    });

    var marker3 = new google.maps.Marker({
        position: {lat: 51.759248, lng: 19.455983},
        map: map,
        title: 'Łódź'
    });

    var marker4 = new google.maps.Marker({
        position: {lat: 51.107883, lng: 17.038538},
        map: map,
        title: 'Wrocław'
    });

    var marker5 = new google.maps.Marker({
        position: {lat: 52.406376, lng: 16.925167},
        map: map,
        title: 'Poznań'
    });

    var marker6 = new google.maps.Marker({
        position: {lat: 54.352025, lng: 18.646638},
        map: map,
        title: 'Gdańsk'
    });

    var marker7 = new google.maps.Marker({
        position: {lat: 53.428543, lng: 14.552812},
        map: map,
        title: 'Szczecin'
    });

    var marker8 = new google.maps.Marker({
        position: {lat: 51.246452, lng: 22.568445},
        map: map,
        title: 'Lublin'
    });

    var marker9 = new google.maps.Marker({
        position: {lat: 50.264892, lng: 19.023782},
        map: map,
        title: 'Katowice'
    });
}