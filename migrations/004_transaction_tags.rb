Sequel.migration do
  up do
    create_table(:transaction_tags) do
      primary_key :id
      foreign_key :transaction_id, :transactions
      foreign_key :tag_id, :tags
    end
  end

  down do
    drop_table(:transaction_tags)
  end
end