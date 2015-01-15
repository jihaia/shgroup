class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents, id: false do |t|
      t.column :referenceCode,     :string,      null: false,      limit: 10
      t.column :guestId,           :string,      null: false,      limit: 20
      t.column :propertyNumber,    :string,      null: true,       limit: 20
      t.column :incidentType,      :string,      null: false,      limit: 40
      t.column :problemArea,       :string,      null: true,       limit: 40
      t.column :description,       :text,        null: true
      t.column :status,            :string,      null: false,      limit: 40
      t.column :startedOn,         :date,        null: true
      t.column :reportedOn,        :date,        null: false
      t.column :resolvedOn,        :date,        null: true
      t.column :assignedTo,        :string,      null: true,       limit: 100
    end
  end
end
