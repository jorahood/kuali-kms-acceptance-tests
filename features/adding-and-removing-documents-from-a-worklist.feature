Feature: Adding and removing documents from a worklist

Scenario: I can add a document to a worklist

Given I am logged in as "editor1"
And a worklist exists with id 3804
And worklist 3804 is empty
And document 3193 exists
And I view worklist 3804
When I fill in "newWorkListItem.documentId" with "3193"
And I press "Add a Worklist Item"
And I press "save"
Then I should see "3193"

Scenario: I cannot add the same document twice

Given I am logged in as "editor1"
And a worklist exists with id 3804
And worklist 3804 is empty
And document 3193 exists
And I view worklist 3804
And I fill in "newWorkListItem.documentId" with "3193"
And I press "Add a Worklist Item"
When I fill in "newWorkListItem.documentId" with "3193"
And I press "Add a Worklist Item"
Then I should see "Duplicate entries not allowed in worklist"
And I press "save"
Then I should see "3193" within "#workListItems" once

Scenario: I can remove a document from a worklist

Given I am logged in as "editor1"
And a worklist exists with id 3804
And document 3193 exists
And worklist 3804 contains document 3193
And I view worklist 3804
And I press "Delete a Worklist Item"
And I press "save"
Then I should not see "3193" within "#workListItems"

           
