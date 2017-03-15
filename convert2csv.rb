#!/usr/bin/ruby
require 'yaml'
class Object
  def nnil
    if self.nil?
      "none"
    else
      self
    end
  end
end

file = ARGV[0]
match_id = file.split('/')[-1].to_i
data = YAML.load_file(file)
i = 0
innings = 0
# data["info"]["outcome"].keys.each { |x| print "#{x} " }
# puts
# exit


team1, team2 = data["info"]["teams"]

venue = data["info"]["venue"].nnil
city = data["info"]["city"].nnil
competition = data["info"]["competition"].nnil
start_date = data["info"]["dates"].min
end_date = data["info"]["dates"].max
match_type = data["info"]["match_type"].nnil
umpire1,umpire2 = data["info"]["umpires"]
toss_winner = data["info"]["toss"]["winner"].nnil
decision = data["info"]["toss"]["decision"].nnil

mom = data["info"]["player_of_match"] # recode for multiple
if mom.nil?
  mom = ["none"] 
end

if (data["info"]["outcome"].keys.include?("bowl_out"))
  method = "bowl_out"
  winner = data["info"]["outcome"]["bowl_out"]
  win_innings = 0
  win_runs = 0
  win_wickets = 0
elsif (data["info"]["outcome"].keys.include?("eliminator"))
  method = "eliminator"
  winner = data["info"]["outcome"]["eliminator"]
  win_innings = 0
  win_runs = 0
  win_wickets = 0
elsif data["info"]["outcome"].keys.include?("result")
  method = data["info"]["outcome"]["method"].nnil
  winner = data["info"]["outcome"]["winner"].nnil
  win_innings = 0
  win_runs = 0
  win_wickets = 0
else
  method = data["info"]["outcome"]["method"].nnil
  winner = data["info"]["outcome"]["winner"].nnil
  win_innings = data["info"]["outcome"]["by"]["innings"].nnil.to_i
  win_runs = data["info"]["outcome"]["by"]["runs"].nnil.to_i
  win_wickets = data["info"]["outcome"]["by"]["wickets"].nnil.to_i
end
# puts data["info"]["outcome"] 
# puts "#{method},#{winner},#{win_innings},#{win_runs},#{win_wickets}"
# exit


# if (data["info"]["outcome"].keys.include?("bowl_out"))
#   winner = data["info"]["outcome"]["bowl_out"]
#   win_type = "tie"
# elsif (data["info"]["outcome"].keys.include?("winner"))
#   winner = data["info"]["outcome"]["winner"].nnil
#   win_type = data["info"]["outcome"]["by"].keys[0].nnil
#   margin = data["info"]["outcome"]["by"][win_type].nnil
# elsif (data["info"]["outcome"].keys.include?("result"))
#   winner = data["info"]["outcome"]["winner"].nnil
#   win_type = data["info"]["outcome"]["result"].keys[0].nnil
#   margin = data["info"]["outcome"]["by"][win_type].nnil
# elsif (data["info"]["outcome"].keys.include?("eliminator"))
#   winner = data["info"]["outcome"]["eliminator"].nnil
#   win_type = "eliminator"
#   margin = -1
# end
overs = data["info"]["overs"].nnil
neutral_venue = data["info"]["neutral_venue"].nnil
neutral_venue = 0 if data["info"]["neutral_venue"].nil?

# puts "competition,match_id,start_date,end_date,match_type,city,venue,neutral_venue,team1,team2,umpire1,umpire2,toss_winner,decision,winner,win_type,margin,mom"
j = 0
open('./CSV/match_info.csv','a') do |f|
  while(j < mom.size)
    f.puts "#{competition};#{match_id};#{start_date};#{end_date};#{match_type};#{overs};#{city};#{venue};#{neutral_venue};#{team1};#{team2};#{umpire1};#{umpire2};#{toss_winner};#{decision};#{method};#{winner};#{win_innings};#{win_runs};#{win_wickets};#{mom[j].nnil}"
    j = j + 1
  end
end
open("./CSV/events.csv",'a') do |f|
  while(innings < data["innings"].size)
    cur_inn = data["innings"][innings][data["innings"][innings].keys[0]]
    bat_team = cur_inn["team"]
    bow_team = team1 if (team2 == bat_team)
    bow_team = team2 if (team1 == bat_team)
    last_over_no = nil
    i = 0
    while (i < cur_inn["deliveries"].size) do
      key = cur_inn["deliveries"][i].keys[0]
      over_no = key.floor
      if over_no != last_over_no
        last_over_no = over_no
        ball_no = 0
      end
      ball_no = ball_no + 1
      extra_type = "none"
      if not cur_inn["deliveries"][i][key]["extras"].nil?
        extra_type = cur_inn["deliveries"][i][key]["extras"].keys[0] 
      end
      player_out = "none"
      out_type = "none"
      out_fielder = ["none"]
      
      if not cur_inn["deliveries"][i][key]["wicket"].nil?
        player_out = cur_inn["deliveries"][i][key]["wicket"]["player_out"]
        out_type = cur_inn["deliveries"][i][key]["wicket"]["kind"]
        if not cur_inn["deliveries"][i][key]["wicket"]["fielders"].nil? # need to take special care of caught & bowled
          out_fielder = cur_inn["deliveries"][i][key]["wicket"]["fielders"] # recode for multiple
        end
      end
      x = cur_inn["deliveries"][i][key]
      j = 0
      while(j < out_fielder.size)
        f.puts "#{match_id};#{innings};#{over_no};#{ball_no};#{x["batsman"]};#{x["non_striker"]};#{bat_team};#{x["bowler"]};#{bow_team};#{x["runs"]["batsman"]};#{x["runs"]["extras"]};#{x["runs"]["total"]};#{extra_type};#{out_type};#{player_out};#{out_fielder[j]}"
        j = j+1
      end
    i = i+1
    end
    innings = innings + 1
  end
end
# i=0
# bat_team, bow_team = bow_team, bat_team
# while (i < data["innings"][1]["2nd innings"]["deliveries"].size) do
#   key = data["innings"][1]["2nd innings"]["deliveries"][i].keys[0]
#   extra_type = "none"
#   extra_type = data["innings"][1]["2nd innings"]["deliveries"][i][key]["extras"].keys[0] if not data["innings"][1]["2nd innings"]["deliveries"][i][key]["extras"].nil?
#   x = data["innings"][1]["2nd innings"]["deliveries"][i][key]
#   puts "#{match_id},2,#{key},#{x["batsman"]},#{x["non_striker"]},#{bat_team},#{x["bowler"]},#{bow_team},#{x["runs"]["batsman"]},#{x["runs"]["extras"]},#{x["runs"]["total"]},#{extra_type}"
#   i = i+1
# end

