class AlterResponseTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :responses, :response
  end
end
