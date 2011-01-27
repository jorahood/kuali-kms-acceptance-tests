Feature: Searching text in alt q-lines
  In order to understand how searching in the current KB works, we want to try searching
  for text that appears only in alternate q-lines (titles).

  Scenario: Searching with audience=default finds text in altqs for other audiences
    Given I am at "https://kb.iu.edu"
    When I fill in "search" with "jagtag basics"
    And I press "Search"
    Then I should see "At IUPUI, what is a Jagtag and where do I get one?"

  Scenario: Searching with audience=oncoursecl finds text in mainq

  Scenario: Searching with audience=oncoursecl finds text in mainq

  Scenario: Searching with audience=oncoursecl finds text in oncoursecl altq
