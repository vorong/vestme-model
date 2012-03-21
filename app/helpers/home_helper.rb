module HomeHelper
  def get_weekly(symbol)
  	count = 0;
  	quotes = Array.new

  	YahooFinance::get_historical_quotes(symbol, 
  	                                    Date.parse('2006-10-20'), 
  	                                    Date.today()) do |row|
  		if count == 1
  			quotes.push Float(row[4])
  			count += 1
			elsif count == 4
			  count = 0
  		else
  			count += 1
  		end
  	end

    quotes.reverse
  end
  
  def get_equal_weighting_returns(symbols)
    all_quotes = Array.new
    
    # Get historical quotes for each symbol
    symbols.each do |symbol|
    	quotes = get_weekly(symbol)
    	all_quotes.push quotes
    end

    # Safety check to ensure each symbol has same number of quotes
    all_quotes.each do |quotes|
    	if quotes.count != all_quotes[0].count
    		raise 'Error: all of the symbols must have same number of quotes.' 
    	end
    end

    # Loop through each all quotes and append combined return to output array
    # starting with $100.00
    i = 1
    j = 0
    returns = Array.new
    returns.push 100.0

    while i < all_quotes[0].count
    	total_returns = Array.new
    	percent_returns = Array.new
    	weighted_returns = Array.new
    	combined_return = 0.0

    	while j < all_quotes.count
    		total_returns.push all_quotes[j][i] - all_quotes[j][i - 1]
    		percent_returns.push total_returns[j] / all_quotes[j][i - 1]
    		j += 1
    	end
      
      weighted_returns = percent_returns.map {|x| x / all_quotes.count}
      combined_return = weighted_returns.inject {|sum, x| sum + x}

    	returns.push (1 + combined_return) * returns[i - 1]

    	i += 1
    	j = 0
    end
    
    returns
  end
end
