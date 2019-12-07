Sequel.migration do
  up do
    create_table(:transactions) do
      primary_key :id
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