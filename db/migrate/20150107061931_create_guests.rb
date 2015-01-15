class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests, :id => false do |t|
      t.column :guestId,           :string,      null: false,      limit: 32
      t.column :brand,             :string,      null: false,      limit: 20
      t.column :emailAddress,      :string,      null: false,      limit: 100
      t.column :lastStayOn,        :date,        null: true
      t.column :lastStayProperty,  :string,      null: true,       limit: 20
      t.column :lastCommunicationOn,:date,       null: true
      t.column :lifetimeValue,     :integer,     null: false,      default: 0
      t.column :revisionNumber,    :integer,     null: false,      default: 1
      t.column :isDestroyed,       :boolean,     null: false,      default: false
    end
  end
end
