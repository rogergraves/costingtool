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

//Tabbing Logic

$('#copies_per_job_new_job.new-selector').keydown(function(e) {
    var keyCode = e.keyCode || e.which;
    if (keyCode == 9) {
        $(".job-size.new-selector div.custom.dropdown a.selector").click();
        $("div.new-selector input#job_multicolor_clicks").focus();
    }
});

$('#number_of_pages_new_job').keydown(function(e) {
    var keyCode = e.keyCode || e.which;
    if (keyCode == 9) {
        $(".new-selector .custom.dropdown a.current").click();
        $("input#job_sale_price").focus();
    }
});

$('.copies_per_job_edit_job').keydown(function(e) {
    var form = $(e.target.form)
    var selector = $(form.context[6].nextSibling.childNodes[1])
    var next = $(form.context[7])
    var keyCode = e.keyCode || e.which;
    if (keyCode == 9) {
        selector.click();
        next.focus();
    }
});

$('.number_of_pages_edit_job').keydown(function(e) {
    var form = $(e.target.form)
    var selector = $(form.context[10].nextSibling.childNodes[1])
    var next = $(form.context[11])
    var keyCode = e.keyCode || e.which;
    if (keyCode == 9) {
        selector.click();
        next.focus();
    }
});

// end of tabbing logic

$("input#job_multicolor_clicks.new-selector").keyup(function() {
    if ($("input#job_multicolor_clicks.new-selector").val() > 6){
        alert("The maximum number of multicolor clicks is 6");
        $("div.new-selector input#job_multicolor_clicks").val("");
    }
})


$("input#job_job_percentage").change(function(e){
    current_target = parseInt($(e.currentTarget))
    var placeholder =  parseInt($(e.currentTarget).attr("placeholder"))
    if(parseInt($(e.currentTarget).val()) > placeholder) {
        alert("You cannot assign more than " + placeholder + "%");
        $(e.currentTarget).val(placeholder);
    }
})


$(".job-pane").hover(function(){
    $(".hover-reveal").toggle("slow");
})

Number.prototype.formatWithCommas = function(sep) {
    var n = this;
    return n.toString().replace(/\B(?=(?:\d{3})+(?!\d))/g, sep || ',');
}

function cancelNewJob() {
    $(".new-job").hide();
    $(".jobs-area").show();
}

$(document).ready(function() {
    $('form').each(function() {
        var id = this.id

        var number_of_jobs_obj = $('#number_of_jobs_'+id);
        var copies_per_job_obj = $('#copies_per_job_'+id);
        var number_of_pages_obj = $('#number_of_pages_'+id);

        $.each([number_of_jobs_obj, copies_per_job_obj, number_of_pages_obj], function(index, obj) {
            obj.change(function() {
                obj.val(obj.val().replace(/[^0-9]/gi, ''));

                var number_of_jobs = $('#number_of_jobs_'+id).val() || 0;
                var copies_per_job = $('#copies_per_job_'+id).val() || 0;
                var number_of_pages = $('#number_of_pages_'+id).val() || 0;

                $('#copies_per_month_'+id).text((copies_per_job * number_of_jobs).formatWithCommas());
                $('#pages_per_month_'+id).text((copies_per_job * number_of_jobs * number_of_pages).formatWithCommas());
            });
        });
    });
});
