function create_generic_chart(api_endpoint, field_list) {
    var chart;
    var chartData = [];
    var chartCursor;

    AmCharts.ready(function () {

        var chart;
        var chartData = [];
        var chartCursor;

        // var api_endpoint = "sits_and_starts";
        chartData = ajaxChartData(api_endpoint);
        console.log(chartData);
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

        // var field_list = ["shout_outs"];

        for(i=0; i < field_list.length; i++) {

	        var graph = new AmCharts.AmGraph();
	       	var field = field_list[i];
	        graph.valueField = field;
	        graph.bullet = "round";
	        graph.bulletBorderThickness = 2;
	        graph.balloonText = field + ": [[value]]";
	        graph.lineThickness = 2;
	        graph.hideBulletsCount = 50; 
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
    });

    	function ajaxChartData(data_type) {
    		var return_value = []
        	$.ajax({url: "/analytics/data/" + data_type, 
                    async: false, 
                    success: function(data){
                        for(i=0; i<data["data"].length; i++) {
							var date = {"date": new Date(data["data"][i]["date"])};
							delete data["data"][i]["date"];
							return_value.push($.extend({}, data["data"][i], date));
							// chartData.push({"date": new Date(data["data"][i]["date"]), "trade_count": data["data"][i]["trade_count"]});
						}
                    }
            })
        	console.log(return_value)
            return return_value;
        }








}