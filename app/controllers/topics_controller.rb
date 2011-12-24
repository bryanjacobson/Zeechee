class TopicsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  # GET /topics
  # GET /topics.xml
  def index
    if params[:id]
      @topic =  Topic.find(params[:id])
      @topics = @topic.children
    else
      @topics = Topic.roots
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])
    @parent = @topic.parent
    @children = @topic.children

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new(:parent_id => params[:parent_id])
    if params[:parent_id]
      @parent = Topic.find(params[:parent_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params[:topic])
    @topic.user_id = current_user.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to(navigate_path(@topic), :notice => 'Topic was successfully created.') }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    @up = params[:up]
    if @up == "1"
      @topic.parent = @topic.parent.parent
    end

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(navigate_path(@topic), :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end
end
