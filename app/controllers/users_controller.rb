class UsersController < ApplicationController
  # SEGURIDAD: Antes de ejecutar el 'profile', ejecuta 'authorize_request'
  before_action :authorize_request, only: [:profile]

  def profile
    # si llegamos aqui, @current_user fue cargado por Authenticable
    render json: { email: @current_user.email, id: @current_user.id }, status: :ok
  end
end
