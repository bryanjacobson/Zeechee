class ContentsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  # GET /contents
  # GET /contents.xml
  def index
    if params[:topic_id]
      @topic = Topic.find(params[:topic_id]) if params[:topic_id]
    else
      @topic = Topic.first
    end

    if @topic 
      @contents = @topic.contents
    else
      redirect_to topics_path
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Content.find(params[:id])
    @item = Item.new
    @item.content_id = @content.id

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Content.new
    if params[:topic_id]
      @topic = Topic.find(params[:topic_id]) if params[:topic_id]
      @content.topic_id = @topic.id
      @content.user_id = current_user.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  def edit
    @content = Content.find(params[:id])
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Content.new(params[:content])
    @content.user_id = current_user.id

    respond_to do |format|
      if @content.save
        format.html { redirect_to(contents_path(:topic_id => @content.topic_id), :notice => 'Content was successfully created.') }
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  def up
    @content = Content.find(params[:id])
    @content.move_higher
    @content.save
    redirect_to(contents_path(:topic_id => @content.topic_id))
  end

  def down
    @content = Content.find(params[:id])
    @content.move_lower
    @content.save
    redirect_to(contents_path(:topic_id => @content.topic_id))
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    @content = Content.find(params[:id])

    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to(@content, :notice => 'Content was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(contents_url) }
      format.xml  { head :ok }
    end
  end
end
