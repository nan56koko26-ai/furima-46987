class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :first_name, presence: true
  validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々ー・]+\z/, message: 'must be in Zenkaku' }, allow_blank: true
  validates :last_name, presence: true
  validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々ー・]+\z/, message: 'must be in Zenkaku' }, allow_blank: true
  validates :first_name_kana, presence: true
  validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'must be in Katakana' }, allow_blank: true
  validates :last_name_kana, presence: true
  validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'must be in Katakana'}, allow_blank: true
  validates :birth_date, presence: true
  validates :password, format: { with: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+\z/, message: 'is not a mix of alphanumeric characters' }, if: -> { password.present? }
  
  has_many :items

end
