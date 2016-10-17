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
				selectConstraint:{
				      start: '00:00', 
				      end: '24:00', 
				    },
			    dayRender: function(daysOfWeek, cell){

				        if(($.inArray(daysOfWeek.format('YYYY-MM-DD'),workdays)===-1)){
				            $(cell).addClass('testing_background');
				        }else{
				            $(cell).removeClass('testing_background');
				        }
				    },
			    events:function(start, end, timezone, callback) {
			    	// holiday history record
					
			    	$.ajax({
			    		type: 'POST',
						beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
						data: {start_date: start.format('YYYY-MM-DD'), end_date: end.format('YYYY-MM-DD')},
						dataType: 'json',
						url: '/holiday_history',
						success: function(holiday_dates){
							var holidays = []
							$.each(holiday_dates,function(index,date){
								holidays.push({title:date.holiday_name, start:date.workdate})
							})
							callback(holidays)
						}
			    	})
					
			    },
			    eventClick: function(event, element) {
			    	// holiday updates
			    	//choice to delete or change event
			    	var radios = $(':radio')
					var i = 0, len = radios.length
					var checked = false
					var holidayOption
					for( ; i < len; i++ ) {
					    if(radios[i].checked) {
					      checked = true
					      holidayOption = radios[i].value
					    }
					} 
			    	if(holidayOption==="update"){
				    	var event_title = prompt("What is the name holiday?")

				        event.title = event_title;
				    	$.ajax({
				    		type: 'POST',
							beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
							data: {holiday_name:event_title,holiday_action:holidayOption, date:event.start.format("YYYY-MM-DD")},
							dataType: 'json',
							url: '/holiday_update',
							success: function(data){

							}
				    	})
				        $('#calendar').fullCalendar('updateEvent', event);
			    	}else if(holidayOption === "remove"){
				    	$.ajax({
				    		type: 'POST',
							beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
							data: {holiday_action:holidayOption,date:event.start.format("YYYY-MM-DD")},
							dataType: 'json',
							url: '/holiday_update',
							success: function(data){
							}
				    	})
			    		$('#calendar').fullCalendar('removeEvents',event._id)
			    	}
			    },
	            select: function(start, end, allDay){
				    if(($.inArray(start.format('YYYY-MM-DD'),workdays)!==-1)){
				    	var event_title = prompt("What is the name holiday?")
				    	var source = [{title:event_title,start:start}]
				    	var holiday_data = {holiday_name:event_title,date:start.format("YYYY-MM-DD"),holiday_action:"create"}
				    	$.ajax({
				    		type: 'POST',
							beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
							data: holiday_data,
							dataType: 'json',
							url: '/holiday_update',
							success: function(data){
							}
				    	})
				    	$('#calendar').fullCalendar( 'addEventSource', source )
				    }else{
				    	alert("Not a workday.")
				    }
				  }
	        	});
    		}

    	});
  	});