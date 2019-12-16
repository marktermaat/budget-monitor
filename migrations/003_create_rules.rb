Sequel.migration do
  up do
    create_table(:rules) do
      primary_key :id
      String :pattern, null: false
      foreign_key :tag_id, :tags
    end
  end

  down do
    drop_table(:rules)
  end
end