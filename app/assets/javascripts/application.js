// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(document).foundation();


//Sign in error formatting
if($('#flash_alert').length && $("#new_user").length){
    $("#new_user").prepend("<br />")
}

//Reset instructions will soon be sent to your email
if($('#flash_notice').length && $("#new_user").length){
    $("#new_user").prepend("<br />");
}

//Allows users to click outside of modal to close it
$(document).mouseup(function (e)
{
    var container = $("ul#drop1");

    if (container.has(e.target).length === 0)
    {
        container.hide();
    }
});

//determines completion steps

var stage = document.location.pathname

switch (stage) {
    case "/jobs": case "/": case "":
        $(".step.job-basket").addClass("selected-step")
        break;
    case "/press_jobs/new":
        $(".step.job-basket").addClass("selected-step")
        $(".step.press-select").addClass("selected-step")
        break;
    case "/press_jobs":
        $(".step.job-basket").addClass("selected-step")
        $(".step.press-select").addClass("selected-step")
        $(".step.press-cost-summary").addClass("selected-step")
        break;
}
