Feature: Rendering

Background:
Given I am logged in as "editor1"

Scenario: I can render a DITA-OT sample document
Given a document with filename "xxag.dita" exists with content
"""
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "http://docs.oasis-open.org/dita/v1.1/OS/dtd/topic.dtd">
<topic id="kbdoc" xml:lang="en-us">
    <title>Shopping for groceries</title>
    <shortdesc>Tips on buying groceries.</shortdesc>
    <prolog>
        <author type="creator">Tom McIntyre</author>
        <copyright>
            <copyryear year="2007" ></copyryear>
            <copyrholder>Acme Company</copyrholder>
        </copyright>
        <critdates>
            <created date="2006-August-07" ></created>
            <revised modified="2007-March-18" ></revised>
        </critdates>
        <metadata>
            <keywords>
                <keyword>grocery shopping</keyword>
            </keywords>
        </metadata>
    </prolog>
    <body>
        <p>A sample document to test ditac rendering.</p>
    </body>
</topic>
"""
And a document with filename "xxag.ditamap" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "http://docs.oasis-open.org/dita/v1.2/os/dtd1.2/technicalContent/dtd/map.dtd">
<map>
    <topicref keys="xxxx" href="xxxx.dita#kbdoc"></topicref>
    <reltable>
        <relheader>
            <relcolspec type="topic" linking="sourceonly">
                <title>Source</title>
            </relcolspec>
            <relcolspec type="task" linking="targetonly">
                <title>Refs</title>
            </relcolspec>
            <relcolspec type="glossentry" linking="targetonly">
                <title>Hotitems</title>
            </relcolspec>
        </relheader>
        <relrow>
            <relcell>
                <topicref keyref=""></topicref>
            </relcell>
            <relcell></relcell>
            <relcell></relcell>
        </relrow>
    </reltable>
</map>
"""
When I preview the document
Then I should see "Tips on buying groceries." in the preview window

Scenario: I can render a specialized doc that doesn't reference any other documents

Scenario: I can render a specialized doc that references other documents

           
