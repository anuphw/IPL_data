Better Economy Rate
===================

Economy Rate (ER) is one of the vary important statistic to evaluate a
bowler. The definition of ER is the average number of runs given away by
the bowler in one over. This [Cricinfo
article](http://www.espncricinfo.com/blogs/content/story/1084584.html)
argues how this traditional definition of ER is not a good measure of
player quality. The gist of the argument is that the traditional
definition ignores the context of the game, i.e. the run rate during a
match. So instead of calculating ER as the average number of runs per
over, we also need to introduce a way to incorporate the context. They
introduce the concept of Economy Rate differential (ERx) in the article,
which is the average of player economy rate and innings run rate. There
are couple of problems with this definition:

1.  This definition doesn't take into account the number of balls the
    player bowled in a game
2.  The value of this statistics are very different than the traditional
    statistic (ER), so it could be hard to comprehend.

To bypass these problems I defined a Weighted Economy Rate (WER), where
weights are based on the number of ball bowled by player and the overall
run rate of the inning.

WER = 6.0 x sum(ER x balls x RR)/sum(balls x RR)
 Lets see if this changes anything.

The events data table has information about all deliveries for 577
matches from past 9 IPLs.

    events = as.data.table(events)
    head(events)

    ##    match_id season innings over ball     batsman non_striker
    ## 1:   335982   2008       0    0    1  SC Ganguly BB McCullum
    ## 2:   335982   2008       0    0    2 BB McCullum  SC Ganguly
    ## 3:   335982   2008       0    0    3 BB McCullum  SC Ganguly
    ## 4:   335982   2008       0    0    4 BB McCullum  SC Ganguly
    ## 5:   335982   2008       0    0    5 BB McCullum  SC Ganguly
    ## 6:   335982   2008       0    0    6 BB McCullum  SC Ganguly
    ##             batting_team  bowler                bowling_team batsman_runs
    ## 1: Kolkata Knight Riders P Kumar Royal Challengers Bangalore            0
    ## 2: Kolkata Knight Riders P Kumar Royal Challengers Bangalore            0
    ## 3: Kolkata Knight Riders P Kumar Royal Challengers Bangalore            0
    ## 4: Kolkata Knight Riders P Kumar Royal Challengers Bangalore            0
    ## 5: Kolkata Knight Riders P Kumar Royal Challengers Bangalore            0
    ## 6: Kolkata Knight Riders P Kumar Royal Challengers Bangalore            0
    ##    extra_runs total_runs extra_type out_type player_out fielder1 fielder2
    ## 1:          1          1    legbyes     none       none     none     none
    ## 2:          0          0       none     none       none     none     none
    ## 3:          1          1      wides     none       none     none     none
    ## 4:          0          0       none     none       none     none     none
    ## 5:          0          0       none     none       none     none     none
    ## 6:          0          0       none     none       none     none     none

We need run rate for all innings in order to get weighted economy rate.

    innings_summary = events[,list(match_balls = length(ball[!(extra_type %in%
                                                                  c('wides'
                                                                    ,'noballs'))])
                                   ,match_runs = sum(total_runs)
                                   ,match_extra_runs = sum(extra_runs)
                                   ,match_wickets = length(out_type[out_type != 'none']))
                             ,by="season,match_id,innings,batting_team,bowling_team"]
    kable(head(innings_summary))

<table>
<thead>
<tr class="header">
<th align="left">season</th>
<th align="right">match_id</th>
<th align="right">innings</th>
<th align="left">batting_team</th>
<th align="left">bowling_team</th>
<th align="right">match_balls</th>
<th align="right">match_runs</th>
<th align="right">match_extra_runs</th>
<th align="right">match_wickets</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">2008</td>
<td align="right">335982</td>
<td align="right">0</td>
<td align="left">Kolkata Knight Riders</td>
<td align="left">Royal Challengers Bangalore</td>
<td align="right">120</td>
<td align="right">222</td>
<td align="right">17</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">2008</td>
<td align="right">335982</td>
<td align="right">1</td>
<td align="left">Royal Challengers Bangalore</td>
<td align="left">Kolkata Knight Riders</td>
<td align="right">91</td>
<td align="right">82</td>
<td align="right">19</td>
<td align="right">10</td>
</tr>
<tr class="odd">
<td align="left">2008</td>
<td align="right">335983</td>
<td align="right">0</td>
<td align="left">Chennai Super Kings</td>
<td align="left">Kings XI Punjab</td>
<td align="right">120</td>
<td align="right">240</td>
<td align="right">6</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">2008</td>
<td align="right">335983</td>
<td align="right">1</td>
<td align="left">Kings XI Punjab</td>
<td align="left">Chennai Super Kings</td>
<td align="right">120</td>
<td align="right">207</td>
<td align="right">11</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">2008</td>
<td align="right">335984</td>
<td align="right">0</td>
<td align="left">Rajasthan Royals</td>
<td align="left">Delhi Daredevils</td>
<td align="right">120</td>
<td align="right">129</td>
<td align="right">7</td>
<td align="right">8</td>
</tr>
<tr class="even">
<td align="left">2008</td>
<td align="right">335984</td>
<td align="right">1</td>
<td align="left">Delhi Daredevils</td>
<td align="left">Rajasthan Royals</td>
<td align="right">91</td>
<td align="right">132</td>
<td align="right">10</td>
<td align="right">1</td>
</tr>
</tbody>
</table>

    bowler_summary = events[,list(runs=sum(total_runs[!(extra_type %in% c("byes","legbyes"))])
                                  ,balls=length(extra_type[!(extra_type %in% c('noballs','wides'))])
                                  ,wickets=length(out_type[out_type%in%c('bowled'
                                                                         ,'caught'
                                                                         ,'caught and bowled'
                                                                         ,'hit wicket'
                                                                         ,'lbw'
                                                                         ,'stumped')]))
                            ,by="season,match_id,innings,batting_team,bowling_team,bowler"]
    bowler_summary = merge(bowler_summary
                           ,innings_summary[,c('season'
                                               ,'match_id'
                                               ,'innings'
                                               ,'match_balls'
                                               ,'match_runs'
                                               ,'match_wickets')]
                           ,by = c('season','match_id','innings'))
    bowler_summary$inning_rr = 6*bowler_summary$match_runs/bowler_summary$match_balls
    bowler_summary$inning_sr = ifelse(bowler_summary$match_wickets > 0
                                      ,bowler_summary$match_balls/ bowler_summary$match_wickets
                                      ,0) # 0 is good for later computation
    bowler_eco_sr = bowler_summary[,list(matches=length(unique(match_id))
                                         ,balls = sum(balls)
                                         ,runs = sum(runs)
                                         ,wickets = sum(wickets)
                                         ,regular_eco=6.0*sum(runs)/sum(balls)
                                          ,weighted_eco=6.0*sum(runs*inning_rr)/ sum(balls*inning_rr)
                                          ,regular_sr=sum(balls)/sum(wickets)
                                          ,weighted_sr=sum(balls*inning_sr)/ sum(wickets*inning_sr))
                                    ,by="season,bowler"]
    bowler_eco_sr = subset(bowler_eco_sr,balls > 60)
    bowler_eco_sr[,reg_rank:=rank(regular_eco,ties.method = "first")
                  ,by = "season"]

    ##      season      bowler matches balls runs wickets regular_eco
    ##   1:   2008     P Kumar      13   268  366      11    8.194030
    ##   2:   2008      Z Khan      11   252  357      13    8.500000
    ##   3:   2008   JH Kallis      11   206  311       4    9.058252
    ##   4:   2008    AB Dinda      12   234  260       9    6.666667
    ##   5:   2008    I Sharma      13   253  329       7    7.802372
    ##  ---                                                          
    ## 630:   2016 KC Cariappa       5   102  159       3    9.352941
    ## 631:   2016   CJ Jordan       9   168  258      11    9.214286
    ## 632:   2016     A Zampa       5   102  115      12    6.764706
    ## 633:   2016  AS Rajpoot       4    66   98       3    8.909091
    ## 634:   2016 BCJ Cutting       4    67   80       5    7.164179
    ##      weighted_eco regular_sr weighted_sr reg_rank
    ##   1:     8.256550   24.36364    44.31471       35
    ##   2:     8.671852   19.38462    32.76474       41
    ##   3:     9.453243   51.50000    66.68122       52
    ##   4:     6.897843   26.00000    38.98282        7
    ##   5:     8.207959   36.14286    44.02272       24
    ##  ---                                             
    ## 630:    10.545259   34.00000    31.81250       61
    ## 631:     9.582474   15.27273    21.08522       59
    ## 632:     7.097701    8.50000     9.29021        1
    ## 633:     9.174710   22.00000    54.09449       53
    ## 634:     7.399600   13.40000    14.35897        5

    bowler_eco_sr[,wt_rank:=rank(weighted_eco,ties.method = "first")
                  ,by = "season"]

    ##      season      bowler matches balls runs wickets regular_eco
    ##   1:   2008     P Kumar      13   268  366      11    8.194030
    ##   2:   2008      Z Khan      11   252  357      13    8.500000
    ##   3:   2008   JH Kallis      11   206  311       4    9.058252
    ##   4:   2008    AB Dinda      12   234  260       9    6.666667
    ##   5:   2008    I Sharma      13   253  329       7    7.802372
    ##  ---                                                          
    ## 630:   2016 KC Cariappa       5   102  159       3    9.352941
    ## 631:   2016   CJ Jordan       9   168  258      11    9.214286
    ## 632:   2016     A Zampa       5   102  115      12    6.764706
    ## 633:   2016  AS Rajpoot       4    66   98       3    8.909091
    ## 634:   2016 BCJ Cutting       4    67   80       5    7.164179
    ##      weighted_eco regular_sr weighted_sr reg_rank wt_rank
    ##   1:     8.256550   24.36364    44.31471       35      33
    ##   2:     8.671852   19.38462    32.76474       41      40
    ##   3:     9.453243   51.50000    66.68122       52      53
    ##   4:     6.897843   26.00000    38.98282        7       6
    ##   5:     8.207959   36.14286    44.02272       24      32
    ##  ---                                                     
    ## 630:    10.545259   34.00000    31.81250       61      69
    ## 631:     9.582474   15.27273    21.08522       59      61
    ## 632:     7.097701    8.50000     9.29021        1       2
    ## 633:     9.174710   22.00000    54.09449       53      51
    ## 634:     7.399600   13.40000    14.35897        5       5

    bowler_eco_sr = bowler_eco_sr[order(season,reg_rank,wt_rank)]

### Season 2008

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">SC Ganguly</td>
<td align="right">120</td>
<td align="right">6.400000</td>
<td align="right">1</td>
<td align="right">6.698161</td>
<td align="right">2</td>
</tr>
<tr class="even">
<td align="left">Sohail Tanvir</td>
<td align="right">247</td>
<td align="right">6.461538</td>
<td align="right">2</td>
<td align="right">6.644941</td>
<td align="right">1</td>
</tr>
<tr class="odd">
<td align="left">SM Pollock</td>
<td align="right">276</td>
<td align="right">6.543478</td>
<td align="right">3</td>
<td align="right">7.122027</td>
<td align="right">7</td>
</tr>
<tr class="even">
<td align="left">IK Pathan</td>
<td align="right">318</td>
<td align="right">6.603774</td>
<td align="right">4</td>
<td align="right">6.871342</td>
<td align="right">5</td>
</tr>
<tr class="odd">
<td align="left">GD McGrath</td>
<td align="right">324</td>
<td align="right">6.611111</td>
<td align="right">5</td>
<td align="right">6.779911</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">DW Steyn</td>
<td align="right">228</td>
<td align="right">6.631579</td>
<td align="right">6</td>
<td align="right">6.792388</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">AB Dinda</td>
<td align="right">234</td>
<td align="right">6.666667</td>
<td align="right">7</td>
<td align="right">6.897843</td>
<td align="right">6</td>
</tr>
<tr class="even">
<td align="left">M Ntini</td>
<td align="right">210</td>
<td align="right">6.914286</td>
<td align="right">8</td>
<td align="right">7.136370</td>
<td align="right">8</td>
</tr>
<tr class="odd">
<td align="left">MF Maharoof</td>
<td align="right">216</td>
<td align="right">6.916667</td>
<td align="right">9</td>
<td align="right">7.138704</td>
<td align="right">9</td>
</tr>
<tr class="even">
<td align="left">A Mishra</td>
<td align="right">119</td>
<td align="right">6.957983</td>
<td align="right">10</td>
<td align="right">7.176810</td>
<td align="right">10</td>
</tr>
</tbody>
</table>

### Season 2009

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">M Muralitharan</td>
<td align="right">300</td>
<td align="right">5.220000</td>
<td align="right">1</td>
<td align="right">5.439476</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">JP Duminy</td>
<td align="right">105</td>
<td align="right">5.314286</td>
<td align="right">2</td>
<td align="right">5.462666</td>
<td align="right">2</td>
</tr>
<tr class="odd">
<td align="left">A Singh</td>
<td align="right">105</td>
<td align="right">5.428571</td>
<td align="right">3</td>
<td align="right">5.595219</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">B Lee</td>
<td align="right">120</td>
<td align="right">5.550000</td>
<td align="right">4</td>
<td align="right">5.662140</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">Harbhajan Singh</td>
<td align="right">264</td>
<td align="right">5.818182</td>
<td align="right">5</td>
<td align="right">5.863481</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">A Kumble</td>
<td align="right">355</td>
<td align="right">5.864789</td>
<td align="right">6</td>
<td align="right">6.077884</td>
<td align="right">8</td>
</tr>
<tr class="odd">
<td align="left">M Kartik</td>
<td align="right">204</td>
<td align="right">5.911765</td>
<td align="right">7</td>
<td align="right">5.953697</td>
<td align="right">6</td>
</tr>
<tr class="even">
<td align="left">SK Raina</td>
<td align="right">166</td>
<td align="right">5.927711</td>
<td align="right">8</td>
<td align="right">6.017274</td>
<td align="right">7</td>
</tr>
<tr class="odd">
<td align="left">TM Dilshan</td>
<td align="right">96</td>
<td align="right">6.125000</td>
<td align="right">9</td>
<td align="right">6.099834</td>
<td align="right">9</td>
</tr>
<tr class="even">
<td align="left">J Botha</td>
<td align="right">72</td>
<td align="right">6.166667</td>
<td align="right">10</td>
<td align="right">6.301226</td>
<td align="right">10</td>
</tr>
</tbody>
</table>

### Season 2010

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">R Ashwin</td>
<td align="right">288</td>
<td align="right">6.104167</td>
<td align="right">1</td>
<td align="right">6.294597</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">WPUJC Vaas</td>
<td align="right">132</td>
<td align="right">6.318182</td>
<td align="right">2</td>
<td align="right">6.460314</td>
<td align="right">2</td>
</tr>
<tr class="odd">
<td align="left">A Kumble</td>
<td align="right">380</td>
<td align="right">6.426316</td>
<td align="right">3</td>
<td align="right">6.793487</td>
<td align="right">7</td>
</tr>
<tr class="even">
<td align="left">M Kartik</td>
<td align="right">234</td>
<td align="right">6.487179</td>
<td align="right">4</td>
<td align="right">6.647312</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">DP Nannes</td>
<td align="right">206</td>
<td align="right">6.524272</td>
<td align="right">5</td>
<td align="right">6.632032</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">AB Dinda</td>
<td align="right">139</td>
<td align="right">6.561151</td>
<td align="right">6</td>
<td align="right">6.713361</td>
<td align="right">5</td>
</tr>
<tr class="odd">
<td align="left">Yuvraj Singh</td>
<td align="right">138</td>
<td align="right">6.608696</td>
<td align="right">7</td>
<td align="right">6.925564</td>
<td align="right">8</td>
</tr>
<tr class="even">
<td align="left">DE Bollinger</td>
<td align="right">186</td>
<td align="right">6.677419</td>
<td align="right">8</td>
<td align="right">6.734258</td>
<td align="right">6</td>
</tr>
<tr class="odd">
<td align="left">PD Collingwood</td>
<td align="right">89</td>
<td align="right">6.808989</td>
<td align="right">9</td>
<td align="right">6.980024</td>
<td align="right">9</td>
</tr>
<tr class="even">
<td align="left">A Mishra</td>
<td align="right">318</td>
<td align="right">6.849057</td>
<td align="right">10</td>
<td align="right">7.197764</td>
<td align="right">17</td>
</tr>
</tbody>
</table>

### Season 2011

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">R Sharma</td>
<td align="right">300</td>
<td align="right">5.460000</td>
<td align="right">1</td>
<td align="right">5.521150</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">AG Murtaza</td>
<td align="right">120</td>
<td align="right">5.850000</td>
<td align="right">2</td>
<td align="right">6.262857</td>
<td align="right">7</td>
</tr>
<tr class="odd">
<td align="left">SL Malinga</td>
<td align="right">378</td>
<td align="right">5.952381</td>
<td align="right">3</td>
<td align="right">6.220336</td>
<td align="right">4</td>
</tr>
<tr class="even">
<td align="left">DL Vettori</td>
<td align="right">310</td>
<td align="right">6.019355</td>
<td align="right">4</td>
<td align="right">6.234085</td>
<td align="right">6</td>
</tr>
<tr class="odd">
<td align="left">B Kumar</td>
<td align="right">66</td>
<td align="right">6.090909</td>
<td align="right">5</td>
<td align="right">6.133397</td>
<td align="right">2</td>
</tr>
<tr class="even">
<td align="left">Iqbal Abdulla</td>
<td align="right">300</td>
<td align="right">6.100000</td>
<td align="right">6</td>
<td align="right">6.213132</td>
<td align="right">3</td>
</tr>
<tr class="odd">
<td align="left">YK Pathan</td>
<td align="right">234</td>
<td align="right">6.102564</td>
<td align="right">7</td>
<td align="right">6.220401</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">R Ashwin</td>
<td align="right">378</td>
<td align="right">6.158730</td>
<td align="right">8</td>
<td align="right">6.309486</td>
<td align="right">8</td>
</tr>
<tr class="odd">
<td align="left">RE van der Merwe</td>
<td align="right">89</td>
<td align="right">6.202247</td>
<td align="right">9</td>
<td align="right">6.417885</td>
<td align="right">9</td>
</tr>
<tr class="even">
<td align="left">SK Warne</td>
<td align="right">282</td>
<td align="right">6.319149</td>
<td align="right">10</td>
<td align="right">6.714260</td>
<td align="right">13</td>
</tr>
</tbody>
</table>

### Season 2012

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">L Balaji</td>
<td align="right">180</td>
<td align="right">5.400000</td>
<td align="right">1</td>
<td align="right">5.560836</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">355</td>
<td align="right">5.476056</td>
<td align="right">2</td>
<td align="right">5.621533</td>
<td align="right">2</td>
</tr>
<tr class="odd">
<td align="left">MJ Clarke</td>
<td align="right">66</td>
<td align="right">6.090909</td>
<td align="right">3</td>
<td align="right">6.111780</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">WD Parnell</td>
<td align="right">126</td>
<td align="right">6.095238</td>
<td align="right">4</td>
<td align="right">6.201371</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">DW Steyn</td>
<td align="right">280</td>
<td align="right">6.107143</td>
<td align="right">5</td>
<td align="right">6.569810</td>
<td align="right">8</td>
</tr>
<tr class="even">
<td align="left">A Chandila</td>
<td align="right">84</td>
<td align="right">6.142857</td>
<td align="right">6</td>
<td align="right">6.551396</td>
<td align="right">7</td>
</tr>
<tr class="odd">
<td align="left">SL Malinga</td>
<td align="right">333</td>
<td align="right">6.306306</td>
<td align="right">7</td>
<td align="right">6.480588</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">M Muralitharan</td>
<td align="right">240</td>
<td align="right">6.500000</td>
<td align="right">8</td>
<td align="right">6.583038</td>
<td align="right">9</td>
</tr>
<tr class="odd">
<td align="left">Shakib Al Hasan</td>
<td align="right">180</td>
<td align="right">6.500000</td>
<td align="right">9</td>
<td align="right">6.678723</td>
<td align="right">11</td>
</tr>
<tr class="even">
<td align="left">Iqbal Abdulla</td>
<td align="right">132</td>
<td align="right">6.545454</td>
<td align="right">10</td>
<td align="right">6.649747</td>
<td align="right">10</td>
</tr>
</tbody>
</table>

### Season 2013

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">SP Narine</td>
<td align="right">384</td>
<td align="right">5.468750</td>
<td align="right">1</td>
<td align="right">5.604965</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">DW Steyn</td>
<td align="right">413</td>
<td align="right">5.796610</td>
<td align="right">2</td>
<td align="right">5.984047</td>
<td align="right">2</td>
</tr>
<tr class="odd">
<td align="left">S Nadeem</td>
<td align="right">264</td>
<td align="right">5.886364</td>
<td align="right">3</td>
<td align="right">6.006154</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">RJ Harris</td>
<td align="right">72</td>
<td align="right">6.000000</td>
<td align="right">4</td>
<td align="right">6.356899</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">A Chandila</td>
<td align="right">150</td>
<td align="right">6.240000</td>
<td align="right">5</td>
<td align="right">6.501068</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">A Mishra</td>
<td align="right">372</td>
<td align="right">6.354839</td>
<td align="right">6</td>
<td align="right">6.928072</td>
<td align="right">16</td>
</tr>
<tr class="odd">
<td align="left">MM Sharma</td>
<td align="right">304</td>
<td align="right">6.434210</td>
<td align="right">7</td>
<td align="right">6.699942</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">RE van der Merwe</td>
<td align="right">66</td>
<td align="right">6.454546</td>
<td align="right">8</td>
<td align="right">6.548808</td>
<td align="right">6</td>
</tr>
<tr class="odd">
<td align="left">BAW Mendis</td>
<td align="right">72</td>
<td align="right">6.500000</td>
<td align="right">9</td>
<td align="right">6.855959</td>
<td align="right">14</td>
</tr>
<tr class="even">
<td align="left">B Kumar</td>
<td align="right">342</td>
<td align="right">6.508772</td>
<td align="right">10</td>
<td align="right">6.616854</td>
<td align="right">8</td>
</tr>
</tbody>
</table>

### Season 2014

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">AR Patel</td>
<td align="right">396</td>
<td align="right">6.136364</td>
<td align="right">1</td>
<td align="right">6.272586</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">390</td>
<td align="right">6.430769</td>
<td align="right">2</td>
<td align="right">6.570742</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">Harbhajan Singh</td>
<td align="right">330</td>
<td align="right">6.472727</td>
<td align="right">3</td>
<td align="right">6.589930</td>
<td align="right">6</td>
</tr>
<tr class="even">
<td align="left">P Kumar</td>
<td align="right">72</td>
<td align="right">6.500000</td>
<td align="right">4</td>
<td align="right">6.535919</td>
<td align="right">2</td>
</tr>
<tr class="odd">
<td align="left">Z Khan</td>
<td align="right">134</td>
<td align="right">6.537313</td>
<td align="right">5</td>
<td align="right">6.584388</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">SL Malinga</td>
<td align="right">236</td>
<td align="right">6.559322</td>
<td align="right">6</td>
<td align="right">6.547804</td>
<td align="right">3</td>
</tr>
<tr class="odd">
<td align="left">B Kumar</td>
<td align="right">319</td>
<td align="right">6.658307</td>
<td align="right">7</td>
<td align="right">6.915754</td>
<td align="right">8</td>
</tr>
<tr class="even">
<td align="left">Shakib Al Hasan</td>
<td align="right">300</td>
<td align="right">6.680000</td>
<td align="right">8</td>
<td align="right">6.626321</td>
<td align="right">7</td>
</tr>
<tr class="odd">
<td align="left">S Badree</td>
<td align="right">84</td>
<td align="right">6.928571</td>
<td align="right">9</td>
<td align="right">6.991873</td>
<td align="right">9</td>
</tr>
<tr class="even">
<td align="left">YS Chahal</td>
<td align="right">330</td>
<td align="right">7.018182</td>
<td align="right">10</td>
<td align="right">7.194906</td>
<td align="right">10</td>
</tr>
</tbody>
</table>

### Season 2015

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">R Ashwin</td>
<td align="right">234</td>
<td align="right">5.846154</td>
<td align="right">1</td>
<td align="right">6.179315</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">MC Henriques</td>
<td align="right">150</td>
<td align="right">6.320000</td>
<td align="right">2</td>
<td align="right">6.217727</td>
<td align="right">2</td>
</tr>
<tr class="odd">
<td align="left">Z Khan</td>
<td align="right">145</td>
<td align="right">6.455172</td>
<td align="right">3</td>
<td align="right">6.846653</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">MA Starc</td>
<td align="right">258</td>
<td align="right">6.767442</td>
<td align="right">4</td>
<td align="right">7.165967</td>
<td align="right">6</td>
</tr>
<tr class="odd">
<td align="left">GB Hogg</td>
<td align="right">126</td>
<td align="right">6.857143</td>
<td align="right">5</td>
<td align="right">7.243222</td>
<td align="right">7</td>
</tr>
<tr class="even">
<td align="left">Sandeep Sharma</td>
<td align="right">300</td>
<td align="right">7.000000</td>
<td align="right">6</td>
<td align="right">7.117760</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">IC Pandey</td>
<td align="right">186</td>
<td align="right">7.193548</td>
<td align="right">7</td>
<td align="right">7.150323</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">DJ Muthuswami</td>
<td align="right">84</td>
<td align="right">7.214286</td>
<td align="right">8</td>
<td align="right">7.349386</td>
<td align="right">9</td>
</tr>
<tr class="odd">
<td align="left">A Nehra</td>
<td align="right">372</td>
<td align="right">7.241936</td>
<td align="right">9</td>
<td align="right">7.434669</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">192</td>
<td align="right">7.312500</td>
<td align="right">10</td>
<td align="right">7.281911</td>
<td align="right">8</td>
</tr>
</tbody>
</table>

### Season 2016

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">regular_eco</th>
<th align="right">reg_rank</th>
<th align="right">weighted_eco</th>
<th align="right">wt_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">A Zampa</td>
<td align="right">102</td>
<td align="right">6.764706</td>
<td align="right">1</td>
<td align="right">7.097701</td>
<td align="right">2</td>
</tr>
<tr class="even">
<td align="left">Mustafizur Rahman</td>
<td align="right">366</td>
<td align="right">6.901639</td>
<td align="right">2</td>
<td align="right">7.079705</td>
<td align="right">1</td>
</tr>
<tr class="odd">
<td align="left">CH Morris</td>
<td align="right">264</td>
<td align="right">7.000000</td>
<td align="right">3</td>
<td align="right">7.149468</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">256</td>
<td align="right">7.125000</td>
<td align="right">4</td>
<td align="right">7.318426</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">BCJ Cutting</td>
<td align="right">67</td>
<td align="right">7.164179</td>
<td align="right">5</td>
<td align="right">7.399600</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">R Bhatia</td>
<td align="right">204</td>
<td align="right">7.176471</td>
<td align="right">6</td>
<td align="right">7.435020</td>
<td align="right">7</td>
</tr>
<tr class="odd">
<td align="left">R Ashwin</td>
<td align="right">264</td>
<td align="right">7.250000</td>
<td align="right">7</td>
<td align="right">7.675747</td>
<td align="right">15</td>
</tr>
<tr class="even">
<td align="left">Sandeep Sharma</td>
<td align="right">300</td>
<td align="right">7.320000</td>
<td align="right">8</td>
<td align="right">7.515504</td>
<td align="right">9</td>
</tr>
<tr class="odd">
<td align="left">J Yadav</td>
<td align="right">102</td>
<td align="right">7.352941</td>
<td align="right">9</td>
<td align="right">7.432729</td>
<td align="right">6</td>
</tr>
<tr class="even">
<td align="left">S Aravind</td>
<td align="right">175</td>
<td align="right">7.405714</td>
<td align="right">10</td>
<td align="right">7.625438</td>
<td align="right">11</td>
</tr>
</tbody>
</table>
