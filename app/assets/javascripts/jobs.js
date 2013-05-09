//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.

$(".foundicon-plus").click(function(){
    $(".jobs-area").fadeOut("slow", function(){
        $(".new-job").fadeIn();
    });
})
