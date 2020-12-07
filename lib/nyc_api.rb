require 'net/http'
require 'open-uri'
require 'json'
 
class GetPrograms

  URL = "http://data.cityofnewyork.us/resource/uvks-tn5n.json"

  def get_programs
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def program_school
    programs = JSON.parse(self.get_programs)
    programs.collect {|program| program["agency"]}
  end

  def programs_by_age_group
    programs = JSON.parse(self.get_programs)
    programs.collect do |program|
      "#{program["agency"]} - #{program["borough_community"]} - #{program["grade_level_age_group"]}"
    end
  end
end

# programs = GetPrograms.new.get_programs
# puts programs

# programs = GetPrograms.new
# puts programs.program_school.uniq

programs = GetPrograms.new
puts programs.programs_by_age_group
