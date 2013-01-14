graph = ->
    # define the options
    options = {
        chart : { renderTo : 'graph-container' },
        credits: { href: '', text: ''},
        rangeSelector : { selected : 2 },
        title : { text : 'Influence of press releases on development of <%= @company.code %> shares' },

        series : [{
            name : $("#graph-container").data('company-code'),
            data : [],
            id : 'dataseries',
            tooltip: { yDecimals: 2 }
        },{
            type : 'flags',
            data : [],
            shape : 'circlepin',
            onSeries : 'dataseries',
            width : 16
        }]
    }

    # load chart data
    if $("#graph-container").length > 0
        $.getJSON $("#graph-container").data('company-stocks-url'), (data) ->
            options.series[0].data = data
            chart = new Highcharts.StockChart(options)

            $.getJSON $("#graph-container").data('company-messages-url'), (data) ->
                chart.series[1].setData(data)
                chart.redraw()


$(document).ready(graph)
$(window).bind('page:change', graph)