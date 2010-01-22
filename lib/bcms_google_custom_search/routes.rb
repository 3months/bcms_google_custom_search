module Cms::Routes
  def routes_for_bcms_google_custom_search
    namespace(:cms) do |cms|
      #cms.content_blocks :google_custom_searches
    end  
  end
end
