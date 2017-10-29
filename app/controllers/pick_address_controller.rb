class PickAddressController < ApplicationController
  before_action :set_document, only: [:new]

  private

  def set_document
    @document = Document.find(params.fetch(:id))
  end

end
