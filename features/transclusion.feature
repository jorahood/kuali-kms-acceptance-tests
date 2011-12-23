Feature: Transclusion
In order to not write the same content twice
As a KB Editor
I want to transclude content from one source to multiple targets


Background:
Given I am logged in as "editor1"

Scenario: boiler usage
Given a document with filename "boilers-task.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE task PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:task"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/task/dtd/kbtask.dtd">
<task id="box">
  <title id="default">A container task for boilers</title>
  <taskbody>
    <prereq id="must-create-topic-and-map">You must have created a new topic and its ditamap in the DITA KB.</prereq>
  </taskbody>
</task>
"""
And a document with filename "bawt.ditamap" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map
  PUBLIC "-//OASIS//DTD DITA Map//EN" "http://docs.oasis-open.org/dita/v1.2/os/dtd1.2/technicalContent/dtd/map.dtd">
<map id="kbdocmap">
  <topicgroup id="docidbox"><topicref audience="default" keys="bawt" href="bawt.dita" id="docid"/></topicgroup>
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
        <topicref keyref="bawt"/>
      </relcell>
      <relcell>
      </relcell>
    </relrow>
  </reltable>
<!-- EVERYTHING BELOW THIS LINE IS GENERATED AUTOMATICALLY BY CONTEXTUALIZE.XSL.
        MANUAL CHANGES WILL BE OVERWRITTEN -->
<topicref href="deny.dita"/>
<!-- from topic: boiler -->
<topicgroup conref="boilers-task.ditamap#must-create-topic-and-map"/>
</map>
"""
And a document with filename "bawt.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE task PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:task"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/task/dtd/kbtask.dtd">
<task id="kbdoc">
  <title id="default">How do I create Refs for a topic in the DITA KB?</title>
  <taskbody>
   <prereq conref="boilers-task.dita#box/must-create-topic-and-map"/>
  </taskbody>
</task>
"""
When I preview the document with audience filter "default"
Then I should see "You must have created a new topic and its ditamap in the DITA KB." in the preview window

           
