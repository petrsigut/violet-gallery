// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// all this also in photos_helper.rb!

document.observe("dom:loaded", function() {
Prototype.Browser.ff3 = Prototype.Browser.Gecko && parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("Firefox")+8)) <= 3;

  var next_key = function(event){
    if(event.keyCode == Event.KEY_RIGHT) {
      if (Prototype.Browser.IE) {
        $('next').click();
      }
      else if (Prototype.Browser.ff3) {
        window.location.href = document.getElementById('next').href;
      }
      else {
        $('next').simulate('click');
      }
    }
  }

 var prev_key = function(event){
    if (event.keyCode == Event.KEY_LEFT) {
      if (Prototype.Browser.IE) {
        $('prev').click();
      }
      else if (Prototype.Browser.ff3) {
        window.location.href = document.getElementById('prev').href;
      }
      else {
        $('prev').simulate('click');
      }
    }
  }

 document.observe('keydown', prev_key);
 document.observe('keydown', next_key);

  Form.getElements('new_comment').each(function(input)
  {
    Event.observe(input, 'focus', function(event){
      document.stopObserving('keydown');
    })
  });

  Form.getElements('new_comment').each(function(input) {
    Event.observe(input, 'blur', function(event){
      document.observe('keydown', prev_key);
      document.observe('keydown', next_key);
    })
  });

});

