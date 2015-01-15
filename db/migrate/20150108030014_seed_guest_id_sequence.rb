class SeedGuestIdSequence < ActiveRecord::Migration
  def change
    Sequence.create(
      [
        {sequence_code: 'GUEST_ID',   padding: 8, value: 1000}
      ]
    )
  end
end
