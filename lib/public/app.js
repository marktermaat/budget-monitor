var graphPeriod = 'all';
var graphGranularity = 'month';
var chart;

function initChart() {
    let ctx = document.getElementById('budget-chart').getContext('2d');
    let request = new XMLHttpRequest();
    request.open('GET', `/ui/api/chart?period=${graphPeriod}&granularity=${graphGranularity}`, true);

    request.onload = function() {
        if (this.status >= 200 && this.status < 400) {
            var data = JSON.parse(this.response);
            if(chart !== undefined) {
                console.debug("Destroying");
                chart.destroy();
            }
            chart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    title: {
                        display: true,
                        text: 'Chart.js Bar Chart - Stacked'
                    },
                    tooltips: {
                        mode: 'index',
                        intersect: false,
                        enabled: false
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
                        var activePoint = chart.getElementAtEvent(e)[0];
                        var data = activePoint._chart.data;
                        var datasetIndex = activePoint._datasetIndex;
                        var label = data.datasets[datasetIndex].label;
                        var value = data.datasets[datasetIndex].data[activePoint._index];
                        printDetails(data.labels[activePoint._index], label, value);
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
        chart.data.datasets.forEach(function(ds) {
            ds.hidden = true;
        });
        chart.update();
    };
}

function printDetails(periodLabel, tag, amount) {
    let table = document.getElementById("details");
    let detailsSummary = document.getElementById("details_summary");

    let request = new XMLHttpRequest();
    request.open('GET', `/ui/api/chart/details?period=${graphPeriod}&granularity=${graphGranularity}&label=${periodLabel}&tag=${tag}`, true);

    request.onload = function() {
        if (this.status >= 200 && this.status < 400) {
            table.innerText = '';
            var data = JSON.parse(this.response);
            detailsSummary.innerHTML = `Period: ${data.label}<br>Tag: ${data.tag}<br>Sum: ${data.total}`;
            data.transactions.forEach(function(t) {
                const row = document.createElement('tr');
                row.innerHTML = `<td>${t['timestamp']}</td><td>${t['description']}</td><td>${t['amount']}</td>`;
                table.appendChild(row);
            });
        }
    }

    request.send();
}

function setPeriod(period) {
    for (let e of document.getElementsByClassName("js-period")) {
        e.classList.remove("active");
    }
    document.getElementById(`period_${period}`).classList.add("active");
    console.log(`Period: ${period}`);
    graphPeriod = period;
    initChart();
}

function setGranularity(granularity) {
    for (let e of document.getElementsByClassName("js-granularity")) {
        e.classList.remove("active");
    }
    document.getElementById(`granularity_${granularity}`).classList.add("active");
    console.log(`Granularity: ${granularity}`);
    graphGranularity = granularity;
    initChart();
}

function initNewRulePage() {
    let table = document.getElementById('test-results');
    let patternForm = document.getElementById("pattern");
    let tagForm = document.getElementById("tag");
    let resultSummary = document.getElementById("result-summary");

    document.getElementById('test-pattern').onclick = function() {
        let request = new XMLHttpRequest();
        request.open('GET', `/rule/test?pattern=${patternForm.value}`, true);

        request.onload = function() {
            if (this.status >= 200 && this.status < 400) {
                table.innerText = '';
                var data = JSON.parse(this.response);
                resultSummary.innerHTML = `Number of tagged results: ${data['no_tagged_results']}<br>Number of untagged results: ${data['results'].length}`;
                data['results'].forEach(function(t) {
                    const row = document.createElement('tr');
                    row.innerHTML = `<td>${t['timestamp']}</td><td>${t['description']}</td><td>${t['amount']}</td>`;
                    table.appendChild(row);
                });
            }
        }

        request.send();
    };

    document.getElementById('submit-pattern').onclick = function() {
        let request = new XMLHttpRequest();
        request.open('POST', '/rule', true);
        request.setRequestHeader('Content-type', 'application/json')

        request.onload = function() {
            if (this.status >= 200 && this.status < 400) {
                window.location.href = "/rules/new";
            }
        }

        request.send(JSON.stringify({pattern: patternForm.value, tag_name: tagForm.value}));
    };
}

function analyseTransactions() {
    let request = new XMLHttpRequest();
    request.open('POST', '/ui/api/analyse_transactions', true);
    request.send();
}