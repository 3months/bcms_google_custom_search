# Google Site Search Module

This module allows BrowserCMS to integrate with a Google Custom Search. Google Custom Search is a search product,
which can be configured to crawl your website(s). This module submits queries to the google custom search site, and formats the results.
It consists of the following two portlets.

1. Search Box - Displays an input box that submits a search query.
2. Google Custom Search Results Portlet - Sends query to the custom search engine, formats the XML response and displays the results.

Note: This module assume the BrowserCMS web site owner has access to their own Google Custom Search, which is a user pays service.

## A. Instructions
There are two basic steps to setting up this module:

1. Configure your Google Custom Search to crawl your site.
2. Install the module and configure it to point to your Google Custom Search.

These instructions assume the Custom Search is already set up and running.

### B. Configuring the BrowserCMS Google Custom Search Module
These instructions assume you have successfully installed the bcms_google_custom_search module into your project. To make
the module work, you will have to configure two portlets.

1. In your sitemap, create a new section called 'Search', with a path '/search'.
2. Create a page called 'Search Results', with a path '/search/search-results'.
3. On that page, add a new 'Google Custom Search Engine' portlet. Keep the default for most fields.
4. In the Search ID field, enter in the unique identifier provide by google, for your custom search
7. Make sure the 'path' attribute is the same as the page you are adding  the portlet to (i.e. /search/search-results
8. Save the portlet
9. On another page create a Search Box portlet (alternatively, you can create the portlet and add it your templates via render_portlet)
10. Set the 'Search Engine Name' field to the exact same name as the portlet in step B.3 above (i.e. Google Custom Search Engine)
11. Save the portlet

At this point, you can test the search by entering in a term to the Search Box portlet. If its working, it should call
the Search Results page and display the same results as what you see in the Custom Searchs' admin portal.