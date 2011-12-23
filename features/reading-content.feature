Feature: Reading content

In order to know what existing documents contain
As a KMS Maintainer
I want to be able to read existing documents through the CRUD web interface


Scenario: I can view a doc's xml
Given I am logged in as "editor1"
And a document with filename "xxxx.dita" exists with content
"""
<topic id="kbdoc">
<title id="default">How can I contact the Support Center at each IU campus for help?
</title>
</topic>
"""
When I view the document with filename "xxxx.dita"
Then I should see "How can I contact the Support Center at each IU campus for help?" in the document text

           
