class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people, id: false do |t|
      t.column :emailAddress,      :string,      null: false,      limit: 100
      t.column :firstName,         :string,      null: true,       limit: 40
      t.column :lastName,          :string,      null: true,       limit: 40
      t.column :languageCode,      :string,      null: true,       limit: 10
      t.column :bornOn,            :date,        null: true
      t.column :birthMonth,        :integer,     null: true
      t.column :birthDay,          :integer,     null: true
      t.column :anniversaryMonth,  :integer,     null: true
      t.column :anniversaryDay,    :integer,     null: true
      t.column :currency,          :string,      null: true,       limit: 10
      t.column :revisionNumber,    :integer,     null: false,      default: 1
      t.column :isDestroyed,       :boolean,     null: false,      default: false
    end
  end
end
