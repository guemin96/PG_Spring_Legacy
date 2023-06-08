<%@ page contentType="text/html;charset=UTF-8" language="java" %>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

var data = google.visualization.arrayToDataTable([
${data}
]);

var options = {
title: 'My Daily Activities'
};

var chart = new google.visualization.PieChart(document.getElementById('piechart'));

chart.draw(data, options);
}
