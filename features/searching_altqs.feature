Feature: Searching text in alt q-lines
  In order to understand how searching in the current KB works, we want to try searching
  for text that appears only in alternate q-lines (titles).

  @culerity
  Scenario Outline: Searching with audience=default finds text in altqs for other audiences
    Given I am using "https://kb.iu.edu"
    And I go to the homepage
    When I fill in "search" with "<terms>"
    And I press "Search"
    Then I should see doc <result_doc>
    But when I get the xml for doc <result_doc>
    Then there are not all of "<terms>" in the default qline, body or xtras

    Examples:
      | terms                                        | only in altq for | result_doc |
      | jagtag basics                                | ose              | aavs       |
      | Sakai Discussion tool delete discussion item | sakai            | atdk       |
      | Adding, editing, or deleting Schedule items  | oncoursecl       | aqyn       |

  Scenario: Searching with audience=oncoursecl finds text in mainq

  Scenario: Searching with audience=oncoursecl finds text in mainq

  Scenario: Searching with audience=oncoursecl finds text in oncoursecl altq
