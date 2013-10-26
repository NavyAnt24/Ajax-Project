class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password

  has_many(
    :authored_secrets,
    :class_name => "Secret",
    :foreign_key => :author_id
  )

  has_many(
    :received_secrets,
    :class_name => "Secret",
    :foreign_key => :recipient_id
  )

#   has_many :in_friends, :class_name => "Friendship", :foreign_key => :friendship_maker_id
#   has_many :out_friends, :class_name => "Friendship", :foreign_key => :friendship_recipient_id
#   # in-friends/followers
#   has_many :friendship_makers, :through => :in_friends, :source => :friendship_maker
# #   # out-friends/following
#   has_many :friendship_recipients, :through => :out_friends, :source => :friendship_recipient

  has_many(
  :friendships_made,
  :class_name => 'Friendship',
  :foreign_key => :friendship_maker_id
  )

  has_many(
  :friendships_received,
  :class_name => 'Friendship',
  :foreign_key => :friendship_maker_id
  )

  has_many :friendship_makers, :through => :friendships_received
  has_many :friendship_recipients, :through => :friendships_made

  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true
  validates :username, :presence => true

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
