Feature: Sage will exist on Cowhorn

In order to get a new KB
As a KB Editor
I want to see that the Sage software project exists


Scenario: Sage has a web address that it responds to

When I open https://test.uisapp2.iu.edu/sage-stg/
Then I should see "Hello"

Scenario: Sage will display live KB documents

When I open https://test.uisapp2.iu.edu/sage-stg/KBServlet?action=getdoc&amp;docid=ddud
Then I should see "cool changes to a document"

Scenario: Sage will translate live KB documents into DITA

When I open https://test.uisapp2.iu.edu/sage-stg/KBServlet?action=getdoc&amp;docid=ddud
Then I should see "ddud" within "dita"

Scenario: Sage will translate boiler tags into div tags with conref attributes

When I open https://test.uisapp2.iu.edu/sage-stg/KBServlet?action=getdoc&amp;docid=aala
Then I should see "UISO" within "div[conref]"

Scenario: Sage has a search engine

When I open http://cowhorn.uits.indiana.edu:8080/webapp/TestApp/search

Scenario: I can search Sage

When I open http://cowhorn.uits.indiana.edu:8080/webapp/TestApp/search
And I fill in "terms" with "cool changes to a document"
And I press "Submit"
Then I should see "Search Results"

Scenario: I can do boolean search

When I open http://cowhorn.uits.indiana.edu:8080/webapp/TestApp/search
And I fill in "terms" with "cool changes to a document"
And I press "Submit"
Then I should see "Search Results"

Scenario: I can do quoted search

When I open http://cowhorn.uits.indiana.edu:8080/webapp/TestApp/search
And I fill in "terms" with "cool changes to a document"
And I press "Submit"
Then I should see "Search Results"

           
    