class ChangeAdminFlagForUser < ActiveRecord::Migration[7.1]
  def change
    User.where(email: 'projectv.scorpion@gmail.com').update(admin: 1)
  end
end
