# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
   config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
   config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
   config.user_model_name = 'Tipster'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
   config.current_user_method = 'current_tipster'
end

# Create application badges (uses https://github.com/norman/ambry)


 badge_id = 0
 [{
   id: (badge_id = badge_id+1),
   name: 'just-registered'
 }, {
   id: (badge_id = badge_id+1),
   name: 'just-registereed'
 }, {
   id: (badge_id = badge_id+1),
   name: 'just-registered1'
 },{
   id: (badge_id = badge_id+1),
   name: 'just-registered2'
 },{
   id: (badge_id = badge_id+1),
   name: 'HATTRICK HERO',
   custom_fields: { image: "WS03.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'PENTAKILL',
   custom_fields: { image: "WS05.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'LUCKY 7',
   custom_fields: { image: "WS07.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'Perfect 10',
   custom_fields: { image: "WS10.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'AGAINST ALL ODDS',
   custom_fields: { image: "WS15.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'ONCE IN A LIFETIME',
   custom_fields: { image: "WS20.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'EAGLE EYE',
   custom_fields: { image: "WR01.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'TACTICIAN',
   custom_fields: { image: "WR02.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'MASTER STRATEGIST',
   custom_fields: { image: "WR03.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'OCTOPUSMAN',
   custom_fields: { image: "WR04.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'SUNTZU',
   custom_fields: { image: "WR05.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'INSIDER',
   custom_fields: { image: "WR06.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'A QUICK REBOUND',
   custom_fields: { image: "R20.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'NO LOSS, NO GAINS',
   custom_fields: { image: "R30.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'RESURGENCE',
   custom_fields: { image: "R40.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'WHAT A COMEBACK',
   custom_fields: { image: "R50.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'COMEBACK KING',
   custom_fields: { image: "R60.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'NEAR DEATH EXP',
   custom_fields: { image: "R70.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'A PASSION IN BETTING',
   custom_fields: { image: "v25.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'LOVES BETTING',
   custom_fields: { image: "v50.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'BETS-A-LOT',
   custom_fields: { image: "v100.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'CULTURED',
   custom_fields: { image: "v250.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'SEASONED',
   custom_fields: { image: "v500.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'VETERAN',
   custom_fields: { image: "v1000.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'THE MACHINE',
   custom_fields: { image: "the-machine.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'PARK THE BUS',
   custom_fields: { image: "not-losing-4.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'DRAW SOME, WON SOME',
   custom_fields: { image: "not-losing-9.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'INVINCIBLES',
   custom_fields: { image: "not-losing-18.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'THE UNBREAKABLE',
   custom_fields: { image: "the-unbreakable.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'HOOKED',
   custom_fields: { image: "Time-Active-10-Days.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'DEVOTED',
   custom_fields: { image: "Time-Active-30-Days.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'ADDICTED',
   custom_fields: { image: "Time-Active-60-Days.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'OBSESSED',
   custom_fields: { image: "Time-Active-180-Days.png" }
 },{
   id: (badge_id = badge_id+1),
   name: 'THE PASSIONATE',
   custom_fields: { image: "the-passionate.png" }
 }
].each do |attrs|
   Merit::Badge.create! attrs
 end