//global map declarations
var map = false;
var geocoder = new google.maps.Geocoder();

function init() {

    //declare map options
    var mapOptions = {
        zoom: 18,
        center: new google.maps.LatLng(38.867630, -91.943696),
        mapTypeId: google.maps.MapTypeId.HYBRID,
        panControl: false,
        mapTypeControl: true,
        mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
            position: google.maps.ControlPosition.TOP_RIGHT
        },
        zoomControl: true,
        zoomControlOptions: {
            style: google.maps.ZoomControlStyle.LARGE,
            position: google.maps.ControlPosition.LEFT_CENTER
        },
        streetViewControl: false,
        streetViewControlOptions: {
            position: google.maps.ControlPosition.LEFT_CENTER
        }
    };

    //create a new map using options
    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

    // Create the DIV to hold the control and call the addOverlays() constructor
    // passing in this DIV.
    var overlayControlDiv = document.createElement('div');
    var homeControl = new addOverlays(overlayControlDiv, map);

    overlayControlDiv.index = 1;
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(overlayControlDiv);

    //center map on address
    var address  = $('input[name=Address_1]').val();
    if(address){
        address += $('input[name=Address_2]').val()+', ';
        address += $('input[name=City]').val()+', ';
        address += $('input[name=State]').val()+', ';
        address += $('input[name=Zipcode]').val();

        console.log("GeoEncoding "+address);
        codeAddress(address);

    }
    else{
    }

}

function codeAddress(address) {
    //var address = document.getElementById('address').value;
    geocoder.geocode({'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });
        }
        else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

function toggleLayer(layer)
{
    if (layer.getMap())
        layer.setMap(null);
    else
        layer.setMap(map);
}

function addOverlays(controlDiv, map) {
    // Set CSS styles for the DIV containing the control
    // Setting padding to 5 px will offset the control
    // from the edge of the map.
    controlDiv.style.padding = '5px';
    controlDiv.title = 'Click to toggle the overlay';
}

$(document).ready(function() {
    //build map
    init();

    $('#encode_address').on('click', function() {
        var address = $('#address_map_box').val();
        console.dir(address);
        codeAddress(address);
    });

    //when the map container is clicked force trigger resize
    $('#map_container').on('click', function() {
		var currentCenter = map.getCenter();  // Get current center before resizing
		google.maps.event.trigger(map, "resize");
		map.setCenter(currentCenter); // Re-set previous center
    });

    //when the map container is resized force trigger resize
    $(window).resize(function() {
		var currentCenter = map.getCenter();  // Get current center before resizing
		google.maps.event.trigger(map, "resize");
		map.setCenter(currentCenter); // Re-set previous center
    });

});
