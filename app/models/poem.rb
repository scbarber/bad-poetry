class BlogRequest

  attr_accessor :protocol, :host_with_port, :path, :symbolized_path_parameters, :relative_url_root

  def initialize(root)
    @protocol = @host_with_port = @path = ''
    @symbolized_path_parameters = {}
    @relative_url_root = root.gsub(%r{/^},'')
  end
end


class Poem < ActiveRecord::Base

  has_many :votes
  belongs_to :user
  acts_as_taggable

  def self.per_page
    15
  end

  def get_permalink
    #TODO : the url doesn't belong in the model, but it's late

    options = { :controller => 'view', :action => 'poem', :id => id }
    @url = ActionController::UrlRewriter.new(BlogRequest.new($base_url), {})
    @url.rewrite(options)
  end

  def score
    score = 0
    self.votes.each { |vote| score = score + vote.points }
    score
  end
end
