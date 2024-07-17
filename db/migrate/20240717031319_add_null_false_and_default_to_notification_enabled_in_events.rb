class AddNullFalseAndDefaultToNotificationEnabledInEvents < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :notification_enabled, :boolean, null: false, default: true
  end
end
