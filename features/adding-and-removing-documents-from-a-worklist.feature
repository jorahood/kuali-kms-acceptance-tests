Feature: Adding and removing documents from a worklist

Background:

Given I am logged in as "editor1"


Scenario: I can add a document to a worklist

Given a new worklist
When I add document "xxxx" to the worklist
And I save the worklist
Then I should see document "xxxx"

Scenario: I cannot add the same document twice

Given a new worklist
When I add document "xxxx" to the worklist
And I save the worklist
And I add document "xxxx" to the worklist
Then I should see "duplicate entries not allowed in worklist" in the frame
And I save the worklist
Then I should see document "xxxx" once


Scenario: I can remove a document from a worklist

Given a new worklist
When I add document "xxxx" to the worklist
And I save the worklist
And I remove document "xxxx" from the worklist
And I save the worklist
Then I should not see document "xxxx"

           
