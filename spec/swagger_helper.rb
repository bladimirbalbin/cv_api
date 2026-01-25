# frozen_string_literal: true

require "rails_helper"

RSpec.configure do |config|
  config.openapi_root = Rails.root.join("public/swagger").to_s

  servers =
    if Rails.env.production?
      [
        {
          url: "https://cv-api-xpe1.onrender.com",
          description: "Production Server (Render)"
        }
      ]
    else
      [
        {
          url: "http://localhost:3000",
          description: "Local Development Server"
        },
        {
          url: "https://cv-api-xpe1.onrender.com",
          description: "Production Server (Render)"
        }
      ]
    end

  config.openapi_specs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.0",
      info: {
        title: "CV API",
        version: "v1"
      },
      paths: {},
      servers: servers,
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: "JWT"
          }
        }
      }
    }
  }

  config.openapi_format = :yaml
end
