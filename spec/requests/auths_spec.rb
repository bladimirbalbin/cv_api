require 'swagger_helper'

RSpec.describe 'api/v1/auth', type: :request do
  path '/auth/register' do
    post('register') do
      tags 'Authentication'
      description 'Create a new user account'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'recruiter@test.com' },
              password: { type: :string, example: 'password123' }
            },
            required: [ 'email', 'password' ]
          }
        },
        required: [ 'user' ]
      }

      response(201, 'created') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string }
          }

        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
          properties: {
            errors: { type: :array, items: { type: :string } }
          }

        run_test!
      end
    end
  end
  path '/auth/login' do
    post('login') do
      tags 'Authentication'
      description 'Authenticates user and returns a JWT token'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'recruiter@test.com' },
          password: { type: :string, example: 'password123' }
        },
        required: [ 'email', 'password' ]
      }

      response(200, 'successful') do
        schema type: :object,
          properties: {
            token: { type: :string },
            exp: { type: :string },
            username: { type: :string }
          }

        # Setup de datos para la prueba
        before do
          User.create!(email: 'test@test.com', password: 'password123')
        end

        run_test!
      end

      response(401, 'unauthorized') do
        before do
          # No creamos usuario o password incorrecto
          User.create!(email: 'test@test.com', password: 'password123')
        end

        run_test!
      end
    end
  end
end
