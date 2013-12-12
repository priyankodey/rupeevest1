require 'rubygems' 
require 'bundler/setup'
require 'open-uri'

namespace :db do
  desc "fill fund database"
  task :populatefund => :environment do
  	codes =[32,590,24,3001,10099,10097,59,3985,3126,10125,818,601,854,3927,640,20681,10032,2127,6679,10095,2937,3112,2920,
  		    405,105,89,2816,3913,409,198,687,212,83,724,915]
  	codes.each do |code|
  	url = "http://www.valueresearchonline.com/funds/newsnapshot.asp?schemecode=#{code}"
  	url2 = "http://www.valueresearchonline.com/funds/fundperformance.asp?schemecode=#{code}"
  	url3 = "http://www.valueresearchonline.com/funds/portfoliovr.asp?schemecode=#{code}"
  	url4 = "http://www.valueresearchonline.com/funds/fundanalysis.asp?schemecode=#{code}"
  	
	doc = Nokogiri::HTML(open(url))
	doc2 = Nokogiri::HTML(open(url2))
	doc3 = Nokogiri::HTML(open(url3))
	doc4 = Nokogiri::HTML(open(url4))
	
	fund = Fund.find_by_scheme_code(code)
	check = doc.css("#fundHead tr:nth-child(2) td")[1].text.delete(',').delete('R').strip[/^[^\d]*(\d+)/].to_f
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
		
		fund.min_investment=doc.css(".margin_top15px tr:nth-child(2) td")[3].text.strip.delete(',')
		fund.exit_load=doc.css(".margin_top15px tr:nth-child(8) td")[3].text.strip
		fund.net_assets= doc.css("#fundHead tr:nth-child(2) td")[1].text.delete(',').delete('R').strip[/^[^\d]*(\d+)/].to_f
		fund.category=  'ELSS'
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

		puts "1"
		fund.save
	end
	end




  end
end
