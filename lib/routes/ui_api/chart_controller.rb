require 'json'

class BudgetMonitor < Sinatra::Application
  get '/ui/api/chart' do
    granularity = params['granularity'].to_sym || :month
    period = params['period'].to_sym || :all
    start_time, end_time = get_period_times(period)
    transactions_per_month = Transaction.where{(timestamp >= start_time) & (timestamp < end_time)}.eager_graph(:tags).order(Sequel.desc(:timestamp)).all.group_by {|t| bucket_data(t.timestamp, granularity) }

    labels = transactions_per_month.keys.reverse
    datasets = []

    colours = ['#000075', '#f58231', '#4363d8', '#fffac8', '#42d4f4', '#9A6324', '#469990', '#f032e6', '#3cb44b', '#aaffc3', '#bfef45', '#ffe119', '#808000', '#ffd8b1', '#e6194B', '#800000', '#fabebe', '#911eb4', '#e6beff']

    datasets <<
      {
          label: 'Plus',
          type: 'line',
          fill: false,
          pointBackgroundColor: 'black',
          data: transactions_per_month.map { |_, transactions| transactions.select {|t| t.sign == 'plus'}.sum{|t| t.amount}.round(2) }.reverse
      }

    Tag.all.each_with_index do |tag, index|
      datasets <<
      {
          label: tag.name,
          backgroundColor: colours[index],
          yAxisId: 'minus',
          data: transactions_per_month.map { |_, transactions| transactions.select {|t| t.sign == 'minus' && t.tags.first&.id == tag[:id]}.sum{|t| t.amount}.round(2) }.reverse
      }
    end

    datasets <<
    {
        label: 'Untagged',
        backgroundColor: "\#a9a9a9",
        data: transactions_per_month.map { |_, transactions| transactions.select {|t| t.sign == 'minus' && t.tags.empty?}.sum{|t| t.amount}.round(2) }.reverse
    }

    # {labels:['January','February','March','April','May','June','July'],datasets:[{label:'Dataset1',backgroundColor:'red',data:[1,1,1,1,1,1,1]},{label:'Dataset2',backgroundColor:'blue',data:[1,1,1,1,1,1,1]},{label:'Dataset3',backgroundColor:'green',data:[1,1,1,1,1,1,1]}]}.to_json
    {labels: labels, datasets: datasets}.to_json
  end

  def bucket_data(timestamp, granularity)
    case granularity
    when :year
      Date.new(timestamp.year).strftime('%Y')
    when :three_month
      Date.new(timestamp.year, (timestamp.month/3.0).ceil).strftime('%Y-%m')
    when :month
      Date.new(timestamp.year, timestamp.month).strftime('%Y-%m')
    when :week
      Date.new(timestamp.year, timestamp.month, timestamp.day).strftime('%Y-%V')
    end
  end

  def get_period_times(period)
    now = Time.now
    case period
    when :all
      [now - 60*60*24*365*25, now]
    when :three_year
      [now - 60*60*24*365*3, now]
    when :year
      [now - 60*60*24*365, now]
    when :month
      [now - 60*60*24*30, now]
    end
  end
end
