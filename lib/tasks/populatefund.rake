require 'rubygems' 
require 'bundler/setup'
require 'open-uri'

namespace :db do
  desc "fill fund database"
  task :populatefund => :environment do
  	codes =[10780,	15682,	14951,	15684,	10826,	15688,	12052,	15690,	14946,	15698,	32,	17119,	1820,	15707,	11194,	15766,	11534,	15783,	27,	15697,	2049,	15704,	726,	15881,	9316,	15805,	1530,	15813,	561,	15741,	1400,	15831,	1445,	15769,	2787,	15834,	1824,	15901,	11196,	15837,	3161,	15846,	5802,	15903,	5804,	15905,	3590,	15908,	1439,	15870,	787,	15872,	727,	15878,	13012,	6778,	15879,	5006,	15935,	6550,	15892,	590,	15886,	24,	15889,	2865,	15883,	2830,	15716,	2338,	15719,	3259,	15726,	15732,	3001,	8989,	8985,	16267,	10854,	15735,	10099,	10097,	16803,	2645,	16581,	1839,	16588,	59,	16594,	10592,	10590,	16600,	15761,	2960,	15765,	11333,	15776,	2472,	10603,	15787,	393,	16386,	5609,	11183,	16388,	5069,	16411,	7128,	16988,	776,	16425,	3725,	16438,	5240,	2222,	16410,	3985,	16454,	774,	17003,	5219,	1540,	16456,	15152,	17006,	13395,	17009,	10559,	17012,	5623,	17016,	10799,	17021,	15574,	1513,	10438,	11136,	17348,	5558,	17349,	15620,	2057,	10440,	3126,	17350,	10432,	17352,	10434,	10436,	10125,	17762,	10609,	17354,	10478,	13198,	15976,	952,	17361,	4111,	17363,	5621,	17371,	8216,	17373,	8827,	17377,	818,	17381,	6383,	15977,	10563,	15979,	114,	15982,	2605,	15986,	5141,	15990,	2167,	15993,	834,	15996,	2133,	15999,	115,	16003,	116,	16008,	3019,	16010,	601,	16014,	548,	16018,	14017,	16027,	1978,	16030,	2255,	9962,	16435,	10218,	10905,	15376,	16427,	11650,	1171,	1545,	6175,	218,	15989,	2372,	16021,	219,	16026,	3097,	16097,	842,	16055,	1368,	16069,	1370,	16071,	1372,	16073,	6677,	16074,	915,	16090,	5067,	16114,	2668,	16132,	854,	16160,	104,	16164,	12632,	17042,	17043,	5562,	17388,	6774,	17037,	1481,	16289,	2072,	16320,	2736,	16325,	3087,	16330,	6776,	16282,	3927,	16332,	4254,	17698,	1936,	15936,	8293,	20933,	15822,	3278,	2310,	15945,	12753,	4437,	1471,	15859,	2968,	15836,	591,	15841,	7519,	7517,	20857,	20855,	15959,	1236,	17116,	5648,	5646,	15849,	4936,	2814,	15960,	3402,	2439,	18653,	11236,	15856,	1512,	17412,	10399,	15862,	640,	15864,	737,	15868,	3279,	534,	15874,	2857,	86,	14998,	17160,	14722,	16499,	11188,	16523,	11500,	16528,	20683,	20681,	16474,	10376,	2797,	16699,	3400,	16507,	3151,	16512,	10216,	16514,	12129,	16504,	11154,	16501,	2886,	16498,	6693,	16710,	8871,	16493,	10032,	14972,	16475,	13382,	14013,	15579,	606,	16901,	2879,	16907,	6275,	17099,	2063,	16937,	8123,	17104,	2742,	16931,	4154,	16876,	8751,	17094,	4553,	16927,	2127,	16910,	16918,	3157,	16530,	6673,	16539,	108,	16541,	8653,	16547,	6679,	16552,	12762,	17131,	11691,	17127,	10567,	17132,	4871,	16569,	6227,	16586,	10095,	16592,	20060,	20059,	577,	16337,	2780,	16341,	4270,	17134,	2308,	17436,	5560,	17439,	2597,	16382,	10843,	2360,	16378,	6157,	10594,	17140,	7780,	2937,	16380,	2686,	16212,	10859,	16243,	5707,	16256,	3326,	16266,	10789,	16269,	4836,	16272,	5564,	16275,	2333,	16280,	3112,	16200,	2920,	134,	16756,	158,	16781,	1478,	16763,	1479,	16798,	3976,	16805,	6780,	16808,	2615,	16867,	1480,	16742,	5733,	17452,	405,	16868,	6233,	16862,	10683,	16987,	11213,	16563,	8186,	16568,	6762,	16575,	12342,	16584,	16617,	6770,	16626,	172,	19514,	19512,	12012,	11348,	12498,	13264,	16461,	5010,	16494,	6671,	6669,	16508,	7515,	16995,	19701,	19699,	11797,	16639,	2470,	16567,	9429,	16573,	2117,	16999,	866,	16580,	637,	16608,	2916,	16614,	105,	16621,	89,	16650,	10550,	7834,	3181,	10080,	7803,	18234,	1708,	16048,	2194,	16054,	3158,	17038,	2640,	16068,	5589,	183,	16083,	5578,	11536,	16856,	11541,	16859,	3900,	16129,	2474,	16131,	2510,	17097,	2241,	16150,	7591,	16155,	2790,	16175,	11463,	16182,	2816,	16186,	5270,	16192,	182,	16194,	5581,	6115,	16360,	7830,	16702,	10565,	16712,	4278,	16719,	5566,	16740,	5346,	16770,	5882,	16774,	4280,	16807,	6675,	16811,	12761,	10694,	16831,	3913,	16849,	8554,	15601,	1390,	15610,	3192,	15618,	3194,	15622,	15642,	2553,	7712,	15648,	6054,	15651,	10605,	15655,	10538,	15657,	409,	15659,	2810,	15661,	2877,	15663,	3083,	16198,	633,	16322,	2415,	16324,	630,	16881,	5071,	17161,	631,	16884,	2812,	17523,	190,	16219,	201,	16224,	2662,	16235,	2859,	17514,	197,	16240,	198,	16244,	1164,	16233,	632,	16327,	11198,	16311,	18077,	16138,	2833,	2832,	6223,	16142,	7617,	7615,	16146,	4152,	16086,	12708,	16088,	16089,	7613,	7611,	16148,	5449,	17200,	16093,	411,	10803,	16154,	3268,	16163,	16112,	7691,	2599,	7685,	1384,	16120,	7687,	1386,	16125,	687,	16169,	16669,	2491,	16679,	1656,	2267,	16952,	16683,	977,	17507,	6929,	6931,	17508,	16954,	1550,	1553,	16955,	1551,	16701,	5769,	16703,	2543,	16717,	103,	16729,	509,	17020,	13413,	212,	16739,	14718,	17023,	43,	17027,	215,	16656,	10244,	16658,	4256,	16672,	11215,	17039,	214,	16705,	83,	16713,	3280,	16782,	221,	16824,	12817,	16412,	13521,	16436,	15967,	2144,	3226,	15876,	2730,	15948,	6726,	15887,	247,	15714,	724,	15723,	5437,	15894,	2140,	15900,	3099,	15907,	241,	15956,	543,	15799,	22,	15789,	2138,	15920,	544,	15820,	757,	15830,	2820,	15927,	654,	15932,	657,	15939,	10533,	15845,	2142,	15955,	15963,	9758]
  	codes.each do |code|
  	url = "http://www.valueresearchonline.com/funds/newsnapshot.asp?schemecode=#{code}"
  	url2 = "http://www.valueresearchonline.com/funds/fundperformance.asp?schemecode=#{code}"
  	url3 = "http://www.valueresearchonline.com/funds/portfoliovr.asp?schemecode=#{code}"
  	url4 = "http://www.valueresearchonline.com/funds/fundanalysis.asp?schemecode=#{code}"
  	
	doc = Nokogiri::HTML(open(url))
	doc2 = Nokogiri::HTML(open(url2))
	doc3 = Nokogiri::HTML(open(url3))
	doc4 = Nokogiri::HTML(open(url4))
	fund = Fund.new
	check = doc.css("#fundHead tr:nth-child(2) td")[1].text.strip.delete(',')[/(\d+\.\d+)/].to_f
	if check == nil 
		check=0.0
	end
	if check>=50
		fund.scheme_code = code
		fund.scheme_name = doc.at_css(".snapshot-fund-name").text.strip
		str = doc.at_css(".fund-type li:nth-child(1) , tr:nth-child(2) .head").text.strip
		if str.slice(0..(str.index(':'))) == 'Growth:'
			fund.growth_nav= doc.at_css(".fund-type li:nth-child(1) , tr:nth-child(2) .head").text.strip.delete(',')[/(\d+\.\d+)/]
			fund.dividend_nav= doc.at_css(".fund-type li:nth-child(2) , tr:nth-child(2) .head").text.strip.delete(',')[/(\d+\.\d+)/]
		end
		if str.slice(0..(str.index(':'))) == 'Dividend:'
			fund.dividend_nav= doc.at_css(".fund-type li:nth-child(1) , tr:nth-child(2) .head").text.strip.delete(',')[/(\d+\.\d+)/]
			fund.growth_nav= doc.at_css(".fund-type li:nth-child(2) , tr:nth-child(2) .head").text.strip.delete(',')[/(\d+\.\d+)/]
		end
		fund.launch_date=doc.css(".margin_top15px tr:nth-child(7) td")[1].text.strip
		fund.min_investment=doc.css(".margin_top15px tr:nth-child(2) td")[3].text.strip.delete(',')
		fund.exit_load=doc.css(".margin_top15px tr:nth-child(8) td")[3].text.strip
		fund.net_assets= doc.css("#fundHead tr:nth-child(2) td")[1].text.strip.delete(',')[/(\d+\.\d+)/]
		fund.category=  doc.css("#fundHead tr:nth-child(1) td")[1].text.strip
		fund.expense_ratio= doc.css("#fundHead tr:nth-child(3) td")[1].text.strip[/(\d+\.\d+)/]
		str2= doc.css(".margin_top15px tr:nth-child(3) td")[1].to_s
		index1= str2.index('SchColor_')
		if index1 == nil 
			fund.colour_code="-"
		else
			index2 = str2.index('">&nbsp;')
			fund.colour_code=str2.slice(index1+9,index2-index1-9)
				end
		fund.benchmark=doc.css(".margin_top15px tr:nth-child(2) td")[1].text.strip
		fund.min_sip_investment = doc.css(".margin_top15px tr:nth-child(4) td")[3].text.strip.delete(',')
		fund.min_sip_chqs=doc.css(".margin_top15px tr:nth-child(5) td")[3].text.strip.delete(',')
		fund.fund_ytd = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(2) td.align_right:nth-child(2)").text
		fund.fund_1month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(2) td.align_right:nth-child(3)").text
		fund.fund_3month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(2) td.align_right:nth-child(4)").text
		fund.fund_1year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(2) td.align_right:nth-child(5)").text
		fund.fund_3year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(2) td.align_right:nth-child(6)").text
		fund.fund_5year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(2) td.align_right:nth-child(7)").text
		fund.fund_10year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(2) td.align_right:nth-child(8)").text
		fund.benchmark_ytd = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(3) td.align_right:nth-child(2)").text
		fund.benchmark_1month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(3) td.align_right:nth-child(3)").text
		fund.benchmark_3month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(3) td.align_right:nth-child(4)").text
		fund.benchmark_1year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(3) td.align_right:nth-child(5)").text
		fund.benchmark_3year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(3) td.align_right:nth-child(6)").text
		fund.benchmark_5year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(3) td.align_right:nth-child(7)").text
		fund.benchmark_10year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(3) td.align_right:nth-child(8)").text
		fund.category_ytd = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(4) td.align_right:nth-child(2)").text
		fund.category_1month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(4) td.align_right:nth-child(3)").text
		fund.category_3month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(4) td.align_right:nth-child(4)").text
		fund.category_1year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(4) td.align_right:nth-child(5)").text
		fund.category_3year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(4) td.align_right:nth-child(6)").text
		fund.category_5year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(4) td.align_right:nth-child(7)").text
		fund.category_10year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(4) td.align_right:nth-child(8)").text
		fund.rank_ytd = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(5) td.align_right:nth-child(2)").text
		fund.rank_1month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(5) td.align_right:nth-child(3)").text
		fund.rank_3month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(5) td.align_right:nth-child(4)").text
		fund.rank_1year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(5) td.align_right:nth-child(5)").text
		fund.rank_3year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(5) td.align_right:nth-child(6)").text
		fund.rank_5year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(5) td.align_right:nth-child(7)").text
		fund.rank_10year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(5) td.align_right:nth-child(8)").text
		fund.no_of_fund_ytd = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(6) td.align_right:nth-child(2)").text
		fund.no_of_fund_1month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(6) td.align_right:nth-child(3)").text
		fund.no_of_fund_3month = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(6) td.align_right:nth-child(4)").text
		fund.no_of_fund_1year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(6) td.align_right:nth-child(5)").text
		fund.no_of_fund_3year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(6) td.align_right:nth-child(6)").text
		fund.no_of_fund_5year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(6) td.align_right:nth-child(7)").text
		fund.no_of_fund_10year = doc.at_css(".sectionMainHead+ .sectionHead tr:nth-child(6) td.align_right:nth-child(8)").text
		fund.trailing_returns_date = doc.at_css(".sectionMainHead+ .sectionHead .footnote").text.sub('As on ','')



		if doc2.at_css(".margin_top15px+ .margin_top15px span").text == 'Risk Measures (%)'
		fund.fund_mean = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(2) .align_right:nth-child(2)").text
		fund.fund_stddev = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(2) .align_right:nth-child(3)").text
		fund.fund_sharpe = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(2) .align_right:nth-child(4)").text
		fund.fund_sortino = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(2) .align_right:nth-child(5)").text
		fund.fund_beta = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(2) .align_right:nth-child(6)").text
		fund.fund_alpha = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(2) .align_right:nth-child(7)").text
		fund.benchmark_mean = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(3) .align_right:nth-child(2)").text
		fund.benchmark_stddev = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(3) .align_right:nth-child(3)").text
		fund.benchmark_sharpe = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(3) .align_right:nth-child(4)").text
		fund.benchmark_sortino = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(3) .align_right:nth-child(5)").text
		fund.benchmark_beta = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(3) .align_right:nth-child(6)").text
		fund.benchmark_alpha = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(3) .align_right:nth-child(7)").text
		fund.category_mean = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(4) .align_right:nth-child(2)").text
		fund.category_stddev = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(4) .align_right:nth-child(3)").text
		fund.category_sharpe = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(4) .align_right:nth-child(4)").text
		fund.category_sortino = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(4) .align_right:nth-child(5)").text
		fund.category_beta = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(4) .align_right:nth-child(6)").text
		fund.category_alpha = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(4) .align_right:nth-child(7)").text
		fund.rank_mean = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(5) .align_right:nth-child(2)").text
		fund.rank_stddev = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(5) .align_right:nth-child(3)").text
		fund.rank_sharpe = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(5) .align_right:nth-child(4)").text
		fund.rank_sortino = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(5) .align_right:nth-child(5)").text
		fund.rank_beta = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(5) .align_right:nth-child(6)").text
		fund.rank_alpha = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(5) .align_right:nth-child(7)").text
		fund.no_of_fund_mean = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(6) .align_right:nth-child(2)").text
		fund.no_of_fund_stddev = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(6) .align_right:nth-child(3)").text
		fund.no_of_fund_sharpe = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(6) .align_right:nth-child(4)").text
		fund.no_of_fund_sortino = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(6) .align_right:nth-child(5)").text
		fund.no_of_fund_beta = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(6) .align_right:nth-child(6)").text
		fund.no_of_fund_alpha = doc2.at_css(".margin_top15px:nth-child(11) tr:nth-child(6) .align_right:nth-child(7)").text
		fund.risk_measure_date = doc2.at_css(".margin_top15px:nth-child(11) .footnote").text.sub('As on ','')
		end

		if doc3.at_css(".pull-right td").text.strip== 'The underlying data is not available.'
			fund.no_of_stocks = ""
			fund.top_10 = 0
			fund.top_5 = 0
			fund.top_3_sectors = 0
			fund.portfolio_pb_ratio = 0
			fund.portfolio_pe_ratio = 0
		else
			fund.no_of_stocks = doc3.css(".pull-right .align_right")[0].text
			fund.top_10 = doc3.css(".pull-right .align_right")[1].text
			fund.top_5 = doc3.css(".pull-right .align_right")[2].text
			fund.top_3_sectors = doc3.css(".pull-right .align_right")[3].text
			fund.portfolio_pb_ratio = doc3.css(".pull-right .align_right")[4].text
			fund.portfolio_pe_ratio = doc3.css(".pull-right .align_right")[5].text
		end


		fund.holdings1_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(3) td:nth-child(1)").text.strip
		fund.holdings1_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(3) td:nth-child(2)").text.strip
		fund.holdings1_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(3) td:nth-child(3)").text.strip
		fund.holdings1_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(3) td:nth-child(6)").text.strip
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(4) td:nth-child(1)")!= nil
		fund.holdings2_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(4) td:nth-child(1)").text.strip
		fund.holdings2_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(4) td:nth-child(2)").text.strip
		fund.holdings2_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(4) td:nth-child(3)").text.strip
		fund.holdings2_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(4) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(5) td:nth-child(1)")!= nil
		fund.holdings3_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(5) td:nth-child(1)").text.strip
		fund.holdings3_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(5) td:nth-child(2)").text.strip
		fund.holdings3_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(5) td:nth-child(3)").text.strip
		fund.holdings3_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(5) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(6) td:nth-child(1)")!= nil
		fund.holdings4_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(6) td:nth-child(1)").text.strip
		fund.holdings4_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(6) td:nth-child(2)").text.strip
		fund.holdings4_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(6) td:nth-child(3)").text.strip
		fund.holdings4_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(6) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(7) td:nth-child(1)")!= nil
		fund.holdings5_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(7) td:nth-child(1)").text.strip
		fund.holdings5_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(7) td:nth-child(2)").text.strip
		fund.holdings5_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(7) td:nth-child(3)").text.strip
		fund.holdings5_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(7) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(8) td:nth-child(1)")!= nil
		fund.holdings6_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(8) td:nth-child(1)").text.strip
		fund.holdings6_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(8) td:nth-child(2)").text.strip
		fund.holdings6_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(8) td:nth-child(3)").text.strip
		fund.holdings6_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(8) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(9) td:nth-child(1)")!= nil
		fund.holdings7_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(9) td:nth-child(1)").text.strip
		fund.holdings7_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(9) td:nth-child(2)").text.strip
		fund.holdings7_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(9) td:nth-child(3)").text.strip
		fund.holdings7_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(9) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(10) td:nth-child(1)")!= nil
		fund.holdings8_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(10) td:nth-child(1)").text.strip
		fund.holdings8_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(10) td:nth-child(2)").text.strip
		fund.holdings8_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(10) td:nth-child(3)").text.strip
		fund.holdings8_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(10) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(11) td:nth-child(1)")!= nil
		fund.holdings9_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(11) td:nth-child(1)").text.strip
		fund.holdings9_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(11) td:nth-child(2)").text.strip
		fund.holdings9_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(11) td:nth-child(3)").text.strip
		fund.holdings9_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(11) td:nth-child(6)").text.strip
		end
		if doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(12) td:nth-child(1)")!= nil
		fund.holdings10_company = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(12) td:nth-child(1)").text.strip
		fund.holdings10_sector = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(12) td:nth-child(2)").text.strip
		fund.holdings10_pe = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(12) td:nth-child(3)").text.strip
		fund.holdings10_asset = doc3.at_css(".margin_top15px+ .margin_top15px tr:nth-child(12) td:nth-child(6)").text.strip
		end

		if doc4.at_css(".margin_top_none+ .analysis_dec")!=nil
		fund.investment_objective =  doc4.at_css(".margin_top_none+ .analysis_dec").text.strip
		end
		if doc4.at_css(".analysis_dec~ .analysis_dec")!=nil
		fund.fund_manager =  doc4.at_css(".analysis_dec~ .analysis_dec").text.strip
		end


		fund.save
	end
	end




  end
end