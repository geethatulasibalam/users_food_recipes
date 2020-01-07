function myFunction(){
	$("#sort").change(function(){
 	  $.ajax({
 		  url: 'http://10.90.90.148:5000/dishes/search',
 		  type:'POST',
 		  dataType: "script",
 		  data:{sort: this.value},
 		  success: function(response){	
 		  },
 	  });
  });
  $('#search-field').autocomplete({
    source: function (request, response) {
   	var c_id = $('#category_select').find(':selected').val();
	    $.ajax({
	      url: "/dishes/autocomplete",  
	      dataType: 'json',
	      data: { term: request.term,category:c_id },
	      success: function(data) {
	        response(data);
	      }
	    });
  	}
  });
  if($('.pagination').length){
	  $(window).scroll(function(){
	  	var url = $('.pagination .next_page').attr('href')
	  	if(url && $(window).scrollTop() > $(document).height() - $(window).height() - 50 ){
	  		$('.pagination').text(" ")
	  		$(".loading-spinner").show();
	  		$.getScript(url)
	  	}
	  })
	  $(window).scroll();
	}
	$(".fa-times").click(function(){
		$("#dish_search input[type='text']").val('');
	})
	$(".loading-spinner").hide();
}
function formValidate(){
	$("#new_dish").validate({
		rules:{
			"dish[name]":{
				required:true
			},
			"dish[price]":{
				required:true,
				digits:true,
			},
			"dish[images_attributes][0][image]":{
				required:true
			},
			"dish[description]":{
				required:true
			}
		},
		messages:{
			"dish[name]":{
				required:"Dish Name Is Required"
			},
			"dish[price]":{
				required:"Price Is Required",
				digits: "Please Enter Numbers"
			},
			"dish[images_attributes][0][image]":{
				required:"Image Is Required"
			},
			"dish[description]":{
				required:"Description Is Required"
			}
		},
		errorElement : 'span',
    errorLabelContainer: '.errorTxt',
		errorPlacement: function(error,element) {
      error.appendTo(element.next());
    }
	})
}
function fileUpload(){
	$('.image-preview-filename').css('cursor','not-allowed');
	  var img = $('<img/>', {
      id: 'dynamic',
      width:250,
      height:200
    }); 
  // Create the preview image
  $(".image-preview-input input:file").change(function (){     
    var file = this.files[0];
    var reader = new FileReader();
    // Set preview image into the popover data-content
    reader.onload = function (e) {
        $(".image-preview-input-title").text("Change");
        $(".image-preview-filename").val(file.name);            
        img.attr('src', e.target.result);
    }        
    reader.readAsDataURL(file);
  });  
};