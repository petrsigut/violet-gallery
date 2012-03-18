   jQuery(document).ready(function() { 
   if ((jQuery.browser.msie) || 
       (jQuery.browser.mozilla && jQuery.browser.version.substr(0,3)=="1.9")) {
      jQuery('.tphoto').each(function() { 
          jQuery(this).hover(function(e) { 
              jQuery(this).stop().animate({ opacity: 0.7 }, 700); 
          }, 
          function() { 
              jQuery(this).stop().animate({ opacity: 1.0 }, 100); 
          }); 
          });  
}
});

