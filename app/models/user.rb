class User < ApplicationRecord
  belongs_to :table
  def email_required?
    false
  end
  def password_required?
    false
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
