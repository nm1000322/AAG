Sequel.migration do
  up do
    create_table(:images) do
      primary_key :id

      String :name
      String :url
      String :tag
      String :caption
      Time :date
      Integer :favtoggle
      Integer :uptoggle
      String :type


    end
  end

  down do
    drop_table(:images)
  end
end