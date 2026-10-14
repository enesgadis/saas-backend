class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :description
      t.string :status, default: "open", null: false
      t.text :ai_draft_reply
      t.string :ai_suggested_action

      t.timestamps
    end
  end
end
