class BillsController < ApplicationController
  def index
    @title = 'Search results'
    @bills = @search.all
  end

  def show
    @bill = Bill.find(params[:id])
    @title = @bill.number
  end

  def search
    @title = "Advanced Search"
  end
  
  def hot
    @bill = Bill.find( params[:id] )
    @bill.hot_list.add( 'hot' )
    if @bill.save
      flash[:notice] = "Bill successfully tagged as hot"
    else
      flash[:error] = "Tagging failed"
    end
    redirect_to( @bill )
  end
  
  def unhot
    @bill = Bill.find( params[:id] )
    @bill.hot_list.remove( 'hot' )
    if @bill.save
      flash[:notice] = "Bill successfully untagged as hot"
    else
      flas[:error] = "Untagging fails"
    end
    redirect_to( @bill )
  end
end
