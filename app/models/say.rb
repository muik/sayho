class Say
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongo::Voteable
  voteable self, up: 1, down: -2
  field :nickname, :type => String
  field :text, :type => String
  belongs_to :before_say, class_name: 'Say'
  validates_presence_of :nickname, :text

  public
  def before_says
    return [] unless before_say
    says = before_say.before_says
    says += [before_say] if before_say
  end

  def after_says
    Say.where(before_say_id: id)
  end
end
