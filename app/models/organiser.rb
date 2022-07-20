class Organiser < ActiveResource::Base
  include MainFormatApiResponse
  include MainActiveResourceConfig

  belongs_to :event

end
