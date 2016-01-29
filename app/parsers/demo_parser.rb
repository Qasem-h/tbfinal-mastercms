require 'nokogiri'
class DemoParser
  
  def parse
      f = File.open("public/odds/england.xml")
      xml = Nokogiri::XML(f)
      path = "//league/match/odds/type[@name='1x2']/bookmaker[1]"
      xml.xpath(path).map do |x|
            {  country: x.parent.parent.parent.parent['country'],
             league: x.parent.parent.parent.parent['name'],
             matchid: x.parent.parent.parent['static_id'],
             alternate_id: x.parent.parent.parent['alternate_id_2'],
             datetime: x.parent.parent.parent['date'].to_date,
             hometeam: x.parent.parent.parent.children[0]['name'],
             awayteam: x.parent.parent.parent.children[1]['name'],
             oddnameh: x.children[0].attributes['name'].value,
             oddnamea: x.children[1].attributes['name'].value,
             oddwina: x.children[1].attributes['value'].value,
             oddwinh: x.children[0].attributes['value'].value,
             oddnamed: x.children[2].attributes['name'].value,
             oddwind: x.children[2].attributes['value'].value,
             time: [x.parent.parent.parent['date'], x.parent.parent.parent['time']].join(" ")}
           end
    end
    
end
