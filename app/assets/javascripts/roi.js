//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.



$(document).ready(function() {

    $(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").hide();

    $('#press_1').fadeIn();
    $('#press_1_table').fadeIn();
    $('#press_1_header').fadeIn();

    var revenue_array = function(index) {
        var costs = [[1200000, 1320000, 1452000, 1597200, 1756920, 1932612, 2125873], [587986, 809070, 1052263, 1319775, 1614038, 1937727, 2293786]];

        return costs[index-1];
    };

    var cost_array = function(index) {
        var costs = [[671878, 846495, 1038573, 1249858, 1482273, 1737929, 2019150], [1200000, 1320000, 1452000, 1597200, 1756920, 1932612, 2125873]];

        return costs[index-1];
    };

    for(var i = 1; i <= 2; ++i) {
        console.log("$('#press_'+i)", $('#press_'+i));
        $('#press_'+i).highcharts({
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
                data: cost_array(i),
                color: '#BF5E7B'
            }, {
                name: 'Revenue',
                data: revenue_array(i),
                color: '#2f7ed8'
            }]
        });
    }

    $('#press_2').hide();

});


// Carousel arrow display logic
$(".foundicon-right-arrow.icon-tiny.next-arrow.press-roi-carousel").click(function(){

    $(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").show();
    $(".foundicon-right-arrow.icon-tiny.next-arrow.press-roi-carousel").hide();

    $("#press_1").hide();
    $("#press_1_header").hide();
    $("#press_1_table").hide();
    $("#press_2").fadeIn();
    $("#press_2_header").show();
    $("#press_2_table").fadeIn();
});


$(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").click(function(){

    $(".foundicon-left-arrow.icon-tiny.next-arrow.press-roi-carousel").hide();
    $(".foundicon-right-arrow.icon-tiny.next-arrow.press-roi-carousel").show();

    $("#press_2").hide();
    $("#press_2_header").hide();
    $("#press_2_table").hide();
    $("#press_1").fadeIn();
    $("#press_1_header").show();
    $("#press_1_table").fadeIn();
});
