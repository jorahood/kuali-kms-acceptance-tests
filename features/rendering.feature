Feature: Rendering

For Scenario 1, rendering a DITA-OT sample document, I've gotten it passing with actual new documents, using new filenames for every test, and just now it is also passing for recycled documents. To get the "Given a document with filename "xxxx.dita" exists with content" step group to actually complete creating the document I had to add a step to the end to wait for the page to finish reloading, because otherwise when there was another identical creation step group following it for the .ditamap file the first creation of the .dita file would not complete. 

As far as the poller needing time to process the files, I've set the wait time as low as 5 seconds and still seen successful transformation. I've set it to 10 seconds for now. 

Background:
Given I am logged in as "editor1"

Scenario: I can render a DITA-OT sample document
Given a document with filename "xxaq.dita" exists with content
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
And a document with filename "xxaq.ditamap" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "http://docs.oasis-open.org/dita/v1.2/os/dtd1.2/technicalContent/dtd/map.dtd">
<map>
    <topicref keys="xxaq" href="xxaq.dita#kbdoc"></topicref>
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
                <topicref keyref="xxaq"></topicref>
            </relcell>
            <relcell></relcell>
            <relcell></relcell>
        </relrow>
    </reltable>
</map>
"""
When I preview the document with audience filter "default"
Then I should see "Tips on buying groceries." in the preview window

Scenario: I can render a specialized doc that doesn't reference any other documents
Given a document with filename "bbah.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE task PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:task"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/task/dtd/kbtask.dtd">
<task audience="default" id="kbdoc">
    <title id="default">How do I define the keys for all cross references in a topic in the DITA KB?</title>
    <shortdesc/>
  <prolog>
    <author>jorahood</author>
    <critdates>
      <created date=""/>
      <revised modified=""/>
    </critdates>
    <metadata>
      <keywords>
        <keyword></keyword>
      </keywords>
    </metadata>
    <docid id="bbah"/>
  </prolog>
  <taskbody>
        <steps>
          <step>
            <note>You need to run the xslt transformation that will add key definitions for all the
          refs in a map, as well as for all the kbhs, kbas, and boilers in the associated
          topic.</note>
            <cmd>With the topic or associated map open in the editor window, in the toolbar, select
            <uicontrol>Configure Transformation Scenario</uicontrol></cmd></step>
          <step>
            <cmd>In the <wintitle>Scenario type</wintitle> dropdown, select <option>Xml Transformation
              with XSLT</option>.</cmd>
          </step>
          <step>
            <cmd>Under <wintitle>User Defined Scenarios</wintitle>, select
              <option>contextualize</option> and click <uicontrol>Transform now</uicontrol>.</cmd>
            <stepresult>The keys necessary to render the topic will appear at the bottom of the topic's ditamap.</stepresult>
          </step>
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
Then I should see "You need to run the xslt transformation" in the preview window

Scenario: I can render a specialized doc, bawq, that references another document, bawf

Given a document with filename "bawf.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="xsl/contextualize.xsl"?>
<!DOCTYPE task PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:task"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/task/dtd/kbtask.dtd">
<task id="kbdoc">
  <title>How do I use the Subversion DITA repository?</title>
  <shortdesc>Connect to the Subversion repository and check out DITA docs using Oxygen's Subversion client</shortdesc>
  <prolog>
    <author>jorahood</author>
    <critdates>
      <created date="2010-03-11"/>
      <revised modified="2011-10-19"/>
    </critdates>
    <docid id="bawf"/>
  </prolog>
  <taskbody>
  </taskbody>
</task>
"""
And a document with filename "bawf.ditamap" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map
  PUBLIC "-//OASIS//DTD DITA Map//EN" "http://docs.oasis-open.org/dita/v1.2/os/dtd1.2/technicalContent/dtd/map.dtd">
<map id="kbdocmap">
  <topicgroup id="docidbox"><topicref audience="default" keys="bawf" href="bawf.dita" id="docid"/></topicgroup>
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
        <topicref keyref="bawf"/>
      </relcell>
      <relcell>
      </relcell>
    </relrow>
  </reltable>
