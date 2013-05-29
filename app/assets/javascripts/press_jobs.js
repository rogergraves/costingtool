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
    console.log("clicked1")
    var press_types = $(".custom.press-jobs-table label span.checked")
    console.log("clicked2")
    var presses = getPresses(press_types)
    console.log("clicked3")

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
    $(".first-job").hide();
    $(".other-jobs-container").fadeIn();
})


$(".foundicon-left-arrow.icon-tiny.next-arrow.press-cost-summary-carousel").click(function(){
    $(".other-jobs-container").hide();
    $(".first-job").fadeIn();
})