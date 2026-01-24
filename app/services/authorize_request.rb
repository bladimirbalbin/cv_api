class AuthorizeRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return user object
  def call
    user
  end

  private

  def user
    # 1. Extraer el token del header
    if decoded_auth_token
      # 2. Buscar el usuario en la base de datos usando el ID dentro del token
      @user ||= User.find(decoded_auth_token[:user_id])
    end

    # 3. Manejar errores: Si no hay token o no coincide con ningún usuario
    handle_user_not_found if @user.nil?
    @user
  end
  def decoded_auth_token
    # Decodificar el token usando el servicio JsonWebToken
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end
  # extract token from header
  def http_auth_header
    # Esperamos el formato: "Authorization: Bearer <token>"
    if headers["Authorization"].present?
      return headers["Authorization"].split(" ").last
    end
    raise(ExceptionHandler::MissingToken, "Missing token")
  end

  def handle_user_not_found
    raise(ExceptionHandler::InvalidToken, "Invalid token")
  end
end
