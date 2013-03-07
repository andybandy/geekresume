class Resume < ActiveRecord::Base
  attr_accessible :content

  def content_html
    PandocRuby.convert(content, :from => :markdown, :to => :html)
  end
end
