//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.

$(".foundicon-plus").click(function(){
    $(".jobs-area").fadeOut("slow", function(){
        $(".new-job").fadeIn();
        $("input#job_name").focus();
    });
})


$("input#job_copies_per_job").keyup(function() {
    var jobs = $("#job_copies_per_job").val();
    var copies = $("#job_number_of_jobs").val();
    var pages = $("#job_pages_per_month");
    var pagesTotal = jobs * copies;
    pages.val(pagesTotal);
})

$("input#job_multicolor_clicks").keyup(function() {
    if ($("input#job_multicolor_clicks").val() > 6){
        alert("The maximum number of multicolor clicks is 6");
        $("input#job_multicolor_clicks").val("");
    }
})