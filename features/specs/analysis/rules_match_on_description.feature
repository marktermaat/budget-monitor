Feature: Rules match on description

  Scenario: A transaction with a pattern match in the description
    Given that now is 2019-02-01T20:00:00Z
    And the following tags:
      | Id | Name |
      | 1  | tag1 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | test        | 1      |
    And the following transactions:
      | Timestamp | Description                     | Account | Sign | Amount |
      | now       | A test visit to the supermarket | Ing1    | plus | 100    |
    When I run the analysis
    Then I expect the following tagged transactions:
      | Transaction Id | Tag Id |
      | latest         | 1      |

  Scenario: A transaction without a pattern match in the description
    Given that now is 2019-02-01T20:00:00Z
    And the following tags:
      | Id | Name |
      | 1  | tag1 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | test        | 1      |
    And the following transactions:
      | Timestamp | Description                     | Account | Sign | Amount |
      | now       | A tst visit to the supermarket  | Ing1    | plus | 100    |
    When I run the analysis
    Then I expect not tags for the latest transaction