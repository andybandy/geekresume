# Модель представляющая резюме. Принадлежит пользователю.
# Обаладает свойством название, которое должно быть уникально в рамках
# одного пользователя.
# После создания нового резюме создается пустой гит репозиторий
# Resume#has_content? - проверяет есть ли файл с резюме в репе
# Resume#content_html - html формат резюме
class Resume < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true,
                    uniqueness: { scope: :user_id }

  after_create :init_bare_repo
  before_create :generate_checksum

  def content_html
    PandocRuby.convert(content, :from => :markdown, :to => :html)
  end

  delegate :username, to: :user

  def namespace
    @namespace ||= "#{username}/#{title.parameterize}"
  end

  def path_with_namespace
    namespace
  end

  def path_to_repo
    @path_to_repo ||= File.join(Settings.repos_path, "#{namespace}.git")
  end

  def repo
    @repo ||= Grit::Repo.new path_to_repo
  end

  def content
    (repo.tree / "resume.md").try(:data)
  end

  def has_content?
    content
  end

  private

  def init_bare_repo
    Grit::Repo.init_bare path_to_repo
  end

  def generate_checksum
    self.checksum = Digest::SHA1.hexdigest (Time.now.to_s + title.parameterize)
  end

end

class Repository

end
