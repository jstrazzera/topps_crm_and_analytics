



<script type="text/javascript">

    var chart;
    var chartData = [];
    var chartCursor;

    fetchChartData()
	// SERIAL CHART    

    chart = new AmCharts.AmSerialChart();
	chart.pathToImages = "/assets/amcharts/";

    chart.dataProvider = chartData;
    chart.categoryField = "date";





































    function fetchChartData(data_type) {
    	var get_result = [];
    	$.get("/analytics/data/" + data_type, function(data) {
    		if(data["success"] == true) {
    			get_result = data["data"];
    		}
    	}

    	





    }











</script>