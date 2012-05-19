class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :user_identity, type: String
  field :votes_count, type: Integer
  has_many :votes

  index :user_identity, unique: true

  public
  def vote_id(say_id, value)
    vote = votes.where(say_id: say_id).first
    return unless vote && vote.flag?(value)
    vote.id
  end

  def vote(say_id)
    votes.where(say_id: say_id).first
  end

  def voted?(say_id, flag)
    v = vote(say_id)
    (v && v.flag?(flag)) == true
  end
end
