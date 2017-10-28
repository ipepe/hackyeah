class UploadController < ApplicationController
  def create
    Document.create(input_file: params.fetch(:file))
    head :ok
  end
end
