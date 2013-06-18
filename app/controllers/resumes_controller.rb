class ResumesController < ApplicationController
  before_filter :authenticate_user!, :except => [:public]
  layout false, only: :public

  def public
    @resume = Resume.find_by_checksum(params[:checksum])
    redirect_to root_url unless @resume
  end

  def index
    @resumes = current_user.resumes.all
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
    @resume = Resume.new(params[:resume].merge(user: current_user))

    respond_to do |format|
      if @resume.save
        format.html { redirect_to @resume, notice: 'Resume was successfully created.' }
        format.json { render json: @resume, status: :created, location: @resume }
      else
        format.html { render action: "new" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to resumes_url }
      format.json { head :no_content }
    end
  end
end
