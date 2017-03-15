# Player performance different metrics
Anup Walvekar  
# Better Economy Rate
Economy Rate (ER) is one of the vary important statistic to evaluate a bowler. The definition of ER is the average number of runs given away by the bowler in one over. This [Cricinfo article](http://www.espncricinfo.com/blogs/content/story/1084584.html) argues how this traditional definition of ER is not a good measure of player quality. The gist of the argument is that the traditional definition ignores the context of the game, i.e. the run rate during a match. So instead of calculating ER as the average number of runs per over, we also need to introduce a way to incorporate the context. They introduce the concept of Economy Rate differential (ERx) in the article, which is the average of player economy rate and innings run rate. There are couple of problems with this definition:

1. This definition doesn't take into account the number of balls the player bowled in a game
2. The value of this statistics are very different than the traditional statistic (ER), so it could be hard to comprehend.

To bypass these problems I defined a Weighted Economy Rate (WER), where weights are based on the number of ball bowled by player and the overall run rate of the inning.

$$ \mbox{WER = 6.0 x sum(ER x balls x RR)/sum(balls x RR)} $$
Lets see if this changes anything.



The events data table has information about all deliveries for 577 matches from past 9 IPLs.


```r
events = as.data.table(events)
head(events)
```

```
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
```

We need run rate for all innings in order to get weighted economy rate.

```r
innings_summary = events[,list(match_balls = length(ball[!(extra_type %in%
                                                              c('wides'
                                                                ,'noballs'))])
                               ,match_runs = sum(total_runs)
                               ,match_extra_runs = sum(extra_runs)
                               ,match_wickets = length(out_type[out_type != 'none']))
                         ,by="season,match_id,innings,batting_team,bowling_team"]
kable(head(innings_summary))
```



season    match_id   innings  batting_team                  bowling_team                   match_balls   match_runs   match_extra_runs   match_wickets
-------  ---------  --------  ----------------------------  ----------------------------  ------------  -----------  -----------------  --------------
2008        335982         0  Kolkata Knight Riders         Royal Challengers Bangalore            120          222                 17               3
2008        335982         1  Royal Challengers Bangalore   Kolkata Knight Riders                   91           82                 19              10
2008        335983         0  Chennai Super Kings           Kings XI Punjab                        120          240                  6               5
2008        335983         1  Kings XI Punjab               Chennai Super Kings                    120          207                 11               4
2008        335984         0  Rajasthan Royals              Delhi Daredevils                       120          129                  7               8
2008        335984         1  Delhi Daredevils              Rajasthan Royals                        91          132                 10               1





```r
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
```

```
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
```

```r
bowler_eco_sr[,wt_rank:=rank(weighted_eco,ties.method = "first")
              ,by = "season"]
```

```
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
```

```r
bowler_eco_sr = bowler_eco_sr[order(season,reg_rank,wt_rank)]
```

### Season 2008


bowler           balls   regular_eco   reg_rank   weighted_eco   wt_rank
--------------  ------  ------------  ---------  -------------  --------
SC Ganguly         120      6.400000          1       6.698161         2
Sohail Tanvir      247      6.461538          2       6.644941         1
SM Pollock         276      6.543478          3       7.122027         7
IK Pathan          318      6.603774          4       6.871342         5
GD McGrath         324      6.611111          5       6.779911         3
DW Steyn           228      6.631579          6       6.792388         4
AB Dinda           234      6.666667          7       6.897843         6
M Ntini            210      6.914286          8       7.136370         8
MF Maharoof        216      6.916667          9       7.138704         9
A Mishra           119      6.957983         10       7.176810        10

### Season 2009


bowler             balls   regular_eco   reg_rank   weighted_eco   wt_rank
----------------  ------  ------------  ---------  -------------  --------
M Muralitharan       300      5.220000          1       5.439476         1
JP Duminy            105      5.314286          2       5.462666         2
A Singh              105      5.428571          3       5.595219         3
B Lee                120      5.550000          4       5.662140         4
Harbhajan Singh      264      5.818182          5       5.863481         5
A Kumble             355      5.864789          6       6.077884         8
M Kartik             204      5.911765          7       5.953697         6
SK Raina             166      5.927711          8       6.017274         7
TM Dilshan            96      6.125000          9       6.099834         9
J Botha               72      6.166667         10       6.301226        10

### Season 2010


bowler            balls   regular_eco   reg_rank   weighted_eco   wt_rank
---------------  ------  ------------  ---------  -------------  --------
R Ashwin            288      6.104167          1       6.294597         1
WPUJC Vaas          132      6.318182          2       6.460314         2
A Kumble            380      6.426316          3       6.793487         7
M Kartik            234      6.487179          4       6.647312         4
DP Nannes           206      6.524272          5       6.632032         3
AB Dinda            139      6.561151          6       6.713361         5
Yuvraj Singh        138      6.608696          7       6.925564         8
DE Bollinger        186      6.677419          8       6.734258         6
PD Collingwood       89      6.808989          9       6.980024         9
A Mishra            318      6.849057         10       7.197764        17

### Season 2011


bowler              balls   regular_eco   reg_rank   weighted_eco   wt_rank
-----------------  ------  ------------  ---------  -------------  --------
R Sharma              300      5.460000          1       5.521150         1
AG Murtaza            120      5.850000          2       6.262857         7
SL Malinga            378      5.952381          3       6.220336         4
DL Vettori            310      6.019355          4       6.234085         6
B Kumar                66      6.090909          5       6.133397         2
Iqbal Abdulla         300      6.100000          6       6.213132         3
YK Pathan             234      6.102564          7       6.220401         5
R Ashwin              378      6.158730          8       6.309486         8
RE van der Merwe       89      6.202247          9       6.417885         9
SK Warne              282      6.319149         10       6.714260        13

### Season 2012


bowler             balls   regular_eco   reg_rank   weighted_eco   wt_rank
----------------  ------  ------------  ---------  -------------  --------
L Balaji             180      5.400000          1       5.560836         1
SP Narine            355      5.476056          2       5.621533         2
MJ Clarke             66      6.090909          3       6.111780         3
WD Parnell           126      6.095238          4       6.201371         4
DW Steyn             280      6.107143          5       6.569810         8
A Chandila            84      6.142857          6       6.551396         7
SL Malinga           333      6.306306          7       6.480588         5
M Muralitharan       240      6.500000          8       6.583038         9
Shakib Al Hasan      180      6.500000          9       6.678723        11
Iqbal Abdulla        132      6.545454         10       6.649747        10

### Season 2013


bowler              balls   regular_eco   reg_rank   weighted_eco   wt_rank
-----------------  ------  ------------  ---------  -------------  --------
SP Narine             384      5.468750          1       5.604965         1
DW Steyn              413      5.796610          2       5.984047         2
S Nadeem              264      5.886364          3       6.006154         3
RJ Harris              72      6.000000          4       6.356899         4
A Chandila            150      6.240000          5       6.501068         5
A Mishra              372      6.354839          6       6.928072        16
MM Sharma             304      6.434210          7       6.699942        10
RE van der Merwe       66      6.454546          8       6.548808         6
BAW Mendis             72      6.500000          9       6.855959        14
B Kumar               342      6.508772         10       6.616854         8

### Season 2014


bowler             balls   regular_eco   reg_rank   weighted_eco   wt_rank
----------------  ------  ------------  ---------  -------------  --------
AR Patel             396      6.136364          1       6.272586         1
SP Narine            390      6.430769          2       6.570742         4
Harbhajan Singh      330      6.472727          3       6.589930         6
P Kumar               72      6.500000          4       6.535919         2
Z Khan               134      6.537313          5       6.584388         5
SL Malinga           236      6.559322          6       6.547804         3
B Kumar              319      6.658307          7       6.915754         8
Shakib Al Hasan      300      6.680000          8       6.626321         7
S Badree              84      6.928571          9       6.991873         9
YS Chahal            330      7.018182         10       7.194906        10

### Season 2015


bowler            balls   regular_eco   reg_rank   weighted_eco   wt_rank
---------------  ------  ------------  ---------  -------------  --------
R Ashwin            234      5.846154          1       6.179315         1
MC Henriques        150      6.320000          2       6.217727         2
Z Khan              145      6.455172          3       6.846653         3
MA Starc            258      6.767442          4       7.165967         6
GB Hogg             126      6.857143          5       7.243222         7
Sandeep Sharma      300      7.000000          6       7.117760         4
IC Pandey           186      7.193548          7       7.150323         5
DJ Muthuswami        84      7.214286          8       7.349386         9
A Nehra             372      7.241936          9       7.434669        10
SP Narine           192      7.312500         10       7.281911         8

### Season 2016


bowler               balls   regular_eco   reg_rank   weighted_eco   wt_rank
------------------  ------  ------------  ---------  -------------  --------
A Zampa                102      6.764706          1       7.097701         2
Mustafizur Rahman      366      6.901639          2       7.079705         1
CH Morris              264      7.000000          3       7.149468         3
SP Narine              256      7.125000          4       7.318426         4
BCJ Cutting             67      7.164179          5       7.399600         5
R Bhatia               204      7.176471          6       7.435020         7
R Ashwin               264      7.250000          7       7.675747        15
Sandeep Sharma         300      7.320000          8       7.515504         9
J Yadav                102      7.352941          9       7.432729         6
S Aravind              175      7.405714         10       7.625438        11

