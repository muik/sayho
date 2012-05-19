class Say
  include Mongoid::Document
  include Mongoid::Timestamps
  field :nickname, :type => String
  field :text, :type => String
  field :point, :type => Integer, default: 0
  field :up_votes_count, :type => Integer
  field :down_votes_count, :type => Integer
  field :after_says_count, :type => Integer
  belongs_to :before_say, class_name: 'Say'
  has_many :votes
  validates_presence_of :nickname, :text
  scope :popular, order_by(:point, :desc).order_by(:created_at, :desc)
  scope :after_popular, order_by(:point, :desc).order_by(:created_at, :asc)
  scope :begin, where(before_say_id: nil)
  before_create :inc_after_says_count

  index [
    [:point, Mongo::DESCENDING],
    [:created_at, Mongo::DESCENDING],
  ]

  public
  def before_says
    return [] unless before_say
    says = before_say.before_says
    says += [before_say] if before_say
  end

  def after_says
    Say.where(before_say_id: id)
  end

  protected
  def inc_after_says_count
    before_say.inc(:after_says_count, 1) if before_say
  end
end
