class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  field :value, type: Integer
  belongs_to :user
  belongs_to :say
  after_create :inc_count
  after_update :update_count
  after_destroy :dec_count

  index [
    [:user_id, Mongo::ASCENDING],
    [:say_id, Mongo::ASCENDING],
  ], unique: true

  public
  def self.flag_value(name)
    name.to_sym == :up ? 1 : -1
  end

  def set_value(name)
    self.value = Vote.flag_value(name)
  end

  def flag?(name)
    (value > 0) == (name.to_sym == :up)
  end

  protected
  def inc_count(n=1)
    user.inc(:votes_count, n)
    field = value > 0 ? :up_votes_count : :down_votes_count
    say.inc(field, n)
    say.inc(:point, value * n)
  end

  def dec_count
    inc_count(-1)
  end

  def update_count
    if value_changed?
      n = value_was > value ? -1 : 1
      say.inc(:up_votes_count, n * 1)
      say.inc(:down_votes_count, n * -1)
      say.inc(:point, n * 2)
    end
  end
end
