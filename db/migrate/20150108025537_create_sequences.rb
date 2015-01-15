class CreateSequences < ActiveRecord::Migration
  def change
    create_table(:sequences, :id => false) do |t|
      t.column    :sequence_code, :string,    :null => false,     :limit => 100
      t.column    :prefix,        :string,    :null => true,      :limit => 10
      t.column    :padding,       :integer,   :null => false,     :default => 8
      t.column    :value,         :integer,   :null => false,     :default => 1
    end

    add_index(:sequences, [:sequence_code], :unique => true)
  end
end
