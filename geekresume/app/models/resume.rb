# Модель представляющая резюме. Принадлежит пользователю.
# Обаладает свойством название, которое должно быть уникально в рамках
# одного пользователя.
# После создания нового резюме создается пустой гит репозиторий
class Resume < ActiveRecord::Base
  attr_accessible :title, :user
  belongs_to :user
  validates :title, presence: true,
                    uniqueness: { scope: :user_id }

  after_create :init_bare_repo

  def content_html
    PandocRuby.convert(content, :from => :markdown, :to => :html)
  end

  def namespace
    @namespace ||= "artkey/#{title.parameterize}"
  end

  def path_to_repo
    @path_to_repo ||= File.join(Settings.repos_path, "#{namespace}.git")
  end

  def repo
    @repo ||= Grit::Repo.new path_to_repo
  end

  private

  def init_bare_repo
    Grit::Repo.init_bare path_to_repo
  end

end
