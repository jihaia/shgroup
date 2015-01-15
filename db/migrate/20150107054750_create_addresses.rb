class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses, :id => false do |t|
      t.column :addressId,         :string,      null: false,      limit: 32
      t.column :emailAddress,      :string,      null: false,      limit: 100
      t.column :addressType,       :string,      null: true,       limit: 40
      t.column :city,              :string,      null: true,       limit: 50
      t.column :countryCode,       :string,      null: true,       limit: 2
      t.column :line1,             :string,      null: true,       limit: 50
      t.column :line2,             :string,      null: true,       limit: 50
      t.column :line3,             :string,      null: true,       limit: 50
      t.column :line4,             :string,      null: true,       limit: 50
      t.column :postalCode,        :string,      null: true,       limit: 20
      t.column :stateProvince,     :string,      null: true,       limit: 50
      t.column :isPrimary,         :boolean,     null: false,      default: false
      t.column :revisionNumber,    :integer,     null: false,      default: 1
      t.column :isDestroyed,       :boolean,     null: false,      default: false
    end
  end
end
