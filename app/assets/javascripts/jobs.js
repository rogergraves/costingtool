//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.

if ($(".jobs-table").length > 0 && $(".jobs-table tr").length === 0){
    $(".jobs-area").fadeOut("slow", function(){
        $(".new-job").fadeIn();
        $("input#job_name").focus();
    });
}

$(".foundicon-plus").click(function(){
    $(".jobs-area").fadeOut("slow", function(){
        $(".new-job").fadeIn();
        $("input#job_name").focus();
    });
})


$("input#job_copies_per_job.new-selector").keyup(function() {
    var jobs = $("#job_copies_per_job.new-selector").val();
    var copies = $("#job_number_of_jobs.new-selector").val();
    var pages = $("#job_pages_per_month.new-selector");
    var pagesTotal = jobs * copies;
    pages.val(pagesTotal);
})

$("input#job_number_of_jobs.new-selector").keyup(function() {
    var jobs = $("#job_copies_per_job.new-selector").val();
    var copies = $("#job_number_of_jobs.new-selector").val();
    var pages = $("#job_pages_per_month.new-selector");
    var pagesTotal = jobs * copies;
    pages.val(pagesTotal);
})

$('#job_copies_per_job.new-selector').keydown(function(e) {
    var keyCode = e.keyCode || e.which;
    if (keyCode == 9) {
        $(".job-size.new-selector div.custom.dropdown a.selector").click();
        $("div.new-selector input#job_multicolor_clicks").focus();
    }
});

$("input#job_multicolor_clicks.new-selector").keyup(function() {
    if ($("input#job_multicolor_clicks.new-selector").val() > 6){
        alert("The maximum number of multicolor clicks is 6");
        $("div.new-selector input#job_multicolor_clicks").val("");
    }
})


$('#job_number_of_pages.new-selector').keydown(function(e) {
    var keyCode = e.keyCode || e.which;

    if (keyCode == 9) {
        $(".new-selector .custom.dropdown a.current").click();
        $("#job_sale_price").focus();
    }
});


$(".job-pane").hover(function(){
    $(".hover-reveal").toggle("slow");
})

Number.prototype.formatWithCommas = function(sep) {
    var n = this;
    return n.toString().replace(/\B(?=(?:\d{3})+(?!\d))/g, sep || ',');
}

$(document).ready(function() {
    var update_calcs = function() {
        var number_of_jobs = $('#number_of_jobs').val() || 0;
        var copies_per_job = $('#copies_per_job').val() || 0;
        var number_of_pages = $('#number_of_pages').val() || 0;

        $('#copies_per_month').text((copies_per_job * number_of_jobs).formatWithCommas());
        $('#pages_per_month').text((copies_per_job * number_of_jobs * number_of_pages).formatWithCommas());

    }

    $('#number_of_jobs').change(update_calcs);
    $('#copies_per_job').change(update_calcs);
    $('#number_of_pages').change(update_calcs);

    // Only allow integers to be entered
    $('#number_of_jobs').bind('input', function() {
        $(this).val($(this).val().replace(/[^0-9]/gi, ''));
    });
    $('#copies_per_job').bind('input', function() {
        $(this).val($(this).val().replace(/[^0-9]/gi, ''));
    });
    $('#number_of_pages').bind('input', function() {
        $(this).val($(this).val().replace(/[^0-9]/gi, ''));
    });
});
