Hanami::Model.migration do
  change do
    create_table :entries do
      primary_key :id
      column :name, String, null: false
      column :mascots, 'varchar[]', null: false
    end
  end
end
