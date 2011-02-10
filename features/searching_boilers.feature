@culerity
Feature: I can not search for text that is transcluded into a doc through a boiler

This feature documents that the KB does not index terms from transcluded content (boilers) in the target document

Scenario: searching text in a boiler
    When I search for "Corporation for Public Broadcasting" with audience="default" and domain="kbstaff"
    Then I should not see "tesk" within "results"

Scenario: quoted searching for text in boiler
    When I do a quoted search for "Corporation for Public Broadcasting" with audience="default" and domain="kbstaff"
    Then I should not see "tesk" within "results"

Scenario: searching a boiler that I am not authorized to see
    When I search for "Corporation for Public Broadcasting" with audience="default" and domain="testa"
    Then I should not see "tesk" within "results"

Scenario: search for text both in a boiler and in the title
    When I search for "Corporation for Public Broadcasting teskdefaultqline" with audience="default" and domain="kbstaff"
    Then I should not see "tesk" within "results"
