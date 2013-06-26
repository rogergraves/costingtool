if(window.location.href.slice(-1) === "#"){
    document.location = window.location.href.slice(0,-1)
}

// Press selection display logic
function checkBox(element) {
    element.addClass("selected-press");
}

function continueButtonShowing(){
    if($(".next-page.press-selection").css('display') != "none"){
        return true;
    } else {
        return false;
    }
}

$(".press-checkbox").click(function() {
    if($(".press-checkbox.selected-press").length < 2 && !$(this).hasClass("selected-press")){
        $(this).addClass("selected-press");
        if(!continueButtonShowing()){
            $(".next-page.press-selection").fadeIn();
        }
    } else if($(this).hasClass("selected-press")){
        $(this).removeClass("selected-press")
        if($(".press-checkbox.selected-press").length == 0) {
            $(".next-page").fadeOut();
        }
    }
});

// END - Press selection display logic

if($($(".other-jobs-container")[0]).length == 0){
    $(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").hide();
}



$(".next-arrow.press-cost-summary").click(function(){
    var press_types = []
    $(".press-checkbox.selected-press").each(function() { press_types.push( $(this).attr("id") )})

    $.ajax({
        type: "POST",
        url: "/press_jobs/log_presses",
        data: { presses: JSON.stringify(press_types)},
        success:function() {
            document.location = "/press_jobs"
        },
        error:function(request) {
            console.log("failed request: ", request);
            alert("There seems to be a problem, please refresh the page and try again")
        }
    });
})

function getPresses(pressList){
    var cleanList = []
    pressList.each(function(){
        cleanList.push($(this).parent().text().trim());
    })
    return cleanList
}

$("input.press-job-values").change(function(){
    $("input.press-job-values").trigger('focusin');
    $(this).parents("form").submit();
    $("input.press-job-values").trigger('focusout');
});

$("input.press-job-values").focusout(function(){
    var n = this.value;

    if(n) {
        var fixed = 0;
        if($(this).hasClass('two-decimal')) fixed = 2;
        if($(this).hasClass('five-decimal')) fixed = 5;

        this.value = (parseFloat(n.currencyToFloat())).formatToCurrency('USD', fixed);
    }
});

$("input.press-job-values").focusin(function() {
    if(this.value) this.value = (this.value).currencyToFloat();
});

// Format everything nicely on load
if($("input.press-job-values") && $("input.press-job-values").length > 0) {
    $("input.press-job-values").trigger('focusout');
}

// Carousel arrow display logic
$(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").click(function(){
    var slideOne = $(".first-job")
    var slideTwo = $($(".other-jobs-container")[0])
    var slideThree = $($(".other-jobs-container")[1])
    var slideFour = $($(".other-jobs-container")[2])
    var slideFive = $($(".other-jobs-container")[3])

    if(slideOne.css("display") != "none"){
        removeRightArrow(slideThree)
        slideOne.hide();
        slideTwo.fadeIn();
        $(".foundicon-left-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").show()
    } else if(slideTwo.css("display") != "none") {
        removeRightArrow(slideFour)
        slideTwo.hide();
        slideThree.fadeIn();
    } else if(slideThree.css("display") != "none") {
        removeRightArrow(slideFive)
        slideThree.hide();
        slideFour.fadeIn();
    } else if(slideFour.css("display") != "none") {
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").hide()
        slideFour.hide();
        slideFive.fadeIn();
    }
})


$(".foundicon-left-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").click(function(){
    var slideOne = $(".first-job")
    var slideTwo = $($(".other-jobs-container")[0])
    var slideThree = $($(".other-jobs-container")[1])
    var slideFour = $($(".other-jobs-container")[2])
    var slideFive = $($(".other-jobs-container")[3])

    if(slideTwo.css("display") != "none"){
        slideTwo.hide();
        slideOne.fadeIn();
        $(".foundicon-left-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").hide()
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").show()
    } else if(slideThree.css("display") != "none") {
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").show()
        slideThree.hide();
        slideTwo.fadeIn();
    } else if(slideFour.css("display") != "none") {
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").show()
        slideFour.hide();
        slideThree.fadeIn();
    } else if(slideFive.css("display") != "none") {
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").show()
        slideFive.hide();
        slideFour.fadeIn();
    }
})

function removeRightArrow(slide) {
    if(slide.length === 0){
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").hide()
    }
}
// END - Carousel arrow display logic

function preCheckBoxes() {
    if (location.pathname == "/press_jobs/new"){
        for( i = 0; i< window.presses.length; i++) {
            var selected = $("#" + window.presses[i]);
            checkBox(selected);
        }
        if(window.presses){
            $(".next-page.press-selection").fadeIn();
        }
    }
}

function formatPanels(){
    if($(".right-press").length == 0){
        $(".left-press").css("float", "none");
    }
}

$(window).load(preCheckBoxes(), formatPanels());
