class User
  include Mongoid::Document
  include Mongo::Voter
  field :user_identity, type: String
  index :user_identity, unique: true
end
