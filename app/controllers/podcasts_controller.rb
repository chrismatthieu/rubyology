class PodcastsController < ApplicationController

  before_filter :current_user  

  # GET /podcasts
  # GET /podcasts.json
  def index
    # @podcasts = Podcast.order("created_at DESC")
    # @podcasts = Podcast.all :page => params[:page], :order => 'created_at DESC'
    @podcasts = Podcast.paginate :page => params[:page], :per_page => 3, :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @podcasts }
    end
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
    @podcast = Podcast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @podcast }
    end
  end

  # GET /podcasts/new
  # GET /podcasts/new.json
  def new
    @podcast = Podcast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @podcast }
    end
  end

  # GET /podcasts/1/edit
  def edit
    @podcast = Podcast.find(params[:id])
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(params[:podcast])

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to @podcast, :notice => 'Podcast was successfully created.' }
        format.json { render :json => @podcast, :status => :created, :location => @podcast }
      else
        format.html { render :action => "new" }
        format.json { render :json => @podcast.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /podcasts/1
  # PUT /podcasts/1.json
  def update
    @podcast = Podcast.find(params[:id])

    respond_to do |format|
      if @podcast.update_attributes(params[:podcast])
        format.html { redirect_to @podcast, :notice => 'Podcast was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @podcast.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :ok }
    end
  end
  
  def search
    @keywords = "%" + params[:keywords] + "%"
    if request.url.index('localhost')
      conditions = ["poddesc LIKE ? or podname LIKE ?", @keywords, @keywords] unless @keywords == ""
    else
      conditions = ["poddesc ILIKE ? or podname ILIKE ?", @keywords, @keywords] unless @keywords == ""
    end
    # @podcasts = Podcast.find(:all, :conditions => conditions, :order => 'created_at desc')
    @podcasts = Podcast.paginate :page => params[:page], :per_page => 3, :order => 'created_at DESC', :conditions => conditions
    
    render :action => 'index'    
  end
  
  def rss
    #@headers["Content-Type"] = "application/xml" 
    #@podcasts = Podcast.find(:all, :order => "timestamp desc")
    #render :layout => false
    
    redirect_to 'http://feeds.feedburner.com/rubyology'
    
  end

  def rssreal
    # @headers["Content-Type"] = "application/xml" 
    
    @podcasts = Podcast.find(:all, :order => "created_at desc")
    render :action => 'rss', :content_type => "application/xml", :layout => false 
    
  end
  
  
  
end
