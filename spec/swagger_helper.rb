# frozen_string_literal: true

require "rails_helper"

RSpec.configure do |config|
  config.openapi_root = Rails.root.join("public/swagger").to_s

    config.openapi_specs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.0",
      info: {
        title: "CV API",
        version: "v1"
      },
      paths: {},
      servers: [
        {
          url: "https://cv-api-xpe1.onrender.com",
          description: "Production Server (Render)"
        },
        {
          url: "http://localhost:3000",
          description: "Local Development Server"
        }
      ],
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
