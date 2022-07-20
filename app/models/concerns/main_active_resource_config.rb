module MainActiveResourceConfig
  extend ActiveSupport::Concern

  included do
    self.site                   = ENV['MAIN_API_URL']
    self.prefix                 = '/api/'
    self.format                 = MainFormatApiResponse
    self.include_format_in_path = false
  end
end
