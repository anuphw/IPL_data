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
are some problems with this definition:

1.  This definition doesn't take into account the number of balls the
    player bowled in a game
2.  The value of this statistics are very different than the traditional
    statistic (ER), so it could be hard to comprehend.
3.  ERx compares players of same team well, but it fails to encorporate
    the absolute value of players abilities. e.g. if an average player
    is bowling with bad bowlers, his ERx stat is going to be very good,
    may be even better than best of the bowlers.

### New Economy Rate definitions

To bypass these problems I defined following economy rating definitions.

1.  ER1: 6 x runs/balls,
2.  ER2: 6 x sum(runs\_i x rr\_i)/sum(balls\_i x rr\_i), where rr\_i is
    run-rate of ith match,
3.  ER3: 6 x runs/balls + sum(w\_i x (rr\_i - eco\_i)), where eco\_i is
    economy rate of the bowler in ith match.
4.  R\_i is the ranking of players w.r.t. ERi statistics.

I rank all players who have bowled at least 15 overs (60 balls) in a
given season.

The events data table has information about all deliveries for 577
matches from past 9 IPLs.

### Season 2008

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">SC Ganguly</td>
<td align="right">120</td>
<td align="right">128</td>
<td align="right">6</td>
<td align="right">6.400000</td>
<td align="right">1</td>
<td align="right">6.698161</td>
<td align="right">2</td>
<td align="right">7.425840</td>
<td align="right">3</td>
</tr>
<tr class="even">
<td align="left">Sohail Tanvir</td>
<td align="right">247</td>
<td align="right">266</td>
<td align="right">22</td>
<td align="right">6.461538</td>
<td align="right">2</td>
<td align="right">6.644941</td>
<td align="right">1</td>
<td align="right">7.276217</td>
<td align="right">2</td>
</tr>
<tr class="odd">
<td align="left">SM Pollock</td>
<td align="right">276</td>
<td align="right">301</td>
<td align="right">11</td>
<td align="right">6.543478</td>
<td align="right">3</td>
<td align="right">7.122027</td>
<td align="right">7</td>
<td align="right">7.865724</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">IK Pathan</td>
<td align="right">318</td>
<td align="right">350</td>
<td align="right">15</td>
<td align="right">6.603774</td>
<td align="right">4</td>
<td align="right">6.871342</td>
<td align="right">5</td>
<td align="right">8.525991</td>
<td align="right">45</td>
</tr>
<tr class="odd">
<td align="left">GD McGrath</td>
<td align="right">324</td>
<td align="right">357</td>
<td align="right">12</td>
<td align="right">6.611111</td>
<td align="right">5</td>
<td align="right">6.779911</td>
<td align="right">3</td>
<td align="right">8.366749</td>
<td align="right">38</td>
</tr>
<tr class="even">
<td align="left">DW Steyn</td>
<td align="right">228</td>
<td align="right">252</td>
<td align="right">10</td>
<td align="right">6.631579</td>
<td align="right">6</td>
<td align="right">6.792388</td>
<td align="right">4</td>
<td align="right">8.003021</td>
<td align="right">17</td>
</tr>
<tr class="odd">
<td align="left">AB Dinda</td>
<td align="right">234</td>
<td align="right">260</td>
<td align="right">9</td>
<td align="right">6.666667</td>
<td align="right">7</td>
<td align="right">6.897843</td>
<td align="right">6</td>
<td align="right">7.893073</td>
<td align="right">12</td>
</tr>
<tr class="even">
<td align="left">M Ntini</td>
<td align="right">210</td>
<td align="right">242</td>
<td align="right">7</td>
<td align="right">6.914286</td>
<td align="right">8</td>
<td align="right">7.136370</td>
<td align="right">8</td>
<td align="right">7.826362</td>
<td align="right">9</td>
</tr>
<tr class="odd">
<td align="left">MF Maharoof</td>
<td align="right">216</td>
<td align="right">249</td>
<td align="right">15</td>
<td align="right">6.916667</td>
<td align="right">9</td>
<td align="right">7.138704</td>
<td align="right">9</td>
<td align="right">8.104077</td>
<td align="right">23</td>
</tr>
<tr class="even">
<td align="left">A Mishra</td>
<td align="right">119</td>
<td align="right">138</td>
<td align="right">11</td>
<td align="right">6.957983</td>
<td align="right">10</td>
<td align="right">7.176810</td>
<td align="right">10</td>
<td align="right">8.932464</td>
<td align="right">56</td>
</tr>
</tbody>
</table>

