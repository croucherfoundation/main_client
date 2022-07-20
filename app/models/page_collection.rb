class PageCollection < ActiveResource::Base
  include MainFormatApiResponse
  include MainActiveResourceConfig

  def self.new_with_defaults(attributes={})
    page = Page.new({
      title: "",
      slug: ""
    }.merge(attributes))
    page
  end

  def save
    self.prefix_options[:page_collection] = self.attributes
    super
  end
end
