Feature: Visibility filtering

Background:

Scenario: As an un-logged-in end-user, I can search for content with visibility = visible

Given a document with visibility of "visible"
When I search the KB for the document
Then I should see the document in the results

Scenario: As an un-logged-in end-user, I cannot search for content with visibility = invisible

Given a document with visibility of "invisible"
When I search the KB for the document
Then I should not see the document in the results

Scenario: As an un-logged-in end-user, I cannot search for but can see content with visibility = draft

Given I am not logged in
Given a document with visibility of "draft"
When I search the KB for the document
Then I should not see the document in the results
But I should be able to open the document in the KB.
And the document should say "DRAFT" in front of the title

Scenario: As an un-logged-in end-user, I cannot search for but can see content with visibility = nosearch

Given I am not logged in
Given a document with visibility of "draft"
When I search the KB for the document
Then I should not see the document in the results
But I should be able to open the document in the KB.

           
