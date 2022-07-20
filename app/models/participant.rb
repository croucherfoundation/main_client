class Participant < ActiveResource::Base
  include MainFormatApiResponse
  include MainActiveResourceConfig

  belongs_to :event

  def save
    self.prefix_options[:participant] = self.attributes
    super
  end

end