### Season 2009

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">M Muralitharan</td>
<td align="right">300</td>
<td align="right">261</td>
<td align="right">14</td>
<td align="right">5.220000</td>
<td align="right">1</td>
<td align="right">5.439476</td>
<td align="right">1</td>
<td align="right">7.435463</td>
<td align="right">26</td>
</tr>
<tr class="even">
<td align="left">JP Duminy</td>
<td align="right">105</td>
<td align="right">93</td>
<td align="right">4</td>
<td align="right">5.314286</td>
<td align="right">2</td>
<td align="right">5.462666</td>
<td align="right">2</td>
<td align="right">6.768402</td>
<td align="right">3</td>
</tr>
<tr class="odd">
<td align="left">A Singh</td>
<td align="right">105</td>
<td align="right">95</td>
<td align="right">9</td>
<td align="right">5.428571</td>
<td align="right">3</td>
<td align="right">5.595219</td>
<td align="right">3</td>
<td align="right">6.370310</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">B Lee</td>
<td align="right">120</td>
<td align="right">111</td>
<td align="right">5</td>
<td align="right">5.550000</td>
<td align="right">4</td>
<td align="right">5.662140</td>
<td align="right">4</td>
<td align="right">6.863878</td>
<td align="right">5</td>
</tr>
<tr class="odd">
<td align="left">Harbhajan Singh</td>
<td align="right">264</td>
<td align="right">256</td>
<td align="right">12</td>
<td align="right">5.818182</td>
<td align="right">5</td>
<td align="right">5.863481</td>
<td align="right">5</td>
<td align="right">7.230560</td>
<td align="right">13</td>
</tr>
<tr class="even">
<td align="left">A Kumble</td>
<td align="right">355</td>
<td align="right">347</td>
<td align="right">21</td>
<td align="right">5.864789</td>
<td align="right">6</td>
<td align="right">6.077884</td>
<td align="right">8</td>
<td align="right">7.520609</td>
<td align="right">35</td>
</tr>
<tr class="odd">
<td align="left">M Kartik</td>
<td align="right">204</td>
<td align="right">201</td>
<td align="right">4</td>
<td align="right">5.911765</td>
<td align="right">7</td>
<td align="right">5.953697</td>
<td align="right">6</td>
<td align="right">8.047880</td>
<td align="right">70</td>
</tr>
<tr class="even">
<td align="left">SK Raina</td>
<td align="right">166</td>
<td align="right">164</td>
<td align="right">7</td>
<td align="right">5.927711</td>
<td align="right">8</td>
<td align="right">6.017274</td>
<td align="right">7</td>
<td align="right">7.461008</td>
<td align="right">28</td>
</tr>
<tr class="odd">
<td align="left">TM Dilshan</td>
<td align="right">96</td>
<td align="right">98</td>
<td align="right">0</td>
<td align="right">6.125000</td>
<td align="right">9</td>
<td align="right">6.099834</td>
<td align="right">9</td>
<td align="right">7.504138</td>
<td align="right">33</td>
</tr>
<tr class="even">
<td align="left">J Botha</td>
<td align="right">72</td>
<td align="right">74</td>
<td align="right">3</td>
<td align="right">6.166667</td>
<td align="right">10</td>
<td align="right">6.301226</td>
<td align="right">10</td>
<td align="right">6.646951</td>
<td align="right">2</td>
</tr>
</tbody>
</table>

