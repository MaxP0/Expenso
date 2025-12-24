# frozen_string_literal: true

# CORS for separate frontend (Vite dev server, etc.)
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    raw_origins = ENV["FRONTEND_ORIGINS"] || ENV["FRONTEND_ORIGIN"] || "http://localhost:5173"
    origin_list = raw_origins.split(",").map(&:strip).reject(&:empty?)
    origin_list = ["http://localhost:5173"] if origin_list.empty?
    origins(*origin_list)

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[Authorization],
      max_age: 600
  end
end
