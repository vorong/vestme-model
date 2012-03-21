class HomeController < ApplicationController  
  def index
    @all_symbols = [ 'SPY', 'EFA', 'IEF', 'FXF', 
      'IWM', 'EEM', 'TLT', 'IYM', 'IYR', 'GLD' ]
    @default_symbols = [ 'SPY', 'EFA', 'IEF', 'FXF' ]    
  end
end