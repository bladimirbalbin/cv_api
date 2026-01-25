class AuthController < ApplicationController
  # Endpoint de Registro
  def register
    @user = User.new(user_params)

    if @user.save
      # has_secure_password se encarga de encriptar automáticamente
      render json: { id: @user.id, email: @user.email }, status: :created
    else
      # Devolvemos errores si el email ya existe o contraseña muy corta
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def login
    @user = User.find_by("LOWER(email) = ?", params[:email].downcase)

    # { Seguridad: Autenticación segura con bcrypt }
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.email }, status: :ok
    else
      render json: { error: "Credenciales inválidas" }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
