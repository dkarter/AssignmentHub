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
//= require fullcalendar
//= require gcal


var footerHeight = 0,
    footerTop = 0;

$(document).ready(function() {
	//fade out animation on delete from indexes
	$('.delete_from_index').bind('ajax:success', function() {
			$(this).closest('tr').fadeOut();
	});

	//date picker
	$('input[name*="date"]').datetimepicker({
		ampm: true
	});

	// force footer to bottom on dashboard
	if(window.location.href.indexOf("dashboard") > -1 || 
	window.location.href.indexOf("assignments/new")) {
		$(window).scroll(function() {position_footer();});
		$(window).resize(function() {position_footer();});
	}


	// all day schedule disables time pickers
	$('#assignment_all_day').click(function() {
		checked = $(this).is(':checked');
		field_disabled('#assignment_start_date_4i', checked);
		field_disabled('#assignment_start_date_5i', checked);

		field_disabled('#assignment_due_date_4i', checked);
		field_disabled('#assignment_due_date_5i', checked);
	});

	// Full Calendar Implementation
	$('#dashboard-calendar').fullCalendar({

		editable: true,
		header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay'
		},
		selectable: true,
		selectHelper: true,
		
		events: "/assignments?format=json",

		eventDrop: function(event, delta) {
			alert(event.title + ' was moved ' + delta + ' days\n' +
				'(should probably update your database)');
		},

		loading: function(bool) {
			if (bool) $('#loading').show();
			else $('#loading').hide();
		},

		select: function(start, end, allDay) {
			var title = prompt('Event Title:');
			if (title) {
				calendar.fullCalendar('renderEvent',
					{
						title: title,
						start: start,
						end: end,
						allDay: allDay
					},
					true // make the event "stick"
				);
			}
			calendar.fullCalendar('unselect');
		},
		
		//http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(assignment, dayDelta, minuteDelta, allDay, revertFunc){
            update_assignment(assignment, allDay);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(assignment, dayDelta, minuteDelta, revertFunc){
            update_assignment(assignment, null);
        }
		

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

function field_disabled (field, disabled) {
	$(field).prop('disabled', disabled);
}

function position_footer() {	
	$footer = $("#footer");
	footerHeight = $footer.height();
	footerTop = ($(window).scrollTop()+$(window).height()-footerHeight)+"px";

	if (($(document.body).height()+footerHeight) < $(window).height()) {
		$footer.css({
             position: "absolute", top: footerTop
        });
	} else {
		$footer.css({
             position: "static"
        })
	}
}

function update_assignment(assignment, allday) {
   	
	var assignment_data;
	
	if (allday != null)
		assignment_data = { assignment: { 
										   name: assignment.title,
                						   start_date: format_dt(assignment.start),
                						   due_date: format_dt(assignment.end),
 										   all_day: allday
										} 
				}, function (reponse) { 
						//alert('successfully updated task.'); 
				};
	else
		assignment_data = { assignment: { 
										  name: assignment.title,
            							  start_date: "" + format_dt(assignment.start),
            							  due_date: "" + format_dt(assignment.end) 
										}
			}, function (reponse) { 
				//alert('successfully updated task.'); 
			};
	
	// call update via RESTful call submitting the json command above
	$.update("/assignments/" + assignment.id, assignment_data);
	
}

function create_assignment (assignment) {
	$.update(
     "/assignments/new",
     { assignment: { name: assignment.title,
                start_date: "" + assignment.start,
                due_date: "" + assignment.end }
     }, 
		function (reponse) { 
			alert('successfully created task.'); 
		}
    );
}

function format_dt (dt) {
	return $.datepicker.formatDate("D M dd yy", dt) + " " + format_time(dt);
}

function format_time (dt) {
	var hh = dt.getHours()
	var mm = dt.getMinutes()

	 if (mm < 10)
	 	mm = "0" + mm
	 if (hh < 10)
	  	hh = "0" + hh
  
	return hh + ":" + mm;
}
