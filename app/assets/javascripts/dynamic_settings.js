$(document).on('ready',function(){
	$('#work_day input[type=checkbox]').on('click',function(){
		if (this.checked){
			$('#half_day #'+this.id).removeAttr("disabled")
			$('#off_day #'+this.id).attr("disabled",true)			
		}else if (!this.checked){
			$('#half_day #'+this.id).attr({"disabled":true,"checked":false})
			$('#off_day #'+this.id).removeAttr("disabled")	
		}		
	})
	$('#off_day input[type=checkbox]').on('click',function(){
		if (this.checked){
			$('#work_day #'+this.id).attr("disabled",true)			
		}else if (!this.checked){
			$('#work_day #'+this.id).removeAttr("disabled")	
		}		
	})
})

