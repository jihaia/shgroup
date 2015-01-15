require 'uuidtools'

class Crb::Util::Uuid

  def self.generate(size=1)
    result = []
    (1..size).each do
      result << UUIDTools::UUID.timestamp_create.to_s.gsub('-','').upcase
    end
    return (size == 1 ? result.first : result)
  end
end
