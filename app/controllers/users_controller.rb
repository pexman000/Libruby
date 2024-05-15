  class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, only: [:new, :create]
    before_action :correct_user, only: [:edit, :update]

    # GET /users or /users.json
    def index
      @users = User.all
    end

    # GET /users/1 or /users/1.json
    def show
      @user = User.find_by(id: params[:id])
      unless @user
        flash[:alert] = "User not found"
        redirect_to users_path
      end
    end

    # GET /users/new
    def new
      redirect_to new_session_path
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users or /users.json
    def create
      @user = User.new(user_params)
    
      respond_to do |format|
        if @user.save
          format.html { redirect_to root_path, notice: "Inscription réussie !" }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end    

    # PATCH/PUT /users/1 or /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1 or /users/1.json
    def destroy
      @user.destroy!

      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Vérifie que l'utilisateur actuellement connecté est le même que celui dans l'URL
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user == @user
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:username, :name, :password, :email, :seller)
      end
  end
