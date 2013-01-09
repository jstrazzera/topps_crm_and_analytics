;(function($) {
    $.fn.textfill = function(options) {
        var fontSize = options.maxFontPixels;
        var ourText = $('span:visible:first', this);
        var maxHeight = $(this).height();
        var maxWidth = $(this).width();
        var textHeight;
        var textWidth;
        alert("this is running");
        do {
            ourText.css('font-size', fontSize);
            textHeight = ourText.height();
            textWidth = ourText.width();
            fontSize = fontSize - 3;
        } while ((textHeight > maxHeight || textWidth > maxWidth) && fontSize > 3);
        return this;
    }
})(jQuery);


$(document).ready(function() {
	$(".hover_hotspot").hover(
			function(){
				var img = $(this).parent().children(".hover_fan");
				$(this).parent().children(".hover_message_box").show();
				var str = img.attr("data-hoveravatar");
				img.attr("src", str);
				img.css("z-index", parseInt(img.css("z-index")) + 2);
			},
	 		function(){
				var img = $(this).parent().children(".hover_fan");
				$(this).parent().children(".hover_message_box").hide();

				var str = img.attr("data-avatar");
				img.attr("src", str);
				img.css("z-index", parseInt(img.css("z-index")) - 2);

			}
 		);

		// $('.hover_message').textfill({ maxFontPixels: 36 });


});

$(document).ready(function() {
	$.fn.textWidth = function(){
  var html_org = $(this).html();
  var html_calc = '<span>' + html_org + '</span>';
  $(this).html(html_calc);
  var width = $(this).find('span:first').width();
  $(this).html(html_org);
  return width;
	};


	$(".hover_message_box").each(function() {
		if($(this).text().length > 55){
			var fsize = parseInt($(this).css("font-size")) - 1.25 + "px";
			$(this).css("font-size", fsize )
		}
	})

});


