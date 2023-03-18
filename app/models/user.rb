class User < ApplicationRecord
  has_many :accounts, dependent: :nullify

  validates :first_name, :last_name, :patronymic, :phone, :email, :password, presence: true
  validates :email, :phone, uniqueness: true

  class << self
    def bank
      find_by(first_name: "K.O. Bank", last_name: "*", patronymic: "*")
    end
  end

  def full_name
    "#{last_name} #{first_name} #{patronymic}"
  end
end
