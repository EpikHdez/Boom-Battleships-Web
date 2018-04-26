class Match < ApplicationRecord
  belongs_to :user
  belongs_to :rival, class_name: 'User'

  after_create :create_inverse

  private

  def create_inverse
    self.class.create(turn: false, user_id: self.rival_id, rival_id: self.user_id, game_number: self.game_number)
  end

  validates_uniqueness_of :game_number, scope: [:user_id, :rival_id]
end
