var widt = false;

$(document).ready(function() {


	//color picker
	$('#colorpickerHolder').ColorPicker({
		flat: true,
		color: $('#course_color').val(),
		onSubmit: function(hsb, hex, rgb) {
			$('#colorSelector div').css('backgroundColor', '#' + hex);
			$('#course_color').val(hex);
			colorpicker_toggle();
		}
	});
	$('#colorpickerHolder>div').css('position', 'absolute');

	
	$('#colorSelector').bind('click', function() { colorpicker_toggle(); });

	// all day schedule disables time pickers
	$('#assignment_all_day').click(function() {
		checked = $(this).is(':checked');
		field_disabled('#assignment_start_date_4i', checked);
		field_disabled('#assignment_start_date_5i', checked);

		field_disabled('#assignment_due_date_4i', checked);
		field_disabled('#assignment_due_date_5i', checked);
	});

	
});

function colorpicker_toggle() {
	$('#colorpickerHolder').stop().animate({height: widt ? 0 : 173}, 300);
	widt = !widt;
}