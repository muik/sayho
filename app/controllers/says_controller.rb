class SaysController < ApplicationController
  # GET /says
  # GET /says.json
  def index
    if params[:type]
      case params[:type].to_sym
        when :popular
          @says = Say.popular
        when :recent
          @says = Say.recent
        when :my_popular
          @says = current_user.says.popular
        when :my_recent
          @says = current_user.says.recent
        else
          return render text: 'Not Found', status: 404
      end
      @says = @says.page(params[:page]).per(params[:per_page])
    else
      @popular_says = Say.popular.limit(20)
      @recent_says = Say.recent.limit(20)
      @my_popular_says = current_user.says.popular.limit(20)
      @my_recent_says = current_user.says.recent.limit(20)
    end

    respond_to do |format|
      format.html # index.html.erb
#      format.json { render json: @says }
    end
  end

  # GET /says/1
  # GET /says/1.json
  def show
    @say = Say.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @say }
    end
  end

  # GET /says/new
  # GET /says/new.json
  def new
    @say = Say.new
    @say.nickname = @saved_nickname

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @say }
    end
  end

  # GET /says/1/edit
  def edit
    @say = Say.find(params[:id])
  end

  # POST /says
  # POST /says.json
  def create
    @say = Say.new(params[:say])
    @say.user_id = current_user.id
    @say.before_say_id = params[:say_id] if params[:say_id]
    save_nickname(@say.nickname)
    location = (@say.before_say or @say)

    respond_to do |format|
      if @say.save
        format.html { redirect_to location, notice: 'Say was successfully created.' }
        format.json { render json: @say, status: :created, location: @say }
      else
        format.html { render action: "new" }
        format.json { render json: @say.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_nickname(value)
    cookies[:nickname] = {
      value: value,
      expires: 1.year.from_now,
    }
  end

  # PUT /says/1
  # PUT /says/1.json
  def update
    return
    @say = Say.find(params[:id])

    respond_to do |format|
      if @say.update_attributes(params[:say])
        format.html { redirect_to @say, notice: 'Say was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @say.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /says/1
  # DELETE /says/1.json
  def destroy
    @say = Say.find(params[:id])
    @say.destroy

    respond_to do |format|
      format.html { redirect_to says_url }
      format.json { head :no_content }
    end
  end
end
