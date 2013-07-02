class ResumesController < ApplicationController
  before_filter :authenticate_user!, :except => [:public]
  layout false, only: :public

  def public
    @resume = Resume.find_by_checksum(params[:checksum])
    redirect_to root_url unless @resume
  end

  def index
    @resumes = current_user.resumes
  end

  def show
    @resume = Resume.find(params[:id])
  end

  def new
    @resume = Resume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume }
    end
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def create
    @resume = Resume.new(resume_params.merge(user: current_user))

    if @resume.save
      redirect_to @resume, notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def update
    @resume = Resume.find(params[:id])

    if @resume.update_attributes(resume_params)
      redirect_to @resume, notice: 'Resume was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    redirect_to resumes_url
  end

  private

  def resume_params
    params.require(:resume).permit(:title)
  end
end
