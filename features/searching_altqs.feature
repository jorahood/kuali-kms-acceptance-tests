@culerity
Feature: Searching text filtered by audience or domain
  In order to understand how searching in the current KB works, we want to try searching
  for text that appears only in alternate q-lines (titles), and in sections restricted to certain client domains (kbsecure).

  Scenario Outline: All of a doc's qlines are always searched regardless of the client's audience the client declares
    When I search for "<query>" with audience="default" and domain="kbstaff"
    Then I should see "tesk" within "results"

    Examples:
      | query               |
      | teskoncourseclqline |
      | teskoseqline        |
      | tesksakaiqline      |

  Scenario Outline: Content within filtered elements is searched even when that element is not viewable from the client's domain
    When I search for "<term>" with audience="default" and domain="testa"
    Then I should see "tesk" within "results"
    But I get the xml for doc "tesk" with audience="default" and domain="testa"
    Then I should not see "term"

    Examples:
      | term              |
      | teskwhokbstaff    |
      | teskwhooncoursecl |
      | teskwhosakai-all  |
      | teskwhoose        |

  Scenario Outline: Content in documents that are not viewable from the client's domain is not searched
    When I search for "teskdefaultqline" with audience="default" and domain="<domain>"
    Then I should not see "tesk" within "results"

    Examples:
      | domain     |
      | oncoursecl |
      | sakai-all  |
      | ose        |
