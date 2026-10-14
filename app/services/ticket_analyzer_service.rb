require "openai"
require "json"

class TicketAnalyzerService
  MODEL = "gpt-4o-mini"

  def initialize(description:)
    @description = description
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def call
    return fallback_response if @description.to_s.strip.empty? || ENV["OPENAI_API_KEY"].blank?

    response = @client.chat(
      parameters: {
        model: MODEL,
        messages: [
          {
            role: "system",
            content: "You are an AI customer support assistant. Analyze the incoming customer ticket description. Respond ONLY with a valid JSON object matching this schema: {\"draft_reply\": \"Professional response to customer\", \"suggested_action\": \"System action (e.g., refund, escalate, password_reset, general_inquiry)\"}."
          },
          {
            role: "user",
            content: @description
          }
        ],
        response_format: { type: "json_object" },
        temperature: 0.3
      }
    )

    content = response.dig("choices", 0, "message", "content")
    parsed = JSON.parse(content)
    {
      draft_reply: parsed["draft_reply"],
      suggested_action: parsed["suggested_action"]
    }
  rescue StandardError => e
    Rails.logger.error("TicketAnalyzerService Error: #{e.message}")
    fallback_response
  end

  private

  def fallback_response
    {
      draft_reply: "Talebiniz alınmıştır, en kısa sürede incelenecektir.",
      suggested_action: "manual_review"
    }
  end
end
