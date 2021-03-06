# Copyright 2012 Bryan Lee Jacobson
class ItemsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  # GET /items
  # GET /items.xml
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    if !@item.authorized?(current_user)
      redirect_to(@item.screen, :notice =>
        'Permission denied: You can only update your own Items.')
      return
    end
    @body_rows = 6
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    @item.user_id = current_user.id

    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item.screen, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def up
    @item = Item.find(params[:id])
    @item.move_higher
    @item.save
    redirect_to(@item.screen)
  end

  def down
    @item = Item.find(params[:id])
    @item.move_lower
    @item.save
    redirect_to(@item.screen)
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])
    if !@item.authorized?(current_user)
      redirect_to(@item.screen, :notice =>
        'Permission denied: You can only update your own Items.')
      return
    end

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item.screen, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    if !@item.authorized?(current_user)
      redirect_to(@item.screen, :notice =>
        'Permission denied: You can only delete your own Items.')
      return
    end
    @screen = @item.screen
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(@screen) }
      format.xml  { head :ok }
    end
  end
end
