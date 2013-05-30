$("span.custom.checkbox").click(function(){
    if($("span.custom.checkbox.checked").length > 0) {
        $(".press-jobs-table").mousemove(function(){
            if($("span.custom.checkbox.checked").length === 0) {
                $(".next-page").fadeOut();
            }
        })
    }
    else {
        $(".next-page").fadeIn();
    }
})


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


$(".foundicon-right-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").click(function(){
    var slideOne = $(".first-job")
    var slideTwo = $($(".other-jobs-container")[0])
    var slideThree = $($(".other-jobs-container")[1])
    var slideFour = $($(".other-jobs-container")[2])
    var slideFive = $($(".other-jobs-container")[3])

    if(slideOne.css("display") != "none"){
        slideOne.hide();
        slideTwo.fadeIn();
    } else if(slideTwo.css("display") != "none") {
        slideTwo.hide();
        slideThree.fadeIn();
    } else if(slideThree.css("display") != "none") {
        slideThree.hide();
        slideFour.fadeIn();
    } else if(slideFour.css("display") != "none") {
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
    } else if(slideThree.css("display") != "none") {
        slideThree.hide();
        slideTwo.fadeIn();
    } else if(slideFour.css("display") != "none") {
        slideFour.hide();
        slideThree.fadeIn();
    } else if(slideFive.css("display") != "none") {
        slideFive.hide();
        slideFour.fadeIn();
    }
})




$("input.press-job-values").change(function(){
    $(this).parents("form").submit();
})