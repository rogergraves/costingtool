var can_user_check_this = function(this_is_checked) {
    var total_checked = $('.custom.checkbox.checked').length;

    this_is_checked ? total_checked++ : total_checked--; // Adjust for length being delayed (this listener code is run before box is actually checked)

    if(total_checked > 2) {
        return false; // Too many selected, so don't allow it to be checked
    } else if(total_checked > 0) {
        $(".next-page").fadeIn();
    } else {
        $(".next-page").fadeOut();
    }

    return true;
}

$("label.press-checkbox").click(function() {
    var this_is_checked = !$($(this).context.children[1]).hasClass("checked");
    return can_user_check_this(this_is_checked);
});


$(".next-arrow.press-cost-summary").click(function(){
    var press_types = $(".custom.press-jobs-table label span.checked")
    var presses = getPresses(press_types)

    $.ajax({
        type: "POST",
        url: "/press_jobs/log_presses",
        data: { presses: JSON.stringify(presses)},
        success:function() {
            document.location = "/press_jobs"
        },
        error:function(request) {
            console.log("failed request: ", request);
            alert("fail")
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
    $(this).parents("form").submit();
})

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
