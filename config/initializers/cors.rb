Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Canlı test ve sunum için tüm kaynaklara izin veriyoruz

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end