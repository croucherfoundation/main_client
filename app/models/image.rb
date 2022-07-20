class Image < ActiveResource::Base
  include MainFormatApiResponse
  include MainActiveResourceConfig

  belongs_to :page

  def save
    self.prefix_options[:image] = self.attributes
    super
  end

end
