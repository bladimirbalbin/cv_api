class JsonWebToken
  # Configuramos la secreta leyendola de las credenciales encriptadas
  SECRET_KEY = Rails.application.credentials.jwt[:secret]

  def self.encode(payload, exp = 24.hours.from_now)
    # Agregamos la expiración al payload
    payload[:exp] = exp.to_i
    # Retornamos el token JWT codificado con la clave secreta
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    # Decodificamos el token JWT usando la clave secreta
    decoded = JWT.decode(token, SECRET_KEY)[0]
    # Retornamos el payload decodificado como un Hash con símbolos como llaves
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError => e
    # Manejo de errores de decodificación
    raise StandardError, "Token inválido: #{e.message}"
  end
end
