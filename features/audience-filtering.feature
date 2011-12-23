Feature: Audience filtering

Background:
Given I am logged in as "editor1"

Scenario: I can see content filtered for audience kbstaff when I am audience kbstaff

Given a document with filename "kbstaff.ditaval" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<val>
  <!-- kbstaff sees everything, so include all audience-filtered content -->
  <prop action="include" att="audience" ></prop>
</val>
"""
And a document with filename "bbah.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE task PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:task"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/task/dtd/kbtask.dtd">
<task audience="default" id="kbdoc">
    <title id="default">How do I define the keys for all cross references in a topic in the DITA KB?</title>
  <taskbody>
        <steps>
          <step>
            <note audience="kbstaff">You need to run the xslt transformation</note>
            <cmd>With the topic or associated map open in the editor window, in the toolbar, select
            <uicontrol>Configure Transformation Scenario</uicontrol></cmd></step>
        </steps>
    </taskbody>
</task>
"""
When I preview the document with audience filter "kbstaff"
Then I should see "You need to run the xslt transformation" in the preview window

Scenario: I can not see content filtered for audience kbstaff when I am audience default

Given a document with filename "default.ditaval" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<val>
    <prop action="exclude" att="audience" ></prop>
    <prop action="include" att="audience" val="default" ></prop>
</val>
"""
And a document with filename "bbah.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE task PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:task"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/task/dtd/kbtask.dtd">
<task audience="default" id="kbdoc">
    <title id="default">How do I define the keys for all cross references in a topic in the DITA KB?</title>
  <taskbody>
        <steps>
          <step>
            <note audience="kbstaff">You need to run the xslt transformation</note>
            <cmd>With the topic or associated map open in the editor window, in the toolbar, select
            <uicontrol>Configure Transformation Scenario</uicontrol></cmd></step>
        </steps>
    </taskbody>
</task>
"""
When I preview the document with audience filter "default"
Then I should not see "You need to run the xslt transformation" in the preview window

           
