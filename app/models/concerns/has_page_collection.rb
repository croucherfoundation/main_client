module HasPageCollection
  extend ActiveSupport::Concern

  def page_collection
    PageCollection.find(page_collection_id)
  end
  
  def page_collection?
    page_collection_id && page_collection
  end

end