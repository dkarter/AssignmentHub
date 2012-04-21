// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery-ui-timepicker-addon
//= require jquery_ujs
//= require autocomplete-rails


//for color picker - TODO: Convert to jQuery
//create unobtrosive bind to handle color pick automatically determining color

//also using https://github.com/trentrichardson/jQuery-Timepicker-Addon

$(document).ready(function() {
	//fade out animation on delete from indexes
	$('.delete_from_index').bind('ajax:success', function() {
			$(this).closest('tr').fadeOut();
	});
	
	//date picker
	$('input[name*="date"]').datetimepicker({
								ampm: true
							});
	
});

function remove_field(link) {
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest(".fields").fadeOut();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}
