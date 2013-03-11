class Resume < ActiveRecord::Base
  attr_accessible :content, :user
  belongs_to :user

  def content_html
    PandocRuby.convert(content, :from => :markdown, :to => :html)
  end
end
