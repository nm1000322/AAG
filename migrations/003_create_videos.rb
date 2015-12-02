Sequel.migration do
  up do
    create_table(:videos) do
      primary_key :id

      String :name
      String :embed
      String :tag
      String :caption
      Integer :favtoggle


    end
  end

  down do
    drop_table(:videos)
  end
end