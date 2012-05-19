class SaysController < ApplicationController
  # GET /says
  # GET /says.json
  def index
    @says = Say.begin.popular

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @says }
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
    @say.before_say_id = params[:say_id] if params[:say_id]
    save_nickname(@say.nickname)

    respond_to do |format|
      if @say.save
        format.html { redirect_to @say, notice: 'Say was successfully created.' }
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

  def votes
    user = current_user
    say = Say.find(params[:id])
    result = user.vote(say, params[:value])
    unless result
      result = user.voted?(say) && user.vote_value(say).to_s == params[:value]
    end

    respond_to do |format|
      if result
        format.json { render json: true, status: :created }
      else
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  def destroy_vote
    user = current_user
    say = Say.find(params[:id])
    user.unvote(say)
    
    respond_to do |format|
      if user.voted?(say) == false
        format.json { render json: true, status: :created }
      else
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  # PUT /says/1
  # PUT /says/1.json
  def update
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