### Season 2010

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">R Ashwin</td>
<td align="right">288</td>
<td align="right">293</td>
<td align="right">13</td>
<td align="right">6.104167</td>
<td align="right">1</td>
<td align="right">6.294597</td>
<td align="right">1</td>
<td align="right">7.443582</td>
<td align="right">4</td>
</tr>
<tr class="even">
<td align="left">WPUJC Vaas</td>
<td align="right">132</td>
<td align="right">139</td>
<td align="right">9</td>
<td align="right">6.318182</td>
<td align="right">2</td>
<td align="right">6.460314</td>
<td align="right">2</td>
<td align="right">8.030222</td>
<td align="right">36</td>
</tr>
<tr class="odd">
<td align="left">A Kumble</td>
<td align="right">380</td>
<td align="right">407</td>
<td align="right">17</td>
<td align="right">6.426316</td>
<td align="right">3</td>
<td align="right">6.793487</td>
<td align="right">7</td>
<td align="right">7.972465</td>
<td align="right">27</td>
</tr>
<tr class="even">
<td align="left">M Kartik</td>
<td align="right">234</td>
<td align="right">253</td>
<td align="right">9</td>
<td align="right">6.487179</td>
<td align="right">4</td>
<td align="right">6.647312</td>
<td align="right">4</td>
<td align="right">8.049713</td>
<td align="right">40</td>
</tr>
<tr class="odd">
<td align="left">DP Nannes</td>
<td align="right">206</td>
<td align="right">224</td>
<td align="right">7</td>
<td align="right">6.524272</td>
<td align="right">5</td>
<td align="right">6.632032</td>
<td align="right">3</td>
<td align="right">8.025164</td>
<td align="right">35</td>
</tr>
<tr class="even">
<td align="left">AB Dinda</td>
<td align="right">139</td>
<td align="right">152</td>
<td align="right">9</td>
<td align="right">6.561151</td>
<td align="right">6</td>
<td align="right">6.713361</td>
<td align="right">5</td>
<td align="right">8.005842</td>
<td align="right">32</td>
</tr>
<tr class="odd">
<td align="left">Yuvraj Singh</td>
<td align="right">138</td>
<td align="right">152</td>
<td align="right">5</td>
<td align="right">6.608696</td>
<td align="right">7</td>
<td align="right">6.925564</td>
<td align="right">8</td>
<td align="right">8.094052</td>
<td align="right">42</td>
</tr>
<tr class="even">
<td align="left">DE Bollinger</td>
<td align="right">186</td>
<td align="right">207</td>
<td align="right">12</td>
<td align="right">6.677419</td>
<td align="right">8</td>
<td align="right">6.734258</td>
<td align="right">6</td>
<td align="right">7.602840</td>
<td align="right">8</td>
</tr>
<tr class="odd">
<td align="left">PD Collingwood</td>
<td align="right">89</td>
<td align="right">101</td>
<td align="right">5</td>
<td align="right">6.808989</td>
<td align="right">9</td>
<td align="right">6.980024</td>
<td align="right">9</td>
<td align="right">7.618476</td>
<td align="right">9</td>
</tr>
<tr class="even">
<td align="left">A Mishra</td>
<td align="right">318</td>
<td align="right">363</td>
<td align="right">17</td>
<td align="right">6.849057</td>
<td align="right">10</td>
<td align="right">7.197764</td>
<td align="right">17</td>
<td align="right">7.770759</td>
<td align="right">14</td>
</tr>
</tbody>
</table>