<!--EVERYTHING BELOW THIS LINE IS GENERATED AUTOMATICALLY BY CONTEXTUALIZE.XSL.
        MANUAL CHANGES WILL BE OVERWRITTEN-->
<topicref href="deny.dita"/>
</map>
"""
And a document with filename "bawq.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE task PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:task" "http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/task/dtd/kbtask.dtd">
<task id="kbdoc">
  <title id="default">In Oxygen XML Editor, how do I add a new document to the DITA KB?</title>
  <shortdesc>Adding a new document to the DITA KB using Oxygen</shortdesc>
  <prolog>
    <author></author>
    <critdates>
      <created date=""/>
      <revised modified=""/>
    </critdates>
    <metadata>
      <keywords>
        <keyword></keyword>
      </keywords>
    </metadata>
    <docid id="bawq"/>
  </prolog>
  <taskbody>
    <prereq>You must have checked out the DITA Prototypes repository, and have the DITA KB Oxygen
      project open in Oxygen Editor. For instructions, see <kba keyref="bawf"/>
    </prereq>
    <steps>
      <step>
        <cmd>In the <wintitle>Project</wintitle> window, open the <uicontrol>dmm3</uicontrol>
          folder.</cmd>
      </step>
      <step>
        <cmd>Select <menucascade>
            <uicontrol>File</uicontrol>
            <uicontrol>New...</uicontrol>
        </menucascade> 
        </cmd>
      </step>
      <step>
        <cmd>In the <wintitle>New</wintitle> window, in the text box that says <systemoutput>Type
          filter text</systemoutput>, type <uicontrol>kbtopic</uicontrol> and press Enter.</cmd>
      </step>
      <step>
        <cmd>Select <menucascade>
            <uicontrol>File</uicontrol>
            <uicontrol>Save</uicontrol>
          </menucascade>
        </cmd>
      </step>
      <step>
        <cmd>Enter the four-letter docid for the topic.</cmd>
      </step>

      <step>
        <cmd>Verify that the <systemoutput>dmm3</systemoutput> directory is selected to save the
          file into and click <uicontrol>Save</uicontrol>.</cmd>
      </step>
      <step>
        <cmd>In the <wintitle>Project</wintitle> window, verify that the new file appears in the
            <uicontrol>dmm3</uicontrol> folder. If it doesn't, right-click within the
            <wintitle>Project</wintitle> window and select <uicontrol>Refresh</uicontrol>, and it
          should appear. </cmd>
      </step>
      <step><note>There is one indispensible piece of metadata for the topic, and that is the docid.</note>
      <cmd>To add the docid to the topic, in the <apiname>prolog</apiname> section, find the <apiname>docid</apiname> element, and enter the four-letter docid in the "id" attribute.</cmd></step>
      <step>
        <cmd>Save the file.</cmd>
      </step>
    </steps>
    <result>The new file is now saved on the server and added to the Oxygen project.</result>
  </taskbody>
</task>
"""
And a document with filename "bawq.ditamap" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map
  PUBLIC "-//OASIS//DTD DITA Map//EN" "http://docs.oasis-open.org/dita/v1.2/os/dtd1.2/technicalContent/dtd/map.dtd">
<map id="kbdocmap">
  <topicgroup id="docidbox"><topicref audience="default" keys="bawq" href="bawq.dita" id="docid"/></topicgroup>
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
        <topicref keyref="bawq"/>
      </relcell>
      <relcell>
      </relcell>
    </relrow>
  </reltable>
<!--EVERYTHING BELOW THIS LINE IS GENERATED AUTOMATICALLY BY CONTEXTUALIZE.XSL.
        MANUAL CHANGES WILL BE OVERWRITTEN-->
<topicref href="deny.dita"/>
<!--from topic: kba or term -->
<topicgroup conref="bawf.ditamap#docidbox"/>
</map>
"""
When I preview the document with audience filter "default"
Then I should see "How do I use the Subversion DITA repository?" in the preview window

           
