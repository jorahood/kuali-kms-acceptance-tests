Feature: Audience filtering

Background:

Given I am logged in as "editor1"

Scenario: I can see content filtered for audience kbstaff when I am audience kbstaff

Given a document with filename "kbstaff.ditaval" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<val>
<!&#45; kbstaff sees everything, so include all audience-filtered content &#45;>
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
And a document with filename "bbah.ditamap" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map
PUBLIC "-//OASIS//DTD DITA Map//EN" "http://docs.oasis-open.org/dita/v1.2/os/dtd1.2/technicalContent/dtd/map.dtd">
<map id="kbdocmap">
<topicgroup id="docidbox"><topicref audience="default" keys="bbah" href="bbah.dita" id="docid"/></topicgroup>
<reltable>
<relheader>
<relcolspec linking="sourceonly">
<title>Source</title>
</relcolspec>
<relcolspec linking="targetonly">
<title>Refs</title>
</relcolspec>
</relheader>
<relrow>
<relcell>
<topicref keyref="bbah"/>
</relcell>
<relcell>
</relcell>
</relrow>
</reltable>

<!--EVERYTHING BELOW THIS LINE IS GENERATED AUTOMATICALLY BY CONTEXTUALIZE.XSL.
MANUAL CHANGES WILL BE OVERWRITTEN-->
</map>
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
And a document with filename "bbah.ditamap" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map
PUBLIC "-//OASIS//DTD DITA Map//EN" "http://docs.oasis-open.org/dita/v1.2/os/dtd1.2/technicalContent/dtd/map.dtd">
<map id="kbdocmap">
<topicgroup id="docidbox"><topicref audience="default" keys="bbah" href="bbah.dita" id="docid"/></topicgroup>
<reltable>
<relheader>
<relcolspec linking="sourceonly">
<title>Source</title>
</relcolspec>
<relcolspec linking="targetonly">
<title>Refs</title>
</relcolspec>
</relheader>
<relrow>
<relcell>
<topicref keyref="bbah"/>
</relcell>
<relcell>
</relcell>
</relrow>
</reltable>

<!--EVERYTHING BELOW THIS LINE IS GENERATED AUTOMATICALLY BY CONTEXTUALIZE.XSL.
MANUAL CHANGES WILL BE OVERWRITTEN-->
</map>
"""
When I preview the document with audience filter "default"
Then I should see "With the topic or associated map" in the preview window
But I should not see "You need to run the xslt transformation" in the preview window

           
