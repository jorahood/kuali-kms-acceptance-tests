Feature: Editor creates a new doc
Possible scenarios: 

	Editor attends service meeting and learns of a service change that requires additional documentation
	Editor receives a comment from an end user about something undocumented
	Editor reads post to SC listserv concerning something new and undocumented.



These scenarios involve so much outside the KMS system itself that they are hard to differentiate as separate tests. So I'm going to start small with what I know can be done within the KMS.

Background:

Given I am logged in as "editor1"

Scenario: Editor can submit doc for Editor approval directly, bypassing the Owner approval workflow.

Given a document with filename "xaaa.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE topic PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:topic"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/topic/dtd/kbtopic.dtd">
<topic id="kbdoc">
  <title id="default">test default title</title>
  <prolog>
    <author type="creator">jorahood</author>
    <critdates>
      <created date="2008-09-12 12:22" user="mligget"/>
      <revised modified="2009-05-05 01:23" user="madalton"/>
      <approved modified="2011-05-25 23:21" user="bolte" note="just change the date every year"/>
      <expires modified="2011-06-04 10:34" expiry="2011-11-11 22:12" user="jthatche" note="because of that new thing"/>
    </critdates>
    <visibility view="visible"/>
    <docid id="xaaa"/>
    <owner>ONCOURSE-SME</owner>
  </prolog>
  <body>
    <p>First, try <xref href="http://google.com">Google</xref>.</p>
  </body>
</topic>
"""
When I submit the document
Then I should see document "xaaa.dita" in my action list

Scenario: Editor can submit doc for Owner approval

Given a document with filename "xaab.dita" exists with content
"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE topic PUBLIC "urn:pubid:org.kuali.kits.kms:doctypes:dita:topic"
"http://www.indiana.edu/~worklist/dita-prototypes/org.kuali.kits.kms/doctypes/topic/dtd/kbtopic.dtd">
<topic id="kbdoc">
  <title id="default">test default title</title>
  <prolog>
    <author type="creator">jorahood</author>
    <critdates>
      <created date="2008-09-12 12:22" user="mligget"/>
      <revised modified="2009-05-05 01:23" user="madalton"/>
      <approved modified="2011-05-25 23:21" user="bolte" note="just change the date every year"/>
      <expires modified="2011-06-04 10:34" expiry="2011-11-11 22:12" user="jthatche" note="because of that new thing"/>
    </critdates>
    <visibility view="visible"/>
    <docid id="xaab"/>
    <owner>ONCOURSE-SME</owner>
  </prolog>
  <body>
    <p>First, try <xref href="http://google.com">Google</xref>.</p>
  </body>
</topic>
"""
And user "sme1" is a member of the "ONCOURSE-SME" owner group
When I route the document for SME approval
And I impersonate user "sme1"
Then I should see document "xaab.dita" in my action list

           