### Season 2011

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">R Sharma</td>
<td align="right">300</td>
<td align="right">273</td>
<td align="right">16</td>
<td align="right">5.460000</td>
<td align="right">1</td>
<td align="right">5.521150</td>
<td align="right">1</td>
<td align="right">7.366129</td>
<td align="right">17</td>
</tr>
<tr class="even">
<td align="left">AG Murtaza</td>
<td align="right">120</td>
<td align="right">117</td>
<td align="right">3</td>
<td align="right">5.850000</td>
<td align="right">2</td>
<td align="right">6.262857</td>
<td align="right">7</td>
<td align="right">6.819724</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">SL Malinga</td>
<td align="right">378</td>
<td align="right">375</td>
<td align="right">28</td>
<td align="right">5.952381</td>
<td align="right">3</td>
<td align="right">6.220336</td>
<td align="right">4</td>
<td align="right">7.524583</td>
<td align="right">34</td>
</tr>
<tr class="even">
<td align="left">DL Vettori</td>
<td align="right">310</td>
<td align="right">311</td>
<td align="right">12</td>
<td align="right">6.019355</td>
<td align="right">4</td>
<td align="right">6.234085</td>
<td align="right">6</td>
<td align="right">7.914560</td>
<td align="right">60</td>
</tr>
<tr class="odd">
<td align="left">B Kumar</td>
<td align="right">66</td>
<td align="right">67</td>
<td align="right">3</td>
<td align="right">6.090909</td>
<td align="right">5</td>
<td align="right">6.133397</td>
<td align="right">2</td>
<td align="right">6.722351</td>
<td align="right">2</td>
</tr>
<tr class="even">
<td align="left">Iqbal Abdulla</td>
<td align="right">300</td>
<td align="right">305</td>
<td align="right">16</td>
<td align="right">6.100000</td>
<td align="right">6</td>
<td align="right">6.213132</td>
<td align="right">3</td>
<td align="right">7.176399</td>
<td align="right">9</td>
</tr>
<tr class="odd">
<td align="left">YK Pathan</td>
<td align="right">234</td>
<td align="right">238</td>
<td align="right">13</td>
<td align="right">6.102564</td>
<td align="right">7</td>
<td align="right">6.220401</td>
<td align="right">5</td>
<td align="right">7.003196</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">R Ashwin</td>
<td align="right">378</td>
<td align="right">388</td>
<td align="right">20</td>
<td align="right">6.158730</td>
<td align="right">8</td>
<td align="right">6.309486</td>
<td align="right">8</td>
<td align="right">7.624238</td>
<td align="right">43</td>
</tr>
<tr class="odd">
<td align="left">RE van der Merwe</td>
<td align="right">89</td>
<td align="right">92</td>
<td align="right">5</td>
<td align="right">6.202247</td>
<td align="right">9</td>
<td align="right">6.417885</td>
<td align="right">9</td>
<td align="right">7.335563</td>
<td align="right">16</td>
</tr>
<tr class="even">
<td align="left">SK Warne</td>
<td align="right">282</td>
<td align="right">297</td>
<td align="right">13</td>
<td align="right">6.319149</td>
<td align="right">10</td>
<td align="right">6.714260</td>
<td align="right">13</td>
<td align="right">7.452101</td>
<td align="right">24</td>
</tr>
</tbody>
</table>

