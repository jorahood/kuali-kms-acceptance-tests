Feature: Updating content

In order to add to existing documents
As a KMS Maintainer
I want to be able to modify existing documents


Scenario: I can update a doc
Given I am logged in as "editor1"
And a document with id "xxxx" exists with content
"""
<topic id="kbdoc"><title id="default">At IU, what is OneStart???</title></topic>
"""
When I go to the homepage
And I follow "Edit content"
And I fill in "fileNameInput" with "xxxx.dita" in the frame
And I press "submit" in the frame
And I fill in "document.kmsDocument.content" in the frame with
"""
<topic id="kbdoc"><title id="default">At IU, what is OneStart???</title><body><p>Topic paragraph</p></body></topic>
"""
And I press "save" in the frame
Then I should see "Topic paragraph" in the frame

           
