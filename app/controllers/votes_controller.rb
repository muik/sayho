class VotesController < ApplicationController
  # POST /says
  # POST /says.json
  def create
    user = User.find_or_create_by(user_identity: current_user_identity)
    say = Say.find(params[:say_id])

    respond_to do |format|
      if user.vote(say, params[:value])
        format.json { render json: user.vote_value(say), status: :created }
      else
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  # PUT /says/1
  # PUT /says/1.json
  def update
    user = User.find_or_create_by(user_identity: current_user_identity)
    say = Say.find(params[:say_id])

    respond_to do |format|
      if user.vote(say, params[:value])
        format.json { render json: user.vote_value(say) }
      else
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /says/1
  # DELETE /says/1.json
  def destroy
    user = User.find_or_create_by(user_identity: current_user_identity)
    say = Say.find(params[:say_id])

    respond_to do |format|
      if user.unvote(say)
        format.json { render json: user.vote_value(say) }
      else
        format.json { render json: user.vote_value(say) }
      end
    end
  end
end