### Season 2012

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">L Balaji</td>
<td align="right">180</td>
<td align="right">162</td>
<td align="right">11</td>
<td align="right">5.400000</td>
<td align="right">1</td>
<td align="right">5.560836</td>
<td align="right">1</td>
<td align="right">6.337971</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">355</td>
<td align="right">324</td>
<td align="right">24</td>
<td align="right">5.476056</td>
<td align="right">2</td>
<td align="right">5.621533</td>
<td align="right">2</td>
<td align="right">7.180453</td>
<td align="right">12</td>
</tr>
<tr class="odd">
<td align="left">MJ Clarke</td>
<td align="right">66</td>
<td align="right">67</td>
<td align="right">2</td>
<td align="right">6.090909</td>
<td align="right">3</td>
<td align="right">6.111780</td>
<td align="right">3</td>
<td align="right">7.116234</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">WD Parnell</td>
<td align="right">126</td>
<td align="right">128</td>
<td align="right">5</td>
<td align="right">6.095238</td>
<td align="right">4</td>
<td align="right">6.201371</td>
<td align="right">4</td>
<td align="right">7.094218</td>
<td align="right">9</td>
</tr>
<tr class="odd">
<td align="left">DW Steyn</td>
<td align="right">280</td>
<td align="right">285</td>
<td align="right">18</td>
<td align="right">6.107143</td>
<td align="right">5</td>
<td align="right">6.569810</td>
<td align="right">8</td>
<td align="right">7.953898</td>
<td align="right">49</td>
</tr>
<tr class="even">
<td align="left">A Chandila</td>
<td align="right">84</td>
<td align="right">86</td>
<td align="right">5</td>
<td align="right">6.142857</td>
<td align="right">6</td>
<td align="right">6.551396</td>
<td align="right">7</td>
<td align="right">7.738549</td>
<td align="right">33</td>
</tr>
<tr class="odd">
<td align="left">SL Malinga</td>
<td align="right">333</td>
<td align="right">350</td>
<td align="right">22</td>
<td align="right">6.306306</td>
<td align="right">7</td>
<td align="right">6.480588</td>
<td align="right">5</td>
<td align="right">7.632824</td>
<td align="right">25</td>
</tr>
<tr class="even">
<td align="left">M Muralitharan</td>
<td align="right">240</td>
<td align="right">260</td>
<td align="right">15</td>
<td align="right">6.500000</td>
<td align="right">8</td>
<td align="right">6.583038</td>
<td align="right">9</td>
<td align="right">8.334661</td>
<td align="right">64</td>
</tr>
<tr class="odd">
<td align="left">Shakib Al Hasan</td>
<td align="right">180</td>
<td align="right">195</td>
<td align="right">12</td>
<td align="right">6.500000</td>
<td align="right">9</td>
<td align="right">6.678723</td>
<td align="right">11</td>
<td align="right">6.936304</td>
<td align="right">5</td>
</tr>
<tr class="even">
<td align="left">Iqbal Abdulla</td>
<td align="right">132</td>
<td align="right">144</td>
<td align="right">4</td>
<td align="right">6.545454</td>
<td align="right">10</td>
<td align="right">6.649747</td>
<td align="right">10</td>
<td align="right">6.861107</td>
<td align="right">2</td>
</tr>
</tbody>
</table>

### Season 2013

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">SP Narine</td>
<td align="right">384</td>
<td align="right">350</td>
<td align="right">22</td>
<td align="right">5.468750</td>
<td align="right">1</td>
<td align="right">5.604965</td>
<td align="right">1</td>
<td align="right">7.415200</td>
<td align="right">16</td>
</tr>
<tr class="even">
<td align="left">DW Steyn</td>
<td align="right">413</td>
<td align="right">399</td>
<td align="right">19</td>
<td align="right">5.796610</td>
<td align="right">2</td>
<td align="right">5.984047</td>
<td align="right">2</td>
<td align="right">7.200647</td>
<td align="right">11</td>
</tr>
<tr class="odd">
<td align="left">S Nadeem</td>
<td align="right">264</td>
<td align="right">259</td>
<td align="right">9</td>
<td align="right">5.886364</td>
<td align="right">3</td>
<td align="right">6.006154</td>
<td align="right">3</td>
<td align="right">7.805609</td>
<td align="right">41</td>
</tr>
<tr class="even">
<td align="left">RJ Harris</td>
<td align="right">72</td>
<td align="right">72</td>
<td align="right">1</td>
<td align="right">6.000000</td>
<td align="right">4</td>
<td align="right">6.356899</td>
<td align="right">4</td>
<td align="right">6.495491</td>
<td align="right">1</td>
</tr>
<tr class="odd">
<td align="left">A Chandila</td>
<td align="right">150</td>
<td align="right">156</td>
<td align="right">6</td>
<td align="right">6.240000</td>
<td align="right">5</td>
<td align="right">6.501068</td>
<td align="right">5</td>
<td align="right">7.524473</td>
<td align="right">25</td>
</tr>
<tr class="even">
<td align="left">A Mishra</td>
<td align="right">372</td>
<td align="right">394</td>
<td align="right">21</td>
<td align="right">6.354839</td>
<td align="right">6</td>
<td align="right">6.928072</td>
<td align="right">16</td>
<td align="right">7.012180</td>
<td align="right">4</td>
</tr>
<tr class="odd">
<td align="left">MM Sharma</td>
<td align="right">304</td>
<td align="right">326</td>
<td align="right">20</td>
<td align="right">6.434210</td>
<td align="right">7</td>
<td align="right">6.699942</td>
<td align="right">10</td>
<td align="right">7.586204</td>
<td align="right">28</td>
</tr>
<tr class="even">
<td align="left">RE van der Merwe</td>
<td align="right">66</td>
<td align="right">71</td>
<td align="right">3</td>
<td align="right">6.454546</td>
<td align="right">8</td>
<td align="right">6.548808</td>
<td align="right">6</td>
<td align="right">7.806417</td>
<td align="right">42</td>
</tr>
<tr class="odd">
<td align="left">BAW Mendis</td>
<td align="right">72</td>
<td align="right">78</td>
<td align="right">2</td>
<td align="right">6.500000</td>
<td align="right">9</td>
<td align="right">6.855959</td>
<td align="right">14</td>
<td align="right">8.295814</td>
<td align="right">65</td>
</tr>
<tr class="even">
<td align="left">B Kumar</td>
<td align="right">342</td>
<td align="right">371</td>
<td align="right">13</td>
<td align="right">6.508772</td>
<td align="right">10</td>
<td align="right">6.616854</td>
<td align="right">8</td>
<td align="right">8.107075</td>
<td align="right">58</td>
</tr>
</tbody>
</table>

