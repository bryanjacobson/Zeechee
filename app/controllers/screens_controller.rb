# Copyright 2012 Bryan Lee Jacobson
class ScreensController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  # GET /screens
  # GET /screens.xml
  def index
    @screens = Screen.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @screens }
    end
  end

  # GET /screens/1
  # GET /screens/1.xml
  def show
    @screen = Screen.find(params[:id])
    @comment = @screen.comments.new
    @item = Item.new
    @item.screen_id = @screen.id
    @item.style = "color:navy;font-size:22px;line-height:22px;"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @screen }
    end
  end

  # GET /screens/new
  # GET /screens/new.xml
  def new
    @screen = Screen.new
    @screen.topic_id = params[:topic_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @screen }
    end
  end

  # GET /screens/1/edit
  def edit
    @screen = Screen.find(params[:id])
    if !@screen.authorized?(current_user)
      redirect_to(@screen,
        :notice => 'Permission denied: You can only edit your own Screens.')
      return    
    end
  end

  # POST /screens
  # POST /screens.xml
  def create
    @screen = Screen.new(params[:screen])
    @screen.user_id = current_user.id

    respond_to do |format|
      if @screen.save
        format.html { redirect_to(navigate_path(@screen.topic_id), :notice => 'Screen was successfully created.') }
        format.xml  { render :xml => @screen, :status => :created, :location => @screen }
      else
        format.html { redirect_to(navigate_path(@screen.topic_id), :notice => 'Error in Screen creation.') }
        format.html { render :action => "new" }
        format.xml  { render :xml => @screen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def up
    @screen = Screen.find(params[:id])
    @screen.move_higher
    @screen.save
    redirect_to(navigate_path(@screen.topic))
  end

  def down 
    @screen = Screen.find(params[:id])
    @screen.move_lower
    @screen.save
    redirect_to(navigate_path(@screen.topic))
  end

  def clone
    @screen = Screen.find(params[:id])
    clone = Screen.new
    clone.title = 'Cloned ' + @screen.title
    clone.user = current_user
    clone.topic = @screen.topic
    clone.save
    clone.insert_at(@screen.position + 1) 
    @screen.items.each do |item|
      clone_item = Item.new
      clone_item.item_type_id = item.item_type_id
      clone_item.screen_id = clone.id
      clone_item.position = item.position
      clone_item.body = item.body
      clone_item.style = item.style
      clone_item.size = item.size
      clone_item.note = item.note
      clone_item.user_id = current_user.id
      clone_item.save
    end
    redirect_to(clone, :notice => 'Screen was successfully cloned.')
  end

  # PUT /screens/1
  # PUT /screens/1.xml
  def update
    @screen = Screen.find(params[:id])
    if !@screen.authorized?(current_user)
      redirect_to(@screen,
        :notice => 'Permission denied: You can only update your own Screens.')
      return    
    end

    respond_to do |format|
      if @screen.update_attributes(params[:screen])
        format.html { redirect_to(@screen, :notice => 'Screen was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @screen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /screens/1
  # DELETE /screens/1.xml
  def destroy
    @screen = Screen.find(params[:id])
    if !@screen.authorized?(current_user)
      redirect_to(@screen,
        :notice => 'Permission denied: You can only delete your own Screens.')
      return    
    end
    @topic = @screen.topic
    @screen.destroy

    respond_to do |format|
      format.html { redirect_to(navigate_path(@topic)) }
      format.xml  { head :ok }
    end
  end
end
