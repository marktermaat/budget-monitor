Feature: Transactions can be posted

  Scenario: Transactions posted
    Given that now is 2019-02-01T20:00:00Z
    When I post the following transactions:
      | Timestamp | Description |
      | now       | Supermarked |
    Then I expect the following transactions:
      | Timestamp | Description |
      | now       | Supermarked |