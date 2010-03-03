module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def webroot
    '/sage-stg/kms'
  end

  def path_to(page_name)
    case page_name
    
    when /the homepage/
      "#{webroot}/index.cat"

    when /search/
      "#{webroot}/form/search.cat"

    when /view a document in xml/
      "#{webroot}/form/get/xml.cat"

    when /view a document in xhtml/
      "#{webroot}/form/get/xhtml.cat"

    when /add a document/
      "#{webroot}/form/put/xml.cat"

    when /delete a document/
      "#{webroot}/form/delete/xml.cat"

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
