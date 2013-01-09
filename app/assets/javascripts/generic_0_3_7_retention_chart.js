    function create_generic_0_3_7_chart(api_endpoint) {

        var chart;
        var chartData = [];
        var chartCursor;


            ajaxChartData(api_endpoint);

            // SERIAL CHART    
            chart = new AmCharts.AmSerialChart();
            chart.pathToImages = "/assets/amcharts/";
            chart.zoomOutButton = {
                backgroundColor: '#000000',
                backgroundAlpha: 0.15
            };
            chart.dataProvider = chartData;
            chart.categoryField = "date";

            // AXES
            // category
            var categoryAxis = chart.categoryAxis;
            categoryAxis.parseDates = true; // as our data is date-based, we set parseDates to true
            categoryAxis.minPeriod = "DD"; // our data is daily, so we set minPeriod to DD
            categoryAxis.dashLength = 1;
            categoryAxis.gridAlpha = 0.15;
            categoryAxis.axisColor = "#DADADA";

            // value                
            var valueAxis = new AmCharts.ValueAxis();
            valueAxis.axisAlpha = 0.2;
            valueAxis.dashLength = 1;
            chart.addValueAxis(valueAxis);

            var datapoint_keys = Object.keys(chartData[1]).filter(function(x){return(x != "date")});

            for(i=0; i<datapoint_keys.length; i++){
                var graph = new AmCharts.AmGraph();
                graph.valueField = datapoint_keys[i];
                graph.bullet = "round";
                graph.bulletBorderThickness = 2;
                graph.balloonText = datapoint_keys[i] + ": [[value]]";
                graph.lineThickness = 2;
                graph.hideBulletsCount = 50; // this makes the chart to hide bullets when there are more than 50 series in selection
                chart.addGraph(graph);

            }



            // CURSOR
            chartCursor = new AmCharts.ChartCursor();
            chartCursor.cursorPosition = "mouse";
            chart.addChartCursor(chartCursor);

            // SCROLLBAR
            var chartScrollbar = new AmCharts.ChartScrollbar();
            chartScrollbar.graph = graph;
            chartScrollbar.scrollbarHeight = 40;
            chartScrollbar.color = "#FFFFFF";
            chartScrollbar.autoGridCount = true;
            chart.addChartScrollbar(chartScrollbar);

            // WRITE
            chart.write(api_endpoint);
        // });

    // generate some random data, quite different range
    function ajaxChartData(data_type) {
        $.ajax({url: "/analytics/data/" + data_type, 
                async: false, 
                success: function(data){
                     for(i=0; i<data["data"].length; i++) {
                        chartData.push({"date": new Date(data["data"][i]["date"]), 
                            "initial": data["data"][i]["initial"],
                            "after_3_days": data["data"][i]["after_3_days"], 
                            "after_7_days": data["data"][i]["after_7_days"]});
                    }
                    console.log(chartData);
                }
        });




    }
}
