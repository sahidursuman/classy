function draw_review_chart(){
  var data = new Array();
  var backgroundColors = new Array();
  var labels = new Array();
  $(".review_level").each(function(){
    var counterElement = $(this).find(".counter_on_level").first();
    data.push(parseInt(counterElement.text()));
    backgroundColors.push(counterElement.css("color"));
    labels.push($(this).find(".level_label").first().text());
  });
  var config = {
    type: "doughnut",
    data: {
      datasets: [{
        data: data,
        backgroundColor: backgroundColors
      }],
      labels: labels
    },
    options: {
      legend: false,
      responsive: true
    }
  };
  var ctx = $("#review-chart")[0].getContext("2d");
  var myPieChart = new Chart(ctx, config);
}
