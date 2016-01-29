require 'open-uri'
require 'nokogiri'
 
class ScoreParser
  attr_reader :xml
 
  def self.execute(url)
    instance = new(url)
    instance.parse
  end
 
  def initialize(url)
    @xml = Nokogiri::HTML open("http://www.tipgin.net/datav2/accounts/monsoonm/soccer/livescore/#{url}.xml")
  end
 
  def parse
    xml.search("league").each do |league_xml|
      country = Country.find_by(:name => league_xml.attr('country'))
 
      next if country.nil?
 
      league = League.find_by(:name => league_xml.attr('name'), :country_id => country.id)
 
      next if league.nil?
 
      parse_matches(league_xml, league.id)
    end
  end
 
  def parse_matches(xml, league_id)
    xml.search("match").each do |match_xml|
      events_size = match_xml.search('event').size
 
      next unless ["FT", "AET", "Postp.", "Pen."].include? match_xml.attr('status')
 
      match = Match.find_by(
        :static_id => match_xml.attr('static_id'),
        :alternate_id => match_xml.attr('alternate_id'),
        :home_team => match_xml.search("home")[0].attr('name'),
        :away_team => match_xml.search("away")[0].attr('name'),
 
        :league_id => league_id
      )
 
      next if match.nil?
 
      ScoreParser::Score.execute(match.id, match_xml)
    end
  end
end
 
class ScoreParser::Score
  attr_reader :match_id
 
  def self.execute(match_id, xml)
    instance = new(match_id)
    instance.parse(xml)
  end
 
  def initialize(match_id)
     @match_id = match_id
  end
 
  def parse(xml)
    score = Score.where(:match_id => match_id).first_or_create
    score.status = xml.attr('status')
 
    case score.status
    when 'FT'
      set_base_params(score, xml)
      set_ft_score(score, xml)
    when 'AET'
      set_base_params(score, xml)
 
      set_score_for(score, xml, 'et')
    when 'Pen.'
      set_base_params(score, xml)
 
      set_score_for(score, xml, 'et')
      set_penalty_score(score, xml)
    when 'Postp.'
    end
 
    score.save
  end
 
  def set_base_params(score, xml)
    set_score_for(score, xml, 'ft')
    set_score_for(score, xml, 'ht')
 
    events_xml = xml.search('event[@type="goal"]')
 
    return if events_xml.size == 0
 
    score.first_goal = xml.search(events_xml.first.attr('team')).first.attr('name')
    score.last_goal = xml.search(events_xml.last.attr('team')).first.attr('name')
  end
 
  def set_score_for(score, xml, tag)
    tag_xml = xml.search(tag)
    return unless tag_xml.size > 0
 
    tag_score = tag_xml.first.attr('score')
    tag_score = tag_score[1..tag_score.length - 2].split('-')
 
    return unless tag_score.size > 0
 
    score.send("#{tag}_home_goal=", tag_score[0].to_i)
    score.send("#{tag}_away_goal=", tag_score[1].to_i)
  end
 
  def set_ft_score(score, xml)
    score.ft_home_goal = xml.search('home').first.attr('goals').to_i
    score.ft_away_goal = xml.search('away').first.attr('goals').to_i
  end
 
  def set_penalty_score(score, xml)
    penalty_xml = xml.search('penalty').first
 
    ph = penalty_xml.attr('localteam')
    pv = penalty_xml.attr('visitorteam')
 
    return if ph.empty? || pv.empty?
 
    score.penalty_home = ph.to_i
    score.penalty_away = pv.to_i
  end
end