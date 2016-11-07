Hanami::Model.migration do
  change do
    alter_table :entries do
      add_column :email, String
    end
  end
end
