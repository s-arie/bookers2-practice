class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :books, dependent: :destroy

  # バリデーション
  validates :name, presence:true, length:{minimum:2, maximum:20}, uniqueness:true
  validates :introduction, presence:true, length:{maximum:50}
end
