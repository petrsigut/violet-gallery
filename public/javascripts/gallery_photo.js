
function show_map() {
  if ($('map_canvas').style.height == "0px") {
    photo_height = $('photo_full').height;
    photo_width = $('photo_full').width;
    $('map_canvas').style.height=photo_height+"px";
    $('map_canvas').style.width=photo_width+"px";
    //initialize_map();
    $('photo_full').style.display="none";
    google.maps.event.trigger(window.map, 'resize');
    window.map.setCenter(window.latlng);
    
  }
    else {
      $('photo_full').style.display="inline";
      $('map_canvas').style.height=0+"px";
      $('map_canvas').style.width=0+"px";
    }
};



// http://garbageburrito.com/blog/entry/30/automatic-ajax-loading-images-with-prototype
var loaded = false;

  function startLoading() {
    loaded = false;
    window.setTimeout('showLoadingImage()', 500);
  }

  function showLoadingImage() {
    var el = document.getElementById("loading_box");
    if (el && !loaded) {
        el.innerHTML = '<img src="/images/ajax-loader.gif">';
        new Effect.Appear('loading_box');
    }
  }

function stopLoading() {
    Element.hide('loading_box');
    loaded = true;
    Cufon.replace('h1, h2, h3, #statement');
  }

 Ajax.Responders.register({
    onCreate : startLoading,
    onComplete : stopLoading
  });


