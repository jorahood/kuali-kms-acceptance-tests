Feature: Sorting a worklist

In order to arrange documents in useful orders and switch between different orders
As a KMS maintainer
I want to be able to sort the documents in a worklist by any column in ascending and descending order, and by multiple columns

Scenario: Sorting on one column ascending and descending
Given I am logged in as "editor1"
And the following documents exist with metadata:


| id | author |
| 3950 | bob |
| 3948 | andy |
| 3949 | chuck |


And a new worklist
And the worklist contains the following documents:


| id |
| 3950 |
| 3948 |
| 3949 |


And the worklist displays the author column
When I sort the worklist by author
Then the documents should appear in this order:


| id | author |
| 3948 | andy |
| 3950 | bob |
| 3949 | chuck |


And I sort the worklist by author
Then the documents should appear in this order:


| id | author |
| 3949 | chuck |
| 3950 | bob |
| 3948 | andy |



Scenario: Setting a default sort order for one column

Given the worklist contains the following documents:


| id |
| 3950 |


And the worklist displays the author column
And I sort the worklist by author
And I set this sort order as default
When I sort the worklist by content id
And I reload the worklist
Then the worklist should be sorted by author

           
