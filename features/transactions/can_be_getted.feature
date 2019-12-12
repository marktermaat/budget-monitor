Feature: Transactions can be getted

  Scenario: Transactions posted
    Given that now is 2019-02-01T20:00:00Z
    And the following transactions:
      | Timestamp | Description | Sign | Amount |
      | now       | Supermarked | plus | 100    |
    When I request all transactions
    Then I expect the result code 200
    And I expect the following transactions:
      | Timestamp | Description | Sign | Amount |
      | now       | Supermarked | plus | 100  |