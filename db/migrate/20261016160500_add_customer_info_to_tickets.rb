class AddCustomerInfoToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :customer_name, :string
    add_column :tickets, :customer_email, :string
  end
end
