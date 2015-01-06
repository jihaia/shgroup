class CreateProperty < ActiveRecord::Migration
  def change
    create_table(:properties, :id => false) do |t|
      t.column :propertyNumber,    :string,      null: false,      limit: 20
      t.column :propertyCode,      :string,      null: false,      limit: 40
      t.column :brand,             :string,      null: false,      limit: 20
      t.column :propertyName,      :string,      null: false,      limit: 50
      t.column :openedOn,          :date,        null: true
      t.column :address,           :string,      null: true,       limit: 60
      t.column :city,              :string,      null: true,       limit: 40
      t.column :stateProvince,     :string,      null: true,       limit: 40
      t.column :countryCode,       :string,      null: true,       limit: 2
      t.column :timezone,          :string,      null: true,       limit: 10
      t.column :emailAddress,      :string,      null: true,       limit: 60
      t.column :telephone,         :string,      null: true,       limit: 20
      t.column :revisionNumber,    :integer,     null: false,      default: 1
      t.column :isDestroyed,       :boolean,     null: false,      default: false
    end
  end
end
