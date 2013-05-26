namespace :cashbury do

  desc "Build Game for Cashbury"
  task :build_game => :environment do
    begin
      ActiveRecord::Base.transaction do
        puts "Building Game..."
        
        ## Configs
        title = 'Sample Game'
        max_national_prizes = 4
        max_merchant_prizes = 4
        ## End Configs 

        game = Game.create!(
          title: title, 
          max_national_prizes: max_national_prizes,
          max_merchant_prizes: max_merchant_prizes)
        puts "Game created..."
        icons = ['space', 'cherry', 'bar', 'bell', 'star', 'seven', 'x']
        game_icons = Hash[icons.map {|symb| [symb.to_sym, Game::Icon.create!(internal_name: symb, public_name: symb.humanize, game_id: game.id) ]} ]

        puts "created all game icons.. [no icons yet] XX"
        puts "Adding paylines now.."

        puts "Adding National Paylines.."
        puts "Adding 7-7-7.."
        game.paylines.create!(
          group: 'national',
          icon1_id: game_icons[:seven].id,
          icon2_id: game_icons[:seven].id,
          icon3_id: game_icons[:seven].id,
          probability: '0.00001'
          )

        puts "Adding cherry-cherry-cherry.."
        game.paylines.create!(
          group: 'national',
          icon1_id: game_icons[:cherry].id,
          icon2_id: game_icons[:cherry].id,
          icon3_id: game_icons[:cherry].id,
          probability: '0.001'
          )

        puts "Adding bell-bell-bell.."
        game.paylines.create!(
          group: 'national',
          icon1_id: game_icons[:bell].id,
          icon2_id: game_icons[:bell].id,
          icon3_id: game_icons[:bell].id,
          probability: '0.01'
          )

        puts "Adding star-star-star.."
        game.paylines.create!(
          group: 'business',
          icon1_id: game_icons[:star].id,
          icon2_id: game_icons[:star].id,
          icon3_id: game_icons[:star].id,
          probability: '0.1'
          )

        puts "Adding x-x-x.."
        game.paylines.create!(
          group: 'business',
          icon1_id: game_icons[:x].id,
          icon2_id: game_icons[:x].id,
          icon3_id: game_icons[:x].id,
          probability: '0.1'
          )

        puts "Game Built!"
      end
    rescue => e
      puts "Failed building game..."
      puts "Error: #{e.message}"
    end
  end

  desc "Build Virtual Reel"
  task :build_virtual_reel => :environment do
    begin
      game = Game.find_by_id(16)
      game.build_winning_reel
      game.build_loosing_reel
    rescue => e
      puts "Failed to build virtual reel"
      puts "ERROR: #{e.message}"
    end
  
  end

end