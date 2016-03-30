class Article < ActiveRecord::Base
  belongs_to :user

  scope :authored_by, ->(username) { where(user: User.where(username: username)) }

  validates :title, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
  validates :slug, uniqueness: true, exclusion: { in: ['feed'] }

  before_validation do
    self.slug = self.title.to_s.parameterize
  end
end
