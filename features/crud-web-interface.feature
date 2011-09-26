Feature: CRUD web interface

In order to work with content in the KMS
As a KMS Maintainer
I want to interact with the KMS through a web interface

Scenario: I am asked to log in

When I go to the homepage
Then I should see "login"


Scenario: I can log in as an editor
When I go to the homepage
And I fill in "__login_user" with "editor1"
And I press "Login"
Then I should see "Logged in User"
And I should see "editor1"

           
