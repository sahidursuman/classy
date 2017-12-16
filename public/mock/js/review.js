$(document).ready(function() {

  //chart
  var config = {
    type: 'doughnut',
    data: {
      datasets: [{
        data: [
          90, 50, 30, 10
        ],
        backgroundColor: [
          '#4CAF50', '#64A6F4', '#FFDA6B', '#FF7A63'
        ],
        label: 'Dataset 1'
      }],
      labels: [
        "Tuyệt vời",
        "Tốt",
        "Trung bình",
        "Kém"
      ]
    },
    options: {
      legend: false,
      responsive: true
    }
  };
  var ctx = $("#chart")[0].getContext("2d");
  var myPieChart = new Chart(ctx, config);
  //end of chart

  $(".criterial_slider").slider({});
});
