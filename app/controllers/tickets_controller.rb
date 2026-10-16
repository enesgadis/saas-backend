class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show update analyze]

  def index
    @tickets = Ticket.order(created_at: :desc)
    render json: @tickets
  end

  def show
    render json: @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Temsilci tarafından talep edilen canlı AI analizi
  def analyze
    analysis = TicketAnalyzerService.new(description: @ticket.description).call
    if @ticket.update(ai_draft_reply: analysis[:draft_reply], ai_suggested_action: analysis[:suggested_action])
      render json: @ticket
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Ticket not found" }, status: :not_found
  end

  def ticket_params
    params.require(:ticket).permit(
      :title,
      :description,
      :status,
      :ai_draft_reply,
      :ai_suggested_action,
      :customer_name,
      :customer_email
    )
  end
end
