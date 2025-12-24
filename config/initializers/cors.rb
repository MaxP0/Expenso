# frozen_string_literal: true

# CORS for separate frontend (Vite dev server, etc.)
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    raw_origins = ENV["FRONTEND_ORIGINS"] || ENV["FRONTEND_ORIGIN"] || "http://localhost:5173"
    origin_items = raw_origins.split(",").map(&:strip).reject(&:empty?)
    origin_items = ["http://localhost:5173"] if origin_items.empty?

    parsed_origins = origin_items.map do |item|
      if item.include?("*")
        pattern = "\\A" + Regexp.escape(item).gsub("\\*", ".*") + "\\z"
        Regexp.new(pattern)
      else
        item
      end
    end

    origins(*parsed_origins)

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[Authorization],
      max_age: 600
  end
end
