Feature: KBSS
KBSS: KB Super Search, the internal filtering mechanism for power users like editors to find content by any means necessary. This is not the public facing search engine.

Background:

Given I am logged in as "editor1"

Scenario: I can search on document content

Given a document with filename "xaai.dita" contains the word "splunge"
When I search for documents containing content "splunge"
Then I should see document "xaai.dita" in the search results

           
