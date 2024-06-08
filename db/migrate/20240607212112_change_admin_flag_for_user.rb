class ChangeAdminFlagForUser < ActiveRecord::Migration[7.1]
  def up
    User.find_or_create_by(email: 'projectv.scorpion@gmail.com') do |user|
      user.name ||= 'Sergey Shapovalov'
      user.admin = 1
    end
  end
end
