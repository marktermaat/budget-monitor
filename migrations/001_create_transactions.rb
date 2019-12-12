Sequel.migration do
  up do
    create_table(:transactions) do
      String :id, primary_key: true
      DateTime :timestamp, null: false
      String :description
      String :sign, size: 5
      Float :amount
    end
  end

  down do
    drop_table(:transactions)
  end
end