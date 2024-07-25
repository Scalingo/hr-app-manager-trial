class ApplicationsController < BaseController
  def index
    @applications = Application.where(deleted_at: nil)
  end

  def show
    @application = current_application
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      redirect_to applications_path
    else
      index
      render :index
    end
  end

  def edit
    @application = current_application
  end

  def update
    @application = current_application

    if @application.update(application_params)
      redirect_to @application
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    application = Application.find(params[:id])
    application.deleted_at = Time.now
    application.name = "#{application.name} (deleted at #{application.deleted_at})"
    application.save!

    redirect_to applications_path
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
