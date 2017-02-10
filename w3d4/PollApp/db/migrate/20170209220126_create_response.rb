class CreateResponse < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.text :response
      t.integer :user_id, null: false
      t.integer :answer_id, null: false
    end

    add_index :responses, [:user_id, :answer_id]
  end
end
