class SkillsController < ApplicationController
  # 1. Proteger TODA la lógica con Autenticacion
  before_action :authorize_request
  # 2. Buscar el skill especifico SOLO si pertenece al usuario actual
  before_action :set_skill, only: %i[ show update destroy ]

  # GET /skills (Devuelve SOLO mis skills)
  def index
    @skills = current_user.skills
    render json: @skills
  end

  # GET /skills/1
  def show
    render json: @skill
  end

  # POST /skills
  def create
    # Esta linea es clave: build asocia el skill al usuario actual sin guardar aún
    @skill = current_user.skills.build(skill_params)

    if @skill.save
      render json: @skill, status: :created, location: @skill
    else
      render json: { errors: @skill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /skills/1
  def update
    if @skill.update(skill_params)
      render json: @skill
    else
      render json: { errors: @skill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = current_user.skills.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def skill_params
      params.require(:skill).permit(:name, :proficiency, :user_id) # user_id lo ignoraremos en create por seguridad
    end
end