### Season 2014

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">AR Patel</td>
<td align="right">396</td>
<td align="right">405</td>
<td align="right">17</td>
<td align="right">6.136364</td>
<td align="right">1</td>
<td align="right">6.272586</td>
<td align="right">1</td>
<td align="right">8.470429</td>
<td align="right">48</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">390</td>
<td align="right">418</td>
<td align="right">21</td>
<td align="right">6.430769</td>
<td align="right">2</td>
<td align="right">6.570742</td>
<td align="right">4</td>
<td align="right">7.782768</td>
<td align="right">11</td>
</tr>
<tr class="odd">
<td align="left">Harbhajan Singh</td>
<td align="right">330</td>
<td align="right">356</td>
<td align="right">14</td>
<td align="right">6.472727</td>
<td align="right">3</td>
<td align="right">6.589930</td>
<td align="right">6</td>
<td align="right">8.024522</td>
<td align="right">23</td>
</tr>
<tr class="even">
<td align="left">P Kumar</td>
<td align="right">72</td>
<td align="right">78</td>
<td align="right">3</td>
<td align="right">6.500000</td>
<td align="right">4</td>
<td align="right">6.535919</td>
<td align="right">2</td>
<td align="right">8.477900</td>
<td align="right">50</td>
</tr>
<tr class="odd">
<td align="left">Z Khan</td>
<td align="right">134</td>
<td align="right">146</td>
<td align="right">5</td>
<td align="right">6.537313</td>
<td align="right">5</td>
<td align="right">6.584388</td>
<td align="right">5</td>
<td align="right">7.683515</td>
<td align="right">9</td>
</tr>
<tr class="even">
<td align="left">SL Malinga</td>
<td align="right">236</td>
<td align="right">258</td>
<td align="right">16</td>
<td align="right">6.559322</td>
<td align="right">6</td>
<td align="right">6.547804</td>
<td align="right">3</td>
<td align="right">7.806094</td>
<td align="right">13</td>
</tr>
<tr class="odd">
<td align="left">B Kumar</td>
<td align="right">319</td>
<td align="right">354</td>
<td align="right">20</td>
<td align="right">6.658307</td>
<td align="right">7</td>
<td align="right">6.915754</td>
<td align="right">8</td>
<td align="right">8.264168</td>
<td align="right">35</td>
</tr>
<tr class="even">
<td align="left">Shakib Al Hasan</td>
<td align="right">300</td>
<td align="right">334</td>
<td align="right">11</td>
<td align="right">6.680000</td>
<td align="right">8</td>
<td align="right">6.626321</td>
<td align="right">7</td>
<td align="right">7.868317</td>
<td align="right">14</td>
</tr>
<tr class="odd">
<td align="left">S Badree</td>
<td align="right">84</td>
<td align="right">97</td>
<td align="right">2</td>
<td align="right">6.928571</td>
<td align="right">9</td>
<td align="right">6.991873</td>
<td align="right">9</td>
<td align="right">7.541357</td>
<td align="right">4</td>
</tr>
<tr class="even">
<td align="left">YS Chahal</td>
<td align="right">330</td>
<td align="right">386</td>
<td align="right">12</td>
<td align="right">7.018182</td>
<td align="right">10</td>
<td align="right">7.194906</td>
<td align="right">10</td>
<td align="right">8.063575</td>
<td align="right">25</td>
</tr>
</tbody>
</table>

