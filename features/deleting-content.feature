Feature: Deleting content

In order to keep the repository uncluttered so users can find what they need
As a KMS Maintainer
I want to be able to delete existing documents


Scenario: I can delete a doc

Given I am logged in as "editor1"
And a document with filename "xxxx" exists with content
"""
<topic id="ajpt-dmm2">
<title id="default">At IU, what is OneStart???</title>
</topic>
"""
When I go to the homepage
And I follow "Delete content"
And I fill in "documentId" with "xxxx" in the frame
And I press "submit" in the frame

           
