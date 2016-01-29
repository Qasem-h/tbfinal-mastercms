require 'open-uri'
require 'nokogiri'

class Parser
  attr_reader :xml

  def self.execute(url)
    instance = new(url)
    instance.parse
  end

  def initialize(url)
    @xml = Nokogiri::HTML open("http://www.tipgin.net/datav2/accounts/cmonsoon/soccer/odds/#{url}.xml")
  end

  def parse
    xml.search("league").each do |league_xml|
      country = Country.where(:name => league_xml.attr('country')).first_or_create

      league = League.where(:name => league_xml.attr('name'), :country_id => country.id)
        .first_or_create

      parse_matches(league_xml, league.id)
    end
  end

  def parse_matches(xml, league_id)
    xml.search("match").each do |match_xml|
      bet365 = match_xml.search('bookmaker[@name="Bet365"]').size
      pinnacle = match_xml.search('bookmaker[@name="Pinnacle"]').size
      bwin = match_xml.search('bookmaker[@name="BWin"]').size
      total_size = bet365 + pinnacle + bwin

      next if total_size == 0
      
      match_date = match_xml.attr('date')
      match_time = match_xml.attr('time')
      match_datetime = match_date + " " + match_time

      match = Match.where(
        :static_id => match_xml.attr('static_id'),
        :alternate_id => match_xml.attr('alternate_id'),
        :date => DateTime.parse(match_datetime),
        :home_team => match_xml.search("home")[0].attr('name'),
        :away_team => match_xml.search("away")[0].attr('name'),

        :league_id => league_id
      ).first_or_create

      Parser::Odds.execute(match.id, match_xml.search("type"))
    end
  end
end

class Parser::Odds
  attr_reader :match_id, :odds_xml

  def self.execute(match_id, odds_xml)
    instance = new(match_id)
    instance.parse(odds_xml)
  end

  def initialize(match_id)
     @match_id = match_id
  end

  def parse(odds_xml)
    odds_xml.each do |odd_xml|
      xml = bookmaker_xml(odd_xml).first

      next if xml.nil?

      case odd_xml.attr('name')
      when '1x2'                 then o_1x2(xml, 1)
      when 'Home/Away'           then o_home_away(xml, 2)
      when 'Over/Under'          then o_over_under(xml, 3)
      when 'Handicap'            then o_handicap(xml, 4)
      when '1x2 1st Half'        then o_1x2(xml, 5)
      when 'Over/Under 1st Half' then o_over_under(xml, 6)
      when 'Both Teams to Score' then o_both_teams_to_score(xml, 7)
      when 'Over/Under 2nd Half' then o_over_under(xml, 8)
      end
    end
  end

  def odd_type_ids
    @ids ||= [
      OddsType.find_by(:name => '1x2'),
      OddsType.find_by(:name => 'Home/Away'),
      OddsType.find_by(:name => 'Over/Under'),
      OddsType.find_by(:name => 'Handicap'),
      OddsType.find_by(:name => '1x2 1st Half'),
      OddsType.find_by(:name => 'Over/Under 1st Half'),
      OddsType.find_by(:name => 'Both Teams to Score'),
      OddsType.find_by(:name => 'Over/Under 2nd Half')
    ]
  end

  def bookmaker_xml(xml)
    bet365 = xml.search("bookmaker[@name='Bet365']")
    return bet365 if bet365.any?

    pinnacle = xml.search("bookmaker[@name='Pinnacle']")
    return pinnacle if pinnacle.any?

    xml.search("bookmaker[@name='BWin']")
  end

  def o_1x2(xml, odd_type_index)
    odd = Odd.where(:match_id => match_id, :odds_type_id => odd_type_index)
      .first_or_create

    odd.homewin = xml.search("odd[@name='1']")[0].attr('value').to_f
    odd.awaywin = xml.search("odd[@name='2']")[0].attr('value').to_f
    odd.draw = xml.search("odd[@name='X']")[0].attr('value').to_f

    odd.save
  end

  def o_home_away(xml, odd_type_index)
    odd = Odd.where(:match_id => match_id, :odds_type_id => odd_type_index)
      .first_or_create

    odd.homewin = xml.search("odd[@name='1']")[0].attr('value').to_f
    odd.awaywin = xml.search("odd[@name='2']")[0].attr('value').to_f

    odd.save
  end

  def o_over_under(xml, odd_type_index)
    xml.search('total').each do |total_xml|
      odd = Odd.where(
        :total => total_xml.attr('name'),
        :match_id => match_id,
        :odds_type_id => odd_type_index
      ).first_or_create

      odd.under = total_xml.search("odd[@name='Under']")[0].attr('value').to_f
      odd.over = total_xml.search("odd[@name='Over']")[0].attr('value').to_f

      odd.save
    end
  end

  def o_handicap(xml, odd_type_index)
    handicap_odds = []
    handicap_pairs = []

    xml.search('handicap').each do |handicap_xml|
      handicap_xml.search('odd').each do |odd_xml|
        handicap_odds << Parser::HandicapOdd.new(
          :name => odd_xml.attr('name'),
          :value => odd_xml.attr('value'),
          :handicap_name => handicap_xml.attr('name')
        )
      end
    end

    handicap_odds.select{|e| e.name == "1" }.each do |first|
      second = Parser::HandicapOdd.find_opposite_to(first)

      next if first.nil? || second.nil?

      handicap_pairs << [first, second]
    end

    handicap_pairs.each do |handicap_pair|
      home = handicap_pair[0]
      away = handicap_pair[1]

      odd = Odd.where(
        :homevalue => home.handicap_name, :awayvalue => away.handicap_name,
        :match_id => match_id, :odds_type_id => odd_type_index
      ).first_or_create

      odd.homewin = home.value.to_f
      odd.awaywin = away.value.to_f

      odd.save
    end
  end

  def o_both_teams_to_score(xml, odd_type_index)
    odd = Odd.where(:match_id => match_id, :odds_type_id => odd_type_index)
      .first_or_create

    odd.homewin = xml.search("odd[@name='No']")[0].attr('value').to_f
    odd.awaywin = xml.search("odd[@name='Yes']")[0].attr('value').to_f

    odd.save
  end
end
  
class Parser::HandicapOdd
  attr_reader :name, :value, :handicap_name
 
  def initialize(params)
    @name = params[:name]
    @value = params[:value]
    @handicap_name = params[:handicap_name]
 
    @@entries ||= {}
    @@entries["#{handicap_name}_#{name}"] = self
  end
 
  def self.find_opposite_to(instance)
    handicap_name = instance.handicap_name.clone
 
    if handicap_name[0] == '+'
      handicap_name[0] = '-'
    elsif handicap_name[0] == '-'
      handicap_name[0] = '+'
    end
 
    name = {"1" => "2", "2" => "1"}[instance.name]
 
    @@entries["#{handicap_name}_#{name}"]
  end
 
  def self.clear
    @@entries = {}
  end
    
end