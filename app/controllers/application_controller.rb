class ApplicationController < ActionController::API
  include Authenticable # Solo necesitamos incluir nuestro módulo de seguridad

  # Si quisieras manejar errores globales de la DB, podrías poner:
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  private

  def not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  # Elimina cualquier referencia a 'ExceptionHandler' o 'unauthorized_response' si quedó.
end