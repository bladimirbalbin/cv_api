class User < ApplicationRecord
    # Seguridad: Habilita el método para guardar contraseñas seguras
  has_secure_password

  # Validaciones de Estabilidad: No permitimos usuarios corruptos en la DB
  validates :email, presence: true, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }, 
                    uniqueness: true
  validates :password_digest, presence: true
end
