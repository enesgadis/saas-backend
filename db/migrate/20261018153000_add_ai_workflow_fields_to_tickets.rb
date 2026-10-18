class AddAiWorkflowFieldsToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :department, :string
    add_column :tickets, :internal_note, :text
    add_column :tickets, :time_saved_minutes, :integer, default: 0
  end
end
