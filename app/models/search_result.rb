class SearchResult

  require 'ruby-debug'
  attr_accessor :number, :title, :url, :description, :size

  @@_google_default_params = {
    :output => 'xml_no_dtd',
    :client => 'google-csbe',
    :num => '10',
    :filter => '0',
    :start => '0'
  }
  cattr_accessor :_google_default_params

  #
  # Queries google custom search by a specific URL to find all the results. Converts XML results to
  # a paging results of Search Results.
  #
  def self.find(query, options={})
    # Escape dangerous characers in the search
    safe_query = query.to_s.mb_chars.gsub(/[^a-zA-Z0-9\s"]/, '').gsub(/\s+/, '+')
    
    xml_doc = fetch_xml_doc(safe_query, options)
    results = convert_to_results(xml_doc, options)
    results.query = safe_query
    portlet = find_search_engine_portlet(options)
    results.path = portlet.path 
    results
  end

  def self.parse_results_count(xml_doc)
    root = xml_doc.root
    count = root.elements["RES/M"]
    count ? count.text.to_i : 0
  end

  def self.parse_results(xml_doc)
    root = xml_doc.root
    results = []

    xml_doc.elements.each('GSP/RES/R') do |ele|
      result = SearchResult.new

      result.number = ele.attributes["N"]
      result.title = ele.elements["T"].text
      result.url = ele.elements["U"].text
      result.description = ele.elements["S"].text
      result.size = ele.elements["HAS/C"].nil? ? nil : ele.elements["HAS/C"].attributes["SZ"]

      results << result
    end
    results
  end

  def self.convert_to_results(xml_doc, options={})
    array = parse_results(xml_doc)

    results = PagingResults.new(array)
    results.results_count = parse_results_count(xml_doc)
    results.num_pages = calculate_results_pages(results.results_count)
    results.start = options[:start] ? options[:start] : 0
    results
  end



  def self.calculate_results_pages(results_count)
    num_pages = results_count / 10
    num_pages = num_pages + 1 if results_count % 10 > 0
    num_pages
  end


  def self.build_cse_url(options, query)
    portlet = find_search_engine_portlet(options)
    search_options = {:cx => portlet.search_id, :client => portlet.front_end_name, :start => options[:start], :q => query}
    search_options.delete_if { |k, v| v.blank? }

    g_params = _google_default_params.merge(search_options)
    temp_url = "http://www.google.com/cse?#{hash_to_url_attributes(g_params)}"

    return temp_url
  end

  def self.find_search_engine_portlet(options)
    portlet = GoogleCustomSearchEnginePortlet.new
    if options[:portlet]
      portlet = options[:portlet]
    end
    portlet
  end

  # Fetches the xml response from the google custom search.
  def self.fetch_xml_doc(query, options={})
    temp_url = build_cse_url(options, query)
    debugger; debugger
    response = Net::HTTP.get(URI.parse(URI.encode(temp_url)))
    xml_doc = REXML::Document.new(response)
    return xml_doc
  end

  class PagingResults < Array

    attr_accessor :results_count, :num_pages, :current_page, :start, :query, :pages
    attr_writer :path

    def path
      @path ? @path : "/search/search-results"
    end


    def next_page?
      next_start < results_count      
    end

    def previous_page?
      previous_start >= 0 && num_pages > 1
    end

    def pages
      if num_pages > 1
        return (1..num_pages)
      end
      []
    end

    def next_start
      start + 10
    end

    def previous_start
      start - 10
    end
    
    def current_page?(page_num)
      (page_num * 10 - 10 == start )
    end

    def current_page
      return page = start / 10 + 1 if start
      1
    end

    def next_page_path
      "#{path}?query=#{query}&start=#{next_start}"
    end

    def previous_page_path
      "#{path}?query=#{query}&start=#{previous_start}"
    end

    def page_path(page_num)
      "#{path}?query=#{query}&start=#{page_num * 10 - 10}"
    end
  end


  private

    def self.hash_to_url_attributes(hash)
      attributes = []
      hash.stringify_keys.each do |k, v|
        attributes << "#{k}=#{v}"
      end

      return attributes.join('&')
    end

end