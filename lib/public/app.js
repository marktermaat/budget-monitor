function initChart() {
    let ctx = document.getElementById('budget-chart').getContext('2d');
    let request = new XMLHttpRequest();
    var myChart;
    request.open('GET', '/ui/api/chart', true);

    request.onload = function() {
        if (this.status >= 200 && this.status < 400) {
            var data = JSON.parse(this.response);
            myChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    title: {
                        display: true,
                        text: 'Chart.js Bar Chart - Stacked'
                    },
                    tooltips: {
                        mode: 'index',
                        intersect: false
                    },
                    responsive: false,
                    scales: {
                        xAxes: [{
                            stacked: true,
                        }],
                        yAxes: [{
                            stacked: true,
                        }]
                    },
                    onClick: function(e, items) {
                        if ( items.length == 0 ) return;
                        var activePoint = myChart.getElementAtEvent(e)[0];
                        var data = activePoint._chart.data;
                        var datasetIndex = activePoint._datasetIndex;
                        var label = data.datasets[datasetIndex].label;
                        var value = data.datasets[datasetIndex].data[activePoint._index];
                        console.log(label);
                        console.log(value);
                    }
                }
            });
        } else {
            // We reached our target server, but it returned an error
        }
    };

    request.onerror = function() {
        // There was a connection error of some sort
    };

    request.send();

    document.getElementById('hide-all-labels').onclick = function() {
        myChart.data.datasets.forEach(function(ds) {
            ds.hidden = true;
        });
        myChart.update();
    };
}

function initUntaggedTransactions() {
    let table = document.getElementById('untagged-transactions');
    let request = new XMLHttpRequest();
    request.open('GET', '/ui/api/untagged_transactions', true);

    request.onload = function() {
        if (this.status >= 200 && this.status < 400) {
            var data = JSON.parse(this.response);
            data.forEach(function(t) {
                console.log(JSON.stringify(t));
                const row = document.createElement('tr');
                row.innerHTML = `<td>${t['description']}</td><td>${t['account']}</td><td>${t['amount']}</td>`;
                table.appendChild(row);
            });
        }
    }

    request.send();
}
