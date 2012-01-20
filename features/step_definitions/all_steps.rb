# the iframe id that Kuali puts all portal content within
def frame_id
  'iframeportlet'
end

Given /^(?:|I )am logged in as "([^"]*)"$/ do |username|
  steps %{
  Given I go to the homepage
  * fill in "__login_user" with "#{username}"
  And press "Login"
  }
end

When /^I am backdoor logged in as "([^"]*)"$/ do |username|
 fill_in('backdoorId', :with=> 'username')
end

Given /^document "([^"]*)" does not exist$/ do |docid|
  steps %{
  Given I go to delete a document
  * fill in "Enter a docid" with "#{docid}"
  And press "Delete document"
  }
end

Given /^a document with filename "([^"]*)" has content$/ do |filename, pystring|
  steps %{
  Given I go to the homepage
  Given I follow "New content"
  * fill in "document.documentHeader.documentDescription" with "an automated test doc" in the frame
  * fill in "document.kmsDocument.fileName" with "#{filename}" in the frame
  * fill in "document.kmsDocument.content" in the frame with
  """
  #{pystring}
  """
  And press "save" in the frame
  }
end

Given /^I search for a (ditaval|map|topic|worklist) with id (\d+)$/ do |thing, id|
  steps %{
  Given I go to the homepage
  And I follow "Document Search"
  And I fill in "Document/Notification Id:" with "#{id}" in the frame
  When I press "search" in the frame
  Then I should see "1 items found." in the frame
  }
end

Given /^a worklist exists with id (\d+)$/ do |id|
  steps %{
  When I go to "/kms-dev/worklist.do?methodToCall=docHandler&docId=#{id}&command=displayDocSearchView#topOfForm"
  Then I should see "#{id}" within "table.headerinfo"
  And I should not see "Document no longer exists."
  }
end

Given /^a document with filename "([^"]*)" exists$/ do |filename|
  name,extension = filename.split('.')
  steps %{
  * I follow "Main Menu"
  * I follow "New content"
  * fill in "document.documentHeader.documentDescription" with "#{filename}" in the frame
  * fill in "document.kmsDocument.kmsFileName.fileName" with "#{name}" in the frame
  * I select "#{extension}" from "document.kmsDocument.kmsFileName.fileTypeCode" in the frame}
end

Given /^I view worklist (\d+)$/ do |id|
  steps %{
  Given I go to "/kms-dev/worklist.do?methodToCall=docHandler&docId=#{id}&command=displayDocSearchView#topOfForm"
  }
end

Given /^worklist (\d+) is empty$/ do |id|
  steps %{
  * I go to "/kms-dev/worklist.do?methodToCall=docHandler&docId=#{id}&command=displayDocSearchView#topOfForm"
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

Given /^a document with filename "([^"]*)" exists with content$/ do |filename, string|
  steps %{
    * a document with filename "#{filename}" exists
    * fill in "document.kmsDocument.content" in the frame with
    """
    #{string}
    """
    * press "save" in the frame
  }
  #pause this whole shebang until the page reloads
#  within_frame frame_id() do
#    wait_until { page.has_content?('save')}
#  end
end

Given /^the following documents exist with metadata:$/ do |docs|
  docs.hashes.each do |doc|
    steps %{
    * a document with filename "#{doc[:filename]}" exists
    * fill in "document.kmsDocument.content" in the frame with
    """
    <topic id="kbdoc">
      <prolog>
        <author>#{doc[:author]}</author>
      </prolog>
      <title id="default">Content id: #{doc[:id]}</title>
    </topic>
    """
    * press "save" in the frame
    }
  end
end

Given /^a new worklist$/ do
  within_frame frame_id() do
    click_link('New worklist')
  end
end

Given /^the worklist contains the following documents:$/ do |docs|
  within_frame frame_id() do
    docs.hashes.each do |doc|
      fill_in("newWorkListItem.newFileName", :with=> "#{doc[:filename]}")
      click_button("Add a Worklist Item")
    end
  click_button('save')
  end
end

Given /^worklist (\d+) contains the following documents:$/ do |worklist_id, docs|
  Given %{I go to "/kms-dev/worklist.do?methodToCall=docHandler&docId=#{worklist_id}&command=displayDocSearchView#topOfForm"}
  docs.hashes.each do |doc|
    steps %{
    * I fill in "newWorkListItem.documentId" with "#{doc[:id]}"
    * I press "Add a Worklist Item"
    }
  end
  step %{I press "save"}
end

Given /^the worklist displays the author column$/ do
  within_frame frame_id() do
    check('Author:')
    click_button('save')
  end
end

Given /^the worklist displays the owner column$/ do
  within_frame frame_id() do
    check('Owner:')
    click_button('save')
  end
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

Given /^I fill in the sample dita content$/ do
  within_frame frame_id() do
    find('kmsSampleTopic').click
  end
end

Given /^user "([^"]*)" is a member of the "([^"]*)" owner group$/ do |arg1, arg2|
end

When /^I add document "([^"]*)" to the worklist$/ do |docid|
  within_frame frame_id() do
    fill_in('document.documentHeader.documentDescription', :with => "another test list")
    fill_in("newWorkListItem.newFileName", :with=> docid)
    click_button("Add a Worklist Item")
  end
