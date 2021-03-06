$(function(){
	var ul = $('#sidebar > ul');
	var ul2 = $('#sidebar > ul > li.open ul');

	// === Resize window related === //
	$(window).on('resize',function()
	{
		wwidth = $(window).width();
		if(wwidth >= 768 && wwidth <= 991)
		{
			$('#sidebar > ul > li.open ul').attr('style','').parent().removeClass('open');
			ul.css({'display':'block'});
		}

		if(wwidth <= 767)
		{
			$('#sidebar').niceScroll();
			$('#sidebar').getNiceScroll().resize();

			if($(window).scrollTop() > 35) {
				$('body').addClass('fixed');
			}
			$(window).scroll(function(){
				if($(window).scrollTop() > 35) {
					$('body').addClass('fixed');
				} else {
					$('body').removeClass('fixed');
				}
			});
		}

		if(wwidth > 767)
		{
			ul.css({'display':'block'});

			$('body').removeClass('menu-open');
			$('#sidebar').attr('style','');
			$('#user-nav > ul').css({width:'auto',margin:'0'});
		}
	});

	if($(window).width() <= 767)
	{
		if($(window).scrollTop() > 35) {
			$('body').addClass('fixed');
		}
		$(window).scroll(function(){
			if($(window).scrollTop() > 35) {
				$('body').addClass('fixed');
			} else {
				$('body').removeClass('fixed');
			}
		});
		//jPM.on();
		$('#sidebar').niceScroll({
			zindex: '9999'
		});
		$('#sidebar').getNiceScroll().resize();
	}

	if($(window).width() > 767)
	{
		ul.css({'display':'block'});
	}
	if($(window).width() > 767 && $(window).width() < 992) {
		ul2.css({'display':'none'});
	}

	$('#menu-trigger').on('click',function(){
		if($(window).width() <= 767) {
			if($('body').hasClass('menu-open')) {
				$('body').removeClass('menu-open');
			} else {
				$('body').addClass('menu-open');
			}
		}
		return false;
	});

	// === Tooltips === //
	$('.tip').tooltip();
	$('.tip-left').tooltip({ placement: 'left' });
	$('.tip-right').tooltip({ placement: 'right' });
	$('.tip-top').tooltip({ placement: 'top' });
	$('.tip-bottom').tooltip({ placement: 'bottom' });

	$(document).on('click', '.submenu > a',function(e){
		e.preventDefault();
		var submenu = $(this).siblings('ul');
		var li = $(this).parents('li');

		var submenus = $('#sidebar li.submenu ul');
		var submenus_parents = $('#sidebar li.submenu');


		if(li.hasClass('open'))
		{
			if(($(window).width() > 976) || ($(window).width() < 768)) {
				submenu.slideUp();
			} else {
				submenu.fadeOut(150);
			}
			li.removeClass('open');
		} else
		{
			if(($(window).width() > 976) || ($(window).width() < 768)) {
				submenus.slideUp();
				submenu.slideDown();
			} else {
				submenus.fadeOut(150);
				submenu.fadeIn(150);
			}
			submenus_parents.removeClass('open');
			li.addClass('open');
		}
		$('#sidebar').getNiceScroll().resize();
	});

	$('#sidebar li.submenu ul').on('mouseleave',function(){
		if($(window).width() >= 768 && $(window).width() < 977) {
			$(this).fadeOut(150).parent().removeClass('open');
		}
	});

	// IE7
	$(function($) {
	    $("input[type=text], input[type=password], textarea").bind('focus blur',function(){$(this).toggleClass('focus')});
	});
});

$('.btn-toggle').click(function() {
    $(this).find('.btn').toggleClass('active');

    if ($(this).find('.btn-primary').size()>0) {
    	$(this).find('.btn').toggleClass('btn-primary');
    }
    if ($(this).find('.btn-danger').size()>0) {
    	$(this).find('.btn').toggleClass('btn-danger');
    }
    if ($(this).find('.btn-success').size()>0) {
    	$(this).find('.btn').toggleClass('btn-success');
    }
    if ($(this).find('.btn-info').size()>0) {
    	$(this).find('.btn').toggleClass('btn-info');
    }

    $(this).find('.btn').toggleClass('btn-default');

});

$(document).ready(function(){
  $("#unassignBtn").click(function(){
    $("#unassignConfirm").modal();
    });

	$("#moveBtn").click(function(){
    $("#moveConfirm").modal();
    });

  $('[data-toggle="tooltip"]').tooltip();

  $(function() {
    $('#lease_checkbox').change(function() {
      $('#modemLease.collapse').collapse();
    })

    $('#webspace_checkbox').change(function() {
      $('#personalWebspace.collapse').collapse();
    })
  })
});

var map;

function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(38.867630, -91.943696),
    zoom: 18,
    mapTypeId: google.maps.MapTypeId.HYBRID,
    panControl: false,
    scaleControl: false,
    streetViewControl: false,
    overviewMapControl: true
  };

  // initializing map
  map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);

  // geocoding
  var geocoding  = new google.maps.Geocoder();
  $("#encode_address").click(function(){
    codeAddress(geocoding);
  });

  codeAddress(geocoding);
}

var info;
function codeAddress(geocoding){
  var address = $("#address_map_box").val();

  if(address.length > 0){
    geocoding.geocode({'address': address},function(results, status){
      if(status == google.maps.GeocoderStatus.OK){
        map.setCenter(results[0].geometry.location);
        var marker  =  new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        });
        }else{
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  }else{
    alert("Search field can't be blank");
  }
}

function loadScript() {
	console.log("map loading ...");
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
    // '&v=3.24'+
    '&key=AIzaSyBJYFdplGeKUUEmGZ-vL4ydiSZ09Khsa_o'+
    '&libraries=drawing'+
    '&callback=initialize';
  document.body.appendChild(script);
  console.log("map done");
}

$(document).ready(function() {
  loadScript();

	// Resize map to show on a Bootstrap's modal
	$('#mapContainer').on('shown.bs.collapse', function() {
		var currentCenter = map.getCenter();  // Get current center before resizing
		google.maps.event.trigger(map, "resize");
		map.setCenter(currentCenter); // Re-set previous center
	});

  $(window).resize(function() {
		var currentCenter = map.getCenter();  // Get current center before resizing
		google.maps.event.trigger(map, "resize");
		map.setCenter(currentCenter); // Re-set previous center
  });
});