### Season 2015

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">R Ashwin</td>
<td align="right">234</td>
<td align="right">228</td>
<td align="right">10</td>
<td align="right">5.846154</td>
<td align="right">1</td>
<td align="right">6.179315</td>
<td align="right">1</td>
<td align="right">7.500611</td>
<td align="right">2</td>
</tr>
<tr class="even">
<td align="left">MC Henriques</td>
<td align="right">150</td>
<td align="right">158</td>
<td align="right">11</td>
<td align="right">6.320000</td>
<td align="right">2</td>
<td align="right">6.217727</td>
<td align="right">2</td>
<td align="right">8.528725</td>
<td align="right">38</td>
</tr>
<tr class="odd">
<td align="left">Z Khan</td>
<td align="right">145</td>
<td align="right">156</td>
<td align="right">7</td>
<td align="right">6.455172</td>
<td align="right">3</td>
<td align="right">6.846653</td>
<td align="right">3</td>
<td align="right">7.600152</td>
<td align="right">4</td>
</tr>
<tr class="even">
<td align="left">MA Starc</td>
<td align="right">258</td>
<td align="right">291</td>
<td align="right">20</td>
<td align="right">6.767442</td>
<td align="right">4</td>
<td align="right">7.165967</td>
<td align="right">6</td>
<td align="right">8.053121</td>
<td align="right">15</td>
</tr>
<tr class="odd">
<td align="left">GB Hogg</td>
<td align="right">126</td>
<td align="right">144</td>
<td align="right">9</td>
<td align="right">6.857143</td>
<td align="right">5</td>
<td align="right">7.243222</td>
<td align="right">7</td>
<td align="right">8.109195</td>
<td align="right">18</td>
</tr>
<tr class="even">
<td align="left">Sandeep Sharma</td>
<td align="right">300</td>
<td align="right">350</td>
<td align="right">13</td>
<td align="right">7.000000</td>
<td align="right">6</td>
<td align="right">7.117760</td>
<td align="right">4</td>
<td align="right">8.883697</td>
<td align="right">55</td>
</tr>
<tr class="odd">
<td align="left">IC Pandey</td>
<td align="right">186</td>
<td align="right">223</td>
<td align="right">11</td>
<td align="right">7.193548</td>
<td align="right">7</td>
<td align="right">7.150323</td>
<td align="right">5</td>
<td align="right">7.290246</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">DJ Muthuswami</td>
<td align="right">84</td>
<td align="right">101</td>
<td align="right">4</td>
<td align="right">7.214286</td>
<td align="right">8</td>
<td align="right">7.349386</td>
<td align="right">9</td>
<td align="right">8.039557</td>
<td align="right">14</td>
</tr>
<tr class="odd">
<td align="left">A Nehra</td>
<td align="right">372</td>
<td align="right">449</td>
<td align="right">22</td>
<td align="right">7.241936</td>
<td align="right">9</td>
<td align="right">7.434669</td>
<td align="right">10</td>
<td align="right">7.840828</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">192</td>
<td align="right">234</td>
<td align="right">7</td>
<td align="right">7.312500</td>
<td align="right">10</td>
<td align="right">7.281911</td>
<td align="right">8</td>
<td align="right">8.408882</td>
<td align="right">34</td>
</tr>
</tbody>
</table>

