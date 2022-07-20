module HasPage
  extend ActiveSupport::Concern

  def page
    Page.find(page_id)
  end
  
  def page?
    page_id && page
  end
  
  def publication
    page.publication if page?
  end

end