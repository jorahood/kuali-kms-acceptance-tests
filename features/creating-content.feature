Feature: Creating content

In order to write about new things
As a KMS Maintainer
I want to create new content through the CRUD web interface


Scenario: All form fields that I must complete for a new document are marked with an asterisk

Given I am logged in as "editor1"
When I follow "New content"
Then I should see "*" within "label[for='document.documentHeader.documentDescription']" in the frame
And I should see "*" within "label[for='document.kmsDocument.fileName']" in the frame

Scenario: I can add a new doc

Given I am logged in as "editor1"
When I follow "New content"
And I fill in "document.documentHeader.documentDescription" with "an automated test doc" in the frame
And I fill in "document.kmsDocument.fileName" with "xxxx" in the frame
And I fill in "document.kmsDocument.content" in the frame with
"""
<task id="kbdoc">
<title id="default">In Microsoft Excel, how can I apply several formats to a cell in one step?</title>
</task>
"""
And I press "save" in the frame
Then I should see "Document was successfully saved." in the frame

           