### Season 2016

<table>
<thead>
<tr class="header">
<th align="left">bowler</th>
<th align="right">balls</th>
<th align="right">runs</th>
<th align="right">wickets</th>
<th align="right">ER1</th>
<th align="right">R_1</th>
<th align="right">ER2</th>
<th align="right">R_2</th>
<th align="right">ER3</th>
<th align="right">R_3</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">A Zampa</td>
<td align="right">102</td>
<td align="right">115</td>
<td align="right">12</td>
<td align="right">6.764706</td>
<td align="right">1</td>
<td align="right">7.097701</td>
<td align="right">2</td>
<td align="right">8.188235</td>
<td align="right">26</td>
</tr>
<tr class="even">
<td align="left">Mustafizur Rahman</td>
<td align="right">366</td>
<td align="right">421</td>
<td align="right">17</td>
<td align="right">6.901639</td>
<td align="right">2</td>
<td align="right">7.079705</td>
<td align="right">1</td>
<td align="right">7.965578</td>
<td align="right">11</td>
</tr>
<tr class="odd">
<td align="left">CH Morris</td>
<td align="right">264</td>
<td align="right">308</td>
<td align="right">13</td>
<td align="right">7.000000</td>
<td align="right">3</td>
<td align="right">7.149468</td>
<td align="right">3</td>
<td align="right">8.011569</td>
<td align="right">15</td>
</tr>
<tr class="even">
<td align="left">SP Narine</td>
<td align="right">256</td>
<td align="right">304</td>
<td align="right">11</td>
<td align="right">7.125000</td>
<td align="right">4</td>
<td align="right">7.318426</td>
<td align="right">4</td>
<td align="right">8.271729</td>
<td align="right">34</td>
</tr>
<tr class="odd">
<td align="left">BCJ Cutting</td>
<td align="right">67</td>
<td align="right">80</td>
<td align="right">5</td>
<td align="right">7.164179</td>
<td align="right">5</td>
<td align="right">7.399600</td>
<td align="right">5</td>
<td align="right">8.573881</td>
<td align="right">52</td>
</tr>
<tr class="even">
<td align="left">R Bhatia</td>
<td align="right">204</td>
<td align="right">244</td>
<td align="right">6</td>
<td align="right">7.176471</td>
<td align="right">6</td>
<td align="right">7.435020</td>
<td align="right">7</td>
<td align="right">8.196241</td>
<td align="right">27</td>
</tr>
<tr class="odd">
<td align="left">R Ashwin</td>
<td align="right">264</td>
<td align="right">319</td>
<td align="right">10</td>
<td align="right">7.250000</td>
<td align="right">7</td>
<td align="right">7.675747</td>
<td align="right">15</td>
<td align="right">8.258038</td>
<td align="right">32</td>
</tr>
<tr class="even">
<td align="left">Sandeep Sharma</td>
<td align="right">300</td>
<td align="right">366</td>
<td align="right">15</td>
<td align="right">7.320000</td>
<td align="right">8</td>
<td align="right">7.515504</td>
<td align="right">9</td>
<td align="right">8.564704</td>
<td align="right">51</td>
</tr>
<tr class="odd">
<td align="left">J Yadav</td>
<td align="right">102</td>
<td align="right">125</td>
<td align="right">2</td>
<td align="right">7.352941</td>
<td align="right">9</td>
<td align="right">7.432729</td>
<td align="right">6</td>
<td align="right">7.370286</td>
<td align="right">2</td>
</tr>
<tr class="even">
<td align="left">S Aravind</td>
<td align="right">175</td>
<td align="right">216</td>
<td align="right">11</td>
<td align="right">7.405714</td>
<td align="right">10</td>
<td align="right">7.625438</td>
<td align="right">11</td>
<td align="right">8.487780</td>
<td align="right">46</td>
</tr>
</tbody>
</table>
