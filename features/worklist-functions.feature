Feature: Worklist functions
Further scenarios to work on: 

	An Editor can request owner approval for multiple documents
	I can approve multiple documents
	I can publish a document
	I can publish multiple documents



Scenario: An Editor can request owner approval for a document
Given that I am logged in as "editor1"
And a new worklist
And the worklist contains document "xaaf"
When I select document "xaaf"
And I request owner approval for selected documents
And I impersonate user "sme1"
Then I should see document "xaaf" in my action list

Scenario: An Editor can approve a document
Given that I am logged in as "editor1"
And a new worklist
And the worklist contains document "xaag"
When I select document "xaag"
And I approve selected documents
Then I should see document "xaag" in my action list

           
