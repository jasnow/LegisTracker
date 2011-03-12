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
    
    if current_user
      saved = current_user.tag( @bill, :with => "hot", :on => :hot )
    else
      @bill.hot_list.add( 'hot' )
      saved = @bill.save
    end
    
    if saved
      flash[:notice] = "Bill successfully added to the watch list"
    else
      flash[:error] = "Tagging failed"
    end
    redirect_to( @bill )
  end
  
  def unhot
    @bill = Bill.find( params[:id] )
    @bill.hot_list.remove( 'hot' )
    if @bill.save
      flash[:notice] = "Bill successfully removed to watch list"
    else
      flas[:error] = "Tagging fails"
    end
    redirect_to( @bill )
  end
  
  def add_tag
    @bill = Bill.find( params[:id] )
    @bill.tag_list_on( params[:context].to_sym ).add( params[:tag] )
    if @bill.save
      flash[:notice] = "Bill successfully tagged with topic"
    else
      flash[:error] = "Tagging failed"
    end
    redirect_to( @bill )
  end
end
