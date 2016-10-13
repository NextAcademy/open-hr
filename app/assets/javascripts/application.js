// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require moment 
//= require fullcalendar


    $(document).ready(function(){
    	$.ajax({
			type: 'POST', 
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			url: '/load_calendar',
			success: function(dates){
					var today = new Date
				    var workdays = dates
				$('#calendar').fullCalendar({
				year: today.getFullYear(),
				month: today.getMonth(),
				day: today.getDate(),
	            editable: true,
	            eventLimit: true, 
	            selectable: true,
			    dayRender: function(daysOfWeek, cell){

				        if(($.inArray(daysOfWeek.format('YYYY-MM-DD'),workdays)===-1)){
				            $(cell).addClass('testing_background');
				        }else{
				            $(cell).removeClass('testing_background');
				        }
				    },
			    events: function(start, end, callback) {
			    },
			    eventClick: function(event, element) {
			    	debugger
			        event.title = "CLICKED!";

			        $('#calendar').fullCalendar('updateEvent', event);

			    },
	            select: function(start, end, allDay){
				    if(($.inArray(start.format('YYYY-MM-DD'),workdays)!==-1)){
				    }else{

				    }
				  }
	        	});
    		}

    	});
  	});