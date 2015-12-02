Sequel.migration do
  up do
    create_table(:posts) do
      primary_key :id

      String :name
      String :tag
      String :content
      String :imgurl
      Time :date

      foreign_key :user_id
    end
  end

  down do
    drop_table(:posts)
  end
end