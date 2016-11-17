require 'byebug'
# Write your code here!
def game_hash
  {
    :home => {
      :team_name => "Brooklyn Nets",
      :colors => ["Black","White"],
      :players => {
        "Alan Anderson" => {
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        "Reggie Evans" => {
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        "Brook Lopez" => {
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15
        },
        "Mason Plumlee" => {
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 12,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        "Jason Terry" => {
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        }
      }
    },


    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => {
        "Jeff Adrien" => {
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        "Bismak Biyombo" => {
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 7,
          :blocks => 15,
          :slam_dunks => 10
        },
        "DeSagna Diop" => {
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        "Ben Gordon" => {
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        "Brendan Haywood" => {
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 22,
          :blocks => 5,
          :slam_dunks => 12
        }
      }
    }
  }
end

def num_points_scored(player_name)
  points = ""
  game_hash.each do |location,team_data|
    #debugger
    team_data.each do |attribute, data|
      if attribute == :players && game_hash[location][attribute].include?(player_name)
          #debugger
          points << game_hash[location][attribute][player_name][:points].to_s
      end
    end
  end
  points.to_i
end

# puts num_points_scored("Brendan Haywood")

def shoe_size(player_name)
  shoe = 0
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players && game_hash[location][attribute].include?(player_name)
        shoe = game_hash[location][attribute][player_name][:shoe]
      end
    end
  end
  shoe
end

def team_colors(team_name)
  colors = []
  game_hash.each do |location, team_data|
    # debugger
    team_data.each do |attribute, data|
      #debugger if attribute == :team_name
      if attribute == :team_name && game_hash[location][attribute] == team_name
        colors << game_hash[location][:colors]
      end
    end
  end
  colors.flatten
end

# p team_colors("Charlotte Hornets")

def team_names
  teams = []
  game_hash.each do |location,team_data|
    #debugger
    team_data.each do |attribute, data|
      if attribute == :team_name
        teams << game_hash[location][attribute]
      end
    end
  end
  teams
end

#p team_names

def player_numbers(team)
  jerseys = []
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      #debugger
      if attribute == :team_name && game_hash[location][attribute] == team
        #debugger
        game_hash[location][:players].each do |name,stat|
          #debugger
          stat.each do |stats, value|
            jerseys << value if stats == :number
          end
        end
      end
    end
  end
  jerseys
end

#p player_numbers("Brooklyn Nets")

def player_stats(player_name)
  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      #debugger
      if attribute == :players
        data.each do |person,stats|
          #debugger
          if person == player_name
            return game_hash[location][attribute][person]
          end
        end
      end
    end
  end
end

#p player_stats("Brendan Haywood")

def big_shoe_rebounds
  largest_shoe_size = 0       #declare variables to store the values
  home_or_away = ""
  player_name = ""

  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        data.each do |person,stats|
          #debugger
          stats.each do |stat, value|
            if stat == :shoe && value > largest_shoe_size
              largest_shoe_size = value
              player_name = person
              home_or_away = location.to_s
            end
          end
        end
      end
    end
  end
  game_hash[home_or_away.to_sym][:players][player_name][:rebounds]
end

#p big_shoe_rebounds

def most_points_scored
  most_points = 0
  player_name = ""

  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        data.each do |name, stats|
          stats.each do |key, value|
            if key == :points && value > most_points
              most_points = value
              player_name = name.to_s
            end
          end
        end
      end
    end
  end
  player_name.to_s
end

def winning_team
  scorekeeper = Hash.new(0)
  team = ""

  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      team = data if attribute == :team_name   #this sets the team variable to the current team_name
      if attribute == :players      #if its players then it will iterate through every player and add their points
        # debugger
        data.each do |name, stats|
          #debugger
          stats.each do |key,value|
            if key == :points
              scorekeeper[team] += value
            end
          end
        end
      end
    end
  end
  scorekeeper.sort_by {|key,value| value}.reverse.flatten[0]
end

# p winning_team

def player_with_longest_name
  long_name = ""
  longest = 0

  game_hash.each do |location, team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        #debugger
        data.each do |name, stats|
          if name.length > long_name.length
            longest = name.length
            long_name = name
          end
        end
      end
    end
  end
  long_name
end

#puts player_with_longest_name

def long_name_steals_a_ton?
  longest_name = player_with_longest_name           #calling the method and storing return value as longest_name
  steals_hash = Hash.new(0)

  game_hash.each do |location,team_data|
    team_data.each do |attribute, data|
      if attribute == :players
        data.each do |name, stats|
          stats.each do |stat,value|
            if stat == :steals
              steals_hash[name] = value
            end
          end
        end
      end
    end
  end
  highest = steals_hash.sort_by {|key,value| value}.reverse.flatten[0]

  highest == longest_name ? true : false
end
