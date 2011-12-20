Feature: Updating content

In order to add to existing documents
As a KMS Maintainer
I want to be able to modify existing documents


Scenario: I can update a doc
Given I am logged in as "editor1"
And a document with filename "xxxx.dita" exists with content
"""
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "http://docs.oasis-open.org/dita/v1.1/OS/dtd/topic.dtd">
<topic id="kbdoc" xml:lang="en-us">
    <title>Shopping for groceries</title>
    <body>
        <p>A sample document to test ditac rendering.</p>
    </body>
</topic>
"""
When I go to the homepage
And I follow "Edit content"
And I edit the "trunk" branch of the document with filename "xxxx.dita"
And I edit the content of the document to be
"""
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "http://docs.oasis-open.org/dita/v1.1/OS/dtd/topic.dtd">
<topic id="kbdoc" xml:lang="en-us">
    <title>Shopping for groceries</title>
    <body>
        <p>A simple document to test ditac rendering.</p>
    </body>
</topic>
"""
And I press "save" in the frame
Then I should see "A simple document" in the frame

           
