class SeedIncidentRefCodeSequence < ActiveRecord::Migration
  def change
    Sequence.create(
      [
        {sequence_code: 'INCIDENT_REF_CODE',   padding: 8, value: 500}
      ]
    )
  end
end
