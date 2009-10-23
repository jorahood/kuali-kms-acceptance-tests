Feature: Teragrid can search for Inca errors
In order to allow Inca users to find useful information on error messages from Inca
As a Teragrid Service Provider
I want to search for specific Inca errors through an interface that allows optional search terms

Scenario: Unsuccessful searches for specific error messages should at least return the general Inca errors page
Given I open http://staging.teragrid.org/cgi-bin/kb.cgi
When I fill in "terms" with "grid.kitregistration.unit or common inca errors" 
And I press "Go"
Then I should see "Search Results" within "title"
And I should see "Common Inca errors on the TeraGrid, and their solutions" within "div#content ul"

Scenario: Successful Searches for specific error messages should also return the general Inca errors page
Given I open http://staging.teragrid.org/cgi-bin/kb.cgi
When I fill in "terms" with "ctss-core error or common inca errors" 
And I press "Go"
Then I should see "Search Results" within "title"
And I should see "Common Inca errors on the TeraGrid, and their solutions" within "div#content ul"
And I should see "What is PMEMD, and where is it installed on the TeraGrid?" within "div#content ul"

Scenario: There should be no duplicated search returns
Given I open http://staging.teragrid.org/cgi-bin/kb.cgi
When I fill in "terms" with "common inca errors or common inca errors" 
And I press "Go"
Then I should see "Search Results" within "title"
And I should see "Common Inca errors on the TeraGrid, and their solutions" within "div#content ul" once

           
    