class CreateKeymap < ActiveRecord::Migration
  def change
    create_table :keymaps, :id => false do |t|
      t.column :keymapId,          :string,      null: false,      limit: 32
      t.column :endpointId,        :string,      null: false,      limit: 40
      t.column :interfaceType,     :string,      null: false,      limit: 20
      t.column :direction,         :string,      null: true,       limit: 10
      t.column :brand,             :string,      null: true,       limit: 20
      t.column :url,               :string,      null: true,       limit: 400
      t.column :username,          :string,      null: true,       limit: 50
      t.column :password,          :string,      null: true,       limit: 50
      t.column :mode,              :string,      null: false,      limit: 20
      t.column :revisionNumber,    :integer,     null: false,      default: 1
      t.column :isDestroyed,       :boolean,     null: false,      default: false
    end
  end
end