end

When /^I remove document "([^"]*)" from the worklist$/ do |arg1|
  within_frame frame_id() do
    click_button("Delete a Worklist Item")
  end
end

When /^I save the worklist$/ do
  within_frame frame_id() do
    click_button("save")
  end

end

When /^I edit the "([^"]*)" branch of the document with filename "([^"]*)"$/ do |branch, filename|
  within_frame frame_id() do
    fill_in('fileNameInput', :with => filename)
    #click the filename in the dropdown created via javascript
    find('div.dropItem', :text => "/#{filename}").click
    select(branch, :from => 'branchIdForFilenameDivSelect')
    with_scope('div.right') do
      click_button('submit')
    end
  end
end

When /^I edit the content of the document to be$/ do |content|
  within_frame frame_id() do
    fill_in("document.kmsDocument.content", :with => content)
  end
end

When /^I preview the document with audience filter "([^"]*)"$/ do |audience|
  within_frame frame_id() do
    sleep 10 # give the poller time to render
    select(audience, :from => 'kmsAudiencePreview')
    find('#previewDocument').click
  end
end

When /^I sort the worklist by content id$/ do
  within_frame frame_id() do
    find('th.header', :text => 'Content id').click
  end
end

When /^I sort the worklist by author$/ do
  within_frame frame_id() do
    # see Capybara::Node::Finders#find
    find('th.header', :text => 'Author').click
  end
end

When /^I set this sort order as default$/ do
  within_frame frame_id() do
    check('saveCurrentSortOrder')
    click_button('save')
  end
end

When /^I reload the worklist$/ do
  within_frame frame_id() do
    click_button('reload')
  end
end

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |button, selector|
  within_frame frame_id() do
    with_scope(selector) do
      click_button(button)
    end
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |value, field, selector|
  within_frame frame_id() do
    with_scope(selector) do
      select(value, :from => field)
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
      page.should have_content(text)
    end
  end
end

Then /^(?:|I )should not see "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |text, selector|
  within_frame frame_id() do
    with_scope(selector) do
      page.should_not have_content(text)
    end
  end
end

When /^(?:|I )search for "([^"]*)"$/ do |terms|
  steps %{
  Given I go to search
  * fill in "query" with #{terms}
  And press "Search"
  }
end

#so I can use single quotes around double-quoted search strings:
When /^(?:|I )search for '([^']*)'$/ do |terms|
  steps %{
  Given I go to search
  * fill in "query" with #{terms}
  And press "Search"
  }
end

Then /^I should see document "([^"]*)" in my action list$/ do |filename|
  click_link('Action List')
  within_frame frame_id() do
    page.should have_content(filename)
  end
end

When /^I submit the document$/ do
  within_frame frame_id() do
    click_button('submit')
  end
end

When /^I route the document for SME approval$/ do
  within_frame frame_id() do
    click_button('click here to route for SME approval')
  end
end

When /^I impersonate user "([^"]*)"$/ do |username|
  fill_in("backdoorId", :with=> 'username')
  click_button('Login')
end

Then /^I should see "([^"]*)" in the preview window$/ do |string|
  # from http://blog.kshitizgurung.info/2011/07/detecting-popup-window-and-implementing-test-on-in-capybara-selenium/
  within_window(page.driver.browser.window_handles.last) do
    page.should have_content(string)
  end
end

Then /^I should not see "([^"]*)" in the preview window$/ do |string|
  # from http://blog.kshitizgurung.info/2011/07/detecting-popup-window-and-implementing-test-on-in-capybara-selenium/
  within_window(page.driver.browser.window_handles.last) do
    page.should_not have_content(string)
  end
end

Then /^(?:|I )should see element (.*)$/ do |element|
  page.should have_xpath("//#{element}")
end

Then /^the documents should appear in this order:$/ do |docs|
  docs.hashes.each_with_index do |doc, i|
    step %{I should see "#{doc[:id]}" within "#workListItems tbody tr:nth-child(#{i + 1})" in the frame}
  end
end

Then /^the worklist should be sorted by author$/ do
  #tell Capybara to wait until the sorted header is updated
  within_frame frame_id() do
    find('th.headerSortDown')
  end
  step %{I should see "Author" within "th.headerSortDown" in the frame}
end

Then /^I should see document "([^"]*)"$/ do |filename|
  #  within_frame frame_id() do
  #    find("#workListItems") #wait for it
  #    with_scope("#workListItems") do
  #        page.should have_content(filename)
  #    end
  steps %{Then I should see "#{filename}" within "#workListItems" in the frame}
  #  end
end

Then /^I should not see document "([^"]*)"$/ do |filename|
  steps %{Then I should not see "#{filename}" within "#workListItems" in the frame}
end

Then /^I should see document "([^"]*)" once$/ do |filename|
  within_frame frame_id() do
    with_scope("#workListItems") do
      page.should contain_once(filename)
    end
  end
end

Then /^show me the frame$/ do
  within_frame frame_id() do
    save_and_open_page
  end
end