class ChangeColumnUserIdToMoods < ActiveRecord::Migration[5.2]
  def change
    change_column :moods, :user_id, :bigint
  end
end
