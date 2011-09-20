# the iframe id that Kuali puts all portal content within
def frame_id
  'iframeportlet'
end

Given /^(?:|I )am logged in as "([^"]*)"$/ do |username|
  steps %Q{
  Given I go to the homepage
  * fill in "__login_user" with "#{username}"
  And press "Login"
  }
end

Given /^document "([^"]*)" does not exist$/ do |docid|
  steps %Q{
  Given I go to delete a document
  * fill in "Enter a docid" with "#{docid}"
  And press "Delete document"
  }
end

Given /^a document with id "([^"]*)" exists with content$/ do |docid, pystring|
  steps %Q{
  Given I follow "New content"
  * fill in "document.documentHeader.documentDescription" with "an automated test doc" in the frame
  * fill in "document.kmsDocument.fileName" with "xxxx" in the frame
  * fill in "document.kmsDocument.content" in the frame with
  """
  #{pystring}
  """
  And press "save" in the frame
  }
end

Given /^I search for a (ditaval|map|topic|worklist) with id (\d+)$/ do |thing, id|
  steps %Q{
  Given I go to the homepage
  And I follow "Document Search"
  And I fill in "Document/Notification Id:" with "#{id}" in the frame
  When I press "search" in the frame
  Then I should see "1 items found." in the frame
  }
end

Given /^a worklist exists with id (\d+)$/ do |id|
  steps %Q{
  When I go to "/kms-snd/worklist.do?methodToCall=docHandler&docId=#{id}&command=displayDocSearchView#topOfForm"
  Then I should see "#{id}" within "table.headerinfo"
  And I should not see "Document no longer exists."
  }
end

Given /^document (\d+) exists$/ do |id|
  steps %Q{
  When I go to "/kms-snd/document.do?methodToCall=docHandler&docId=#{id}&command=displayDocSearchView#topOfForm"
  Then I should see "#{id}" within "table.headerinfo"
  And I should not see "unable to locate document"
  }
end

Given /^I view worklist (\d+)$/ do |id|
  steps %Q{
  Given I go to "/kms-snd/worklist.do?methodToCall=docHandler&docId=#{id}&command=displayDocSearchView#topOfForm"
  }
end

Given /^worklist (\d+) is empty$/ do |id|
  steps %Q{
  * I go to "/kms-snd/worklist.do?methodToCall=docHandler&docId=#{id}&command=displayDocSearchView#topOfForm"
  }
  # this will delete all documents in a worklist, one by one. Each gets removed via javascript instantly but
  # the change isn't final until you click save
  while true do
    begin
      click_button("Delete a Worklist Item")
    rescue Capybara::ElementNotFound
      click_button("save")
      break
    end
  end
end

Given /^worklist (\d+) contains document (\d+)$/ do |worklist_id, doc_id|
  steps %Q{
    * worklist #{worklist_id} is empty
    * I fill in "newWorkListItem.documentId" with "#{doc_id}"
    * I press "Add a Worklist Item"
    * I press "save"
  }

end

#with single quotes since we may need double quotes in the string
Given /^(?:|I )fill in "([^"]*)" with '([^']*)'$/ do |field, string|
  fill_in(field, :with => string)
end

Given /^(?:|I )fill in "([^"]*)" with$/ do |field, pystring|
  fill_in(field, :with => pystring)
end

Given /^(?:|I )fill in "([^"]*)" in the frame with$/ do |field, pystring|
  within_frame frame_id() do
    fill_in(field, :with => pystring)
  end
end

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |button, selector|
  within_frame frame_id() do
    with_scope(selector) do
      click_button(button)
    end
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |field, value, selector|
  within_frame frame_id() do
    with_scope(selector) do
      fill_in(field, :with => value)
    end
  end
end

When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |link, selector|
  within_frame frame_id() do
    with_scope(selector) do
      click_link(link)
    end
  end
end

Then /^(?:|I )should see "([^"]*)"(?: within "([^"]*)")? once$/ do |string, selector|
  with_scope(selector) do
    page.should contain_once(string)
  end
end

Then /^(?:|I )should see "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |text, selector|
  within_frame frame_id() do
    with_scope(selector) do
      if page.respond_to? :should
        page.should have_content(text)
      else
        assert page.has_content?(text)
      end
    end
  end
end

When /^(?:|I )search for "([^"]*)"$/ do |terms|
  steps %Q{
  Given I go to search
  * fill in "query" with #{terms}
  And press "Search"
  }
end

#so I can use single quotes around double-quoted search strings:
When /^(?:|I )search for '([^']*)'$/ do |terms|
  steps %Q{
  Given I go to search
  * fill in "query" with #{terms}
  And press "Search"
  }
end

Then /^(?:|I )should see element (.*)$/ do |element|
  page.should have_xpath("//#{element}")
end
