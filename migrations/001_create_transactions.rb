Sequel.migration do
  up do
    create_table(:transactions) do
      primary_key :id
      String :key, null: false, unique: true
      DateTime :timestamp, null: false
      String :description
      String :account
      String :sign, size: 5
      Float :amount
    end
  end

  down do
    drop_table(:transactions)
  end
end