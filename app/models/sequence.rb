class Sequence < ActiveRecord::Base

  # METADATA (Start) ====================================================================
  self.table_name  = :sequences
  self.primary_key = :sequence_code
  # METADATA (End)

  # HELPERS (Start) =====================================================================
  def self.nextval(code)
    result = '-1'
    begin
      seq = Sequence.find(code)
      seq.value += 1
      seq.save
      prefix = seq.prefix || ''
      main = seq.value.to_s.rjust(seq.padding, '0')
      result = prefix << main
    rescue
    end
    result
  end # def self.nextval
  # HELPERS (End)

end # class Sequence
