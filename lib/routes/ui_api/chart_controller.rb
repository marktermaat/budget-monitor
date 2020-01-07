require 'json'

class BudgetMonitor < Sinatra::Application
  get '/ui/api/chart' do
    transactions_per_month = Transaction.eager(:tags).order(Sequel.desc(:timestamp)).all.group_by {|t| Date.new(t.timestamp.year, t.timestamp.month) }

    labels = transactions_per_month.keys.reverse.map { |d| d.strftime('%Y-%m') }
    datasets = []

    colours = ['#000075', '#4363d8', '#42d4f4', '#469990', '#3cb44b', '#aaffc3', '#bfef45', '#ffe119', '#808000', '#fffac8', '#f58231', '#9A6324', '#ffd8b1', '#e6194B', '#800000', '#fabebe', '#911eb4', '#e6beff', '#f032e6']

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
end
