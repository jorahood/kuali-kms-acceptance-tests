@culerity
Feature: Worklists provide options to customize their behavior

Scenario: Inactivation timer defaults to 90 days
  Given I create a test templist
  Then I should see "90" within ".inactivation"

@cleanuplist
Scenario: I can customize the inactivation to any length of time
  Given I create a test list
  When I fill in "inactivate_after" with "60"
  And I press "Save options"
  Then I should see "60" within ".inactivation"