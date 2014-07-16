$(document).ready(function(){
 console.log('buttons ready');
})
function doFunction(sched, shift, volunteer) {
     	el="#button"+shift;
	b=$(el).html
	console.log('button says '+b);
	if (b == volunteer) {
     		console.log('unsetting '+volunteer+ ' at '+el);
        	$(el).html('');
	} else {
     		console.log('setting '+volunteer+ ' at '+el);
        	$(el).html(volunteer);
	}

     	list=$('#mylist').html()+'<br/>['+shift+', '+volunteer+']'
	console.log('creating list string '+list);
	
	
	//var s=sessionStorage.getItem("taskData");
	//var s=$.session.get("taskData");
	//var s=Session["taskData"];
	jsonData=JSON.parse(sessionStorage.getItem("taskData"));
	if (jsonData == null) {
		jsonData={"schedule": sched, "tasks": []};
	} 
	//alert("session "+JSON.stringify(jsonData));
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

        $('#mylist').html(taskstr);
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
		sessionStorage.removeItem("taskData")
    		alert("Post returned status: " + status + " and then we cleared session storage. Please refresh page.");
	  }
	});
}
