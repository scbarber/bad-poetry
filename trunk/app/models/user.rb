class User < ActiveRecord::Base
  has_many :votes
  has_many :poems
  validates_uniqueness_of :username
  
  def voted_on?(poem_id)
    voted = nil
    self.votes.each { |vote| voted = true if vote.poem.id == poem_id }
    voted
  end
end
