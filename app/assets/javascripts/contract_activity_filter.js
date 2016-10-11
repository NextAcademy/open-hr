$(document).on('ready', function(){

	$('#filter_btn').click(function(){
		var search_parameters = {date_from:$('#date_from').val(),date_to:$('#date_to').val()}
		$.ajax({
			type: 'POST', 
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			url: '/filter_staff_by_contracts',
			data: search_parameters,
			dataType: "json",
			success: function(data){
				var html_replace = ""

				$.each(data,function(index,staff){
					var third_cell = ""
					if(staff[1]===true){
						var third_cell = "<button name = button type = submit class = warning>Warning!</button>"
					}
					html_replace = html_replace + "<tr><td> Staff : <a href=/staffs/"+staff[0].id+">"+staff[0].name+"</a></td><td><a href=/staffs/"+staff[0].id+"/edit>Edit</a></td><td style=color:red>"+third_cell+"</td></tr>"
				})
				$("#filter_result").html(html_replace)

			}
		})
	})
})

