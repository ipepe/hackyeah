class UploadController < ApplicationController
  def create
    document = Document.create_from(params.fetch(:file))
    redirect_to(pick_address_path(document.id))
  end
end
