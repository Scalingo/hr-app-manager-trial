# frozen_string_literal: true

class ApplicationsController < BaseController
  def index
    @applications = Application.where(deleted_at: nil)
  end

  def show
    @application = current_application
  end

  def edit
    @application = current_application
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      respond_to do |format|
        format.html { redirect_to applications_path }
        format.json { render json: @application, status: :ok }
      end
    else
      respond_to do |format|
        format.html do
          index
          render :index
        end
        format.json { render json: { errors: @application.errors }, status: :unprocessable_content }
      end
    end
  end

  def update
    @application = current_application

    if @application.update(application_params)
      respond_to do |format|
        format.html { redirect_to @application }
        format.json { render json: @application }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: { errors: @application.errors }, status: :unprocessable_content }
      end
    end
  end

  def destroy
    application = Application.find(params[:id])
    ApplicationDestroyerService.new(application).call

    respond_to do |format|
      format.html { redirect_to applications_path }
      format.json { render json: {}, status: :ok }
    end
  end

  private

  def current_application
    application = Application.find(params[:id])
    raise ActiveRecord::RecordNotFound if application.deleted_at

    application
  end

  def application_params
    params.require(:application).permit(:name, :description)
  end
end
