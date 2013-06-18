class Key < ActiveRecord::Base
  attr_accessible :key, :title, :user_id
  belongs_to :user
  validates :title, presence: true, length: { within: 0..255 }
  validates :key, presence: true, length: { within: 0..5000 }, format: { :with => /ssh-.{3} / }, uniqueness: true
  def fingerprint
    begin
      file = Tempfile.new('key_file')
      file.puts key
      file.rewind
      `ssh-keygen -lf #{file.path} 2>&1`
    ensure
      file.close
      file.unlink # deletes the temp file
    end
  end
end
