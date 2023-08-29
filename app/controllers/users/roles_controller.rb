class Users::RolesController < ApplicationController
  before_action :authenticate_user!
	before_action :set_role, only: %i[ show edit update destroy ]

  # GET /roles or /roles.json
  def index
    @roles = Role.where(resource_id: current_user.publisher.id).all
  end

  # GET /roles/1 or /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
    @user = current_user
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    @role = Role.new(role_params)
    @role.resource = current_user.publisher
    respond_to do |format|
      if @role.save
        format.html { redirect_to users_roles_path, notice: "Role was successfully created." }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to role_url(@role), notice: "role was successfully updated." }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_url, notice: "Role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.require(:role).permit(:name, permission_ids_input: [])
    end
end
