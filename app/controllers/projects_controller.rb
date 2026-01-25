class ProjectsController < ApplicationController
  # 1. Proteger TODA la lógica con autenticación
  before_action :authorize_request
  # 2. Buscar el proyecto específico SOLO si pertenece al usuario actual
  before_action :set_project, only: %i[ show update destroy ]

  # GET /projects (Devuelve SOLO mis proyectos)
  def index
    @projects = current_user.projects
    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects (Crea un proyecto asociado a MI usuario)
  def create
    # Asociamos el proyecto al usuario actual
    @project = current_user.projects.build(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, :url, :user_id)
    end
end
