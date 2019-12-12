Feature: Transactions can be posted

  Scenario: Transaction returns created object
    Given that now is 2019-02-01T20:00:00Z
    When I post the following transactions:
      | Timestamp | Description | Sign | Amount |
      | now       | Supermarked | plus | 100    |
    Then I expect the result code 200
    And I expect the result transaction:
      | Timestamp | Description | Sign | Amount |
      | now       | Supermarked | plus | 100    |

  Scenario: Transactions are validated
    Given that now is 2019-02-01T20:00:00Z
    When I post the following transactions:
      | Timestamp | Description |
      | now       |             |
    Then I expect the result code 400

  Scenario: IDs are generated
    Given that now is 2019-02-01T20:00:00Z
    When I post the following transactions:
      | Timestamp | Description | Sign | Amount |
      | now       | supermarket | plus | 100    |
    Then I expect the generated ID to be a MD5 hash of the following fields:
      | Timestamp | Description | Amount |
      | now       | supermarket | 100    |