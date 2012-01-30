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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @screen }
    end
  end

  # GET /screens/1/edit
  def edit
    @screen = Screen.find(params[:id])
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
    clone = @screen.clone
    clone.title = 'Cloned ' + clone.title
    clone.id = nil
    clone.position = nil
    clone.insert_at(@screen.position + 1) 
    clone.save
    @screen.items.each do |item|
      clone_item = item.clone
      clone_item.id = nil
      clone_item.screen_id = clone.id
      clone_item.user_id = current_user.id
      clone_item.save
    end
    redirect_to(clone, :notice => 'Screen was successfully cloned.')
  end

  # PUT /screens/1
  # PUT /screens/1.xml
  def update
    @screen = Screen.find(params[:id])

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
    @topic = @screen.topic
    @screen.destroy

    respond_to do |format|
      format.html { redirect_to(navigate_path(@topic)) }
      format.xml  { head :ok }
    end
  end
end
