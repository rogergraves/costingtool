//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.



$(document).ready(function() {

    $(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").hide();

    $('#press_1').fadeIn();
    $('#press_1_table').fadeIn();
    $('#press_1_header').fadeIn();

    var press_job_ids = window.press_job_ids;
    var press_job_count = window.press_job_ids.length;

    var cost_array = function(chart_id) {
        return window.costs[chart_id].toString();
    };

    var revenue_array = function(chart_id) {
        return window.revenue[chart_id].toString();
    };

    for(var i = 0; i < press_job_count; ++i) {
        var chart_id = press_job_ids[i]
        var current_chart = $('#chart_'+ chart_id);
        current_chart.highcharts({
            chart: {
                type: 'spline'
            },
            credits: {
                enabled: false
            },
            title: {
                text: null
            },
            xAxis: {
                title: 'Year',
                labels: {
                    formatter: function() {
                        return this.value;
                    }
                },
                min: 0,
                max: 7,
                tickInterval: 1
            },
            yAxis: {
                title: {
                    text: null
                },
                labels: {
                    formatter: function() {
                        return '$'+Highcharts.numberFormat(this.value, 0)
                    }
                },
                min: 0
            },
            tooltip: {
                formatter: function() {
                    return '<b>' + this.series.name + '</b><br/>Year '+this.x+', $' + Highcharts.numberFormat(this.y);
                }
            },

            series: [{
                name: 'Costs',
                data: JSON.parse(cost_array(chart_id)),
                color: '#BF5E7B'
            }, {
                name: 'Revenue',
                data: JSON.parse(revenue_array(chart_id)),
                color: '#2f7ed8'
            }]
        });
    }

    $('#press_2').hide();

});


// Carousel arrow display logic
$(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").click(function(){
    var slideOne = $(".first-presstype");
    var slideTwo = $(".last-presstype");

    if(slideTwo.css("display") != "none"){
        slideTwo.hide();
        slideOne.fadeIn();
        $(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").hide()
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-roi-carousel").show()
    }
})

$(".foundicon-right-arrow.icon-tiny.next-arrow.press-roi-carousel").click(function(){
    var slideOne = $(".first-presstype");
    var slideTwo = $(".last-presstype");

    if(slideOne.css("display") != "none"){
        $(".foundicon-right-arrow.icon-tiny.next-arrow.press-roi-carousel").hide()
        slideOne.hide();
        slideTwo.fadeIn();
        $(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").show()
    }
})