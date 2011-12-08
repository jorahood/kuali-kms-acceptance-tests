Feature: Sorting a worklist

In order to arrange documents in useful orders and switch between different orders
As a KMS maintainer
I want to be able to sort the documents in a worklist by any column in ascending and descending order, and by multiple columns

Background:

Given I am logged in as "editor1"

Scenario: Sorting on one column ascending and descending

Given the following documents exist with metadata:


| filename | author |
| xxxb  | bob |
| xxxa  | andy |
| xxxc  | chuck |


And a new worklist
And the worklist contains the following documents:


| filename |
| xxxa |
| xxxb |
| xxxc |


And the worklist displays the author column
When I sort the worklist by author
Then the documents should appear in this order:


| filename | author |
| xxxa | andy |
| xxxb | bob |
| xxxc | chuck |


And I sort the worklist by author
Then the documents should appear in this order:


| filename  | author |
| xxxc | chuck |
| xxxb | bob |
| xxxa | andy |



Scenario: Setting a default sort order for one column

And the following documents exist with metadata:


| id | author |
| 3950 | bob |


And a new worklist
And the worklist contains the following documents:


| id |
| 3950 |


And the worklist displays the author column
And I sort the worklist by author
And I set this sort order as default
When I sort the worklist by content id
And I reload the worklist
Then the worklist should be sorted by author

           
