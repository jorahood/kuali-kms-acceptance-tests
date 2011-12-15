Feature: Adding and removing documents from a worklist

Scenario: I can add a document to a worklist

Given I am logged in as "editor1"
And a worklist exists with id 3090
And worklist 3090 is empty
When I add document "xxxx" to the worklist
And I press "save"
Then I should see "xxxx"

Scenario: I cannot add the same document twice

Given I am logged in as "editor1"
And a worklist exists with id 3090
And worklist 3090 is empty
And I fill in "newWorkListItem.documentId" with "36"
And I press "Add a Worklist Item"
When I fill in "newWorkListItem.documentId" with "36"
And I press "Add a Worklist Item"
Then I should see "Duplicate entries not allowed in worklist"
And I press "save"
Then I should see "36" within "#workListItems" once

Scenario: I can remove a document from a worklist

Given I am logged in as "editor1"
And a worklist exists with id 3090
And worklist 3090 is empty
When I fill in "newWorkListItem.documentId" with "36"
And I press "Add a Worklist Item"
And I press "save"
And I press "Delete a Worklist Item"
And I press "save"
Then I should not see "36" within "#workListItems"

           
