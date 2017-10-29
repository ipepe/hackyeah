class GeocodeJob < ApplicationJob
  def perform(upload_id)
    Upload.find(upload_id).tap(&:process).save
  end
end
