# app/controllers/concerns/authenticable.rb
module Authenticable
  def authorize_request
    header = request.headers["Authorization"]

    # Caso 1: No enviaron nada el header
    if header.nil?
      render json: { error: "Missing Authorization Header" }, status: :unauthorized
      return
    end

    # Verificar si tiene el formato "Bearer TOKEN" (Caso 2: Bad Request si el formato es incorrecto)
    unless header.match?(/^Bearer /)
      render json: { error: "Bad Request: Header format must be: Bearer <token>" }, status: :bad_request
      return
    end

    # Extraemos el token
    token = header.split(" ").last

    # Intentamos decodificar
    decoded = JsonWebToken.decode(token)

    if decoded
      @current_user = User.find(decoded[:user_id])
    else
      # Caso 3: Token inválido o expirado (Unauthorized)
      render json: { error: "Unauthorized: Invalid or expired token" }, status: :unauthorized
      nil
    end

  rescue JWT::DecodeError
    # Caso 4: El token tiene formato basura (Bad Request)
    render json: { error: "Bad Request: Malformed token" }, status: :bad_request
    nil
  end
  def current_user
    @current_user
  end
end
