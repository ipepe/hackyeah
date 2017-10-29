class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy, :pick_columns, :report, :geocode_process]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: { status: @upload.status, progress_percent: @upload.progress_percent } }
    end
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit; end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.create(upload_params)
    @upload.update(rows_in_input_file: @upload.calculate_all_rows)
    @upload.update(columns_attributes: @upload.headers_from_input_file.map { |h| { name: h } })
    if @upload.save && @upload.valid?
      redirect_to pick_columns_upload_url(@upload), notice: 'Please select street name and number columns for geocoding'
    else
      render :new
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    @upload.update(upload_params)
    if @upload.valid?
      if !!params['picked_columns']
        redirect_to geocode_process_upload_url(@upload), notice: 'Upload started processing'
      else
        redirect_to @upload, notice: 'Upload was successfully updated.'
      end
    else
      if !!params['picked_columns']
        redirect_to pick_columns_upload_url(@upload), alert: 'Please select street name and number columns for geocoding'
      else
        render :edit
      end
    end
  end

  def geocode_process
    gon.upload_id = @upload.id
    if @upload.status.to_s != 'initial'
      redirect_to @upload, notice: 'Upload already processed'
    else
      GeocodeJob.perform_later(@upload.id)
      render :geocode_process
    end
  end

  def report
    send_data @upload.report_file_content, filename: 'report.txt'
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_upload
    @upload = Upload.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def upload_params
    params.require(:upload).permit(:input_file, columns_attributes: [:id, :meaning])
  end
end
