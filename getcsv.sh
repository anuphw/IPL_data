#!/bin/sh

if ! [ -f ./CSV/events.csv ] ; then
    echo "match_id;innings;over;ball;batsman;non_striker;batting_team;bowler;bowling_team;batsman_runs;extra_runs;total_runs;extra_type;out_type;player_out;fielder_involved" > ./CSV/events.csv
fi
if ! [ -f ./CSV/match_info.csv ] ; then
    echo "competition;match_id;start_date;end_date;match_type;overs;city;venue;neutral_venue;home_team;away_team;umpire1;umpire2;toss_winner;decision;result_method;winner;win_innings;win_runs;win_wickets;man_of_match" > ./CSV/match_info.csv
fi
for i in YAML/*yaml; do
    match_id=$(echo $i | sed 's%.*/%%g;s%.yaml%%g')
    if ! $(egrep -q "^${match_id};" ./CSV/events.csv); then 
	ruby convert2csv.rb $i
    fi
done
