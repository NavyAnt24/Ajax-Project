class Friendship < ActiveRecord::Base
  attr_accessible :friendship_maker_id, :friendship_recipient_id

  validates :friendship_maker_id, :friendship_recipient_id, :presence => true

  validates :friendship_recipient_id, :uniqueness  => { :scope => :friendship_maker_id }

  # before_validation(on: :create) do
  #   friendship = Friendship.where("friendship_maker_id = ? AND friendship_recipient_id = ?", self.friendship_maker_id, self.friendship_recipient_id)
  #
  #   if !friendship.nil?
  #     errors.add(:friendship_recipient_id, "This friendship already exists.")
  #   end
  # end

  belongs_to(
  :friendship_maker,
  :class_name => 'User',
  :foreign_key => :friendship_maker_id
  )

  belongs_to(
  :friendship_recipient,
  :class_name => 'User',
  :foreign_key => :friendship_recipient_id
  )

end
