$(document).ready(function(){
 console.log('buttons ready');
})
function doFunction(sched, shift, volunteer, label) {
     	el="#button"+shift;
	console.log('button says '+label);
	if (label == volunteer) {
     		console.log('unsetting '+volunteer+ ' at '+el);
        	$(el).html('');
		$(el).css( "background","pink")
		act='D';
	} else if (label != '') {
     		console.log('changing '+label+' to '+volunteer+ ' at '+el);
        	$(el).html(volunteer);
		$(el).css( "background","#A9A9F5")
		act='M'
	} else {
     		console.log('setting '+volunteer+ ' at '+el);
        	$(el).html(volunteer);
		$(el).css( "background","lightblue")
		act='A'
	}

     	list=$('#mylist').html()+'['+act+shift+', '+volunteer+']'
	console.log('creating list string '+list);
	
	
	//var s=sessionStorage.getItem("taskData");
	//var s=$.session.get("taskData");
	//var s=Session["taskData"];
	jsonData=JSON.parse(sessionStorage.getItem("taskData"));
	if (jsonData == null) {
		jsonData={"schedule": sched, "tasks": []};
	} 
	var task = {
	  "volunteer": volunteer,
	  "shift": shift
 	}
	jsonData.tasks.push(task)
	taskstr=JSON.stringify(jsonData);
	console.log('creating session json data '+taskstr);
	//$.session.set("taskData", "jsonData");
	//sessionStorage.setItem("taskData", jsonData);
	sessionStorage.setItem("taskData", taskstr);

        //$('#mylist').html(taskstr);
     	$('#mylist').html(list);
	console.log('creating html string from json data'+taskstr);
}

function do_jswork() {
	//get sessionstore
	//post to /schedules/do_work
	taskstr=sessionStorage.getItem("taskData")
	jsonData=JSON.parse(taskstr);
	if (jsonData == null) {
		alert("task data is empty");
		return;
	} 
	sched=jsonData.schedule;
	console.log("js do_jswork for schedule: "+sched+" : "+taskstr);
	//$.post("/schedules/do_jswork/",taskstr, function(data,status){
    	//	alert("Post returned status: " + status);
	//});
	//  beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	meta=$('meta[name="csrf-token"]').attr('content');
	console.log("js meta: "+meta);
	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': meta
	  }
	});
	console.log("ajax is setup");
	url="/schedules/do_jswork/"+sched;
	$.ajax({url: url,
	  type: 'POST',
	  data: taskstr, 
	  success: function(data,status){
		sessionStorage.removeItem("taskData");
    		//alert("Post returned status: " + status + " and then we cleared session storage. Please refresh page.");
	  }
	});
}
function cancel_jswork() {
	taskstr=sessionStorage.getItem("taskData")
	if (taskstr == null) {
		alert("No tasks in session to cancel");
		return;
	} 
	jsonData=JSON.parse(taskstr);
	if (jsonData.tasks == null) {
		alert("Nothing to cancel");
		return;
	} 
	sched=jsonData.schedule;
 	jsonData={"schedule": sched, "tasks": []};
	taskstr=JSON.stringify(jsonData);
	sessionStorage.removeItem("taskData");
	console.log("js cancel_jswork ");
	meta=$('meta[name="csrf-token"]').attr('content');
	console.log("js meta: "+meta);
	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': meta
	  }
	});
	console.log("ajax is setup");
	url="/schedules/do_jswork/"+sched;
	$.ajax({url: url,
	  type: 'POST',
	  data: taskstr, 
	  success: function(data,status){
    		//alert("Post returned status: " + status);
	  }
	});
}
