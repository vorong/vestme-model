class HomeController < ApplicationController  
  def index
    @all_symbols = [ 'SPY', 'EFA', 'IEF', 'TIP', 
      'IWM', 'EEM', 'TLT', 'IYM', 'IYR', 'GLD', 'FXF' ]
    @default_symbols = [ 'SPY', 'EFA', 'IEF', 'TIP' ]    
  end
end