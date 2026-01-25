require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/users/profile' do
    get 'Get current user profile' do
      tags 'Users'
      # ESTA LÍNEA ACTIVA EL BOTÓN DE AUTORIZACIÓN EN SWAGGER
      security [ bearer_auth: [] ]

      produces 'application/json'

      response '200', 'success' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string }
          },
          required: [ 'id', 'email' ]

        # Simulamos la autenticación solo para que la prueba pase durante la generación
        before do
          user = User.create!(email: 'test@test.com', password: 'password')
          allow_any_instance_of(AuthController).to receive(:current_user).and_return(user)
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { "Bearer #{'invalid_token'}" }

        run_test!
      end
    end
  end
end
