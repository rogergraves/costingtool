//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.



$(document).ready(function() {

    var cost_array = function() {
        var starting_value = 1000000 + Math.floor(Math.random()*500000);
        var increase_by = 3+Math.floor(Math.random()*5);
        var last_value = starting_value;
        var costs = [];

        for(var i = 0; i < 7; ++i) {
            var this_value = last_value + last_value * increase_by / 100;
            costs.push([i+1, this_value]);
            last_value = this_value;
        }

        return costs;
    };

    var revenue_array = function() {
        var starting_value = 500000 + Math.floor(Math.random()*200000);
        var increase_by = 10+Math.floor(Math.random()*20);
        var last_value = starting_value;
        var costs = [];

        for(var i = 0; i < 7; ++i) {
            var this_value = last_value + last_value * increase_by / 100;
            costs.push([i+1, this_value]);
            last_value = this_value;
        }

        return costs;
    };

    for(var i = 0; i < window.total_graphs; ++i) {
        $('#chart_'+(i+1)).highcharts({
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
                data: cost_array(), // PUT press_job.dashboard_graph_costs here
                color: '#BF5E7B'
            }, {
                name: 'Revenue',
                data: revenue_array(), // PUT press_job.dashboard_graph_revenue here
                color: '#2F7ED8'
            }]
        });
    }
});
