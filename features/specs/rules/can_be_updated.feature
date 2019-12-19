Feature: Rules can be updated

  Scenario: Updating pattern
    Given the following tags:
      | Id | Name |
      | 1  | tag1 |
      | 2  | tag2 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 1      |
    When I update the following rule:
      | Id | Pattern     | Tag Id |
      | 2  | new pattern | 1      |
    Then I expect the following rules in the database:
      | Id | Pattern     | Tag Id | Tag Name |
      | 2  | new pattern | 1      | tag1     |

  Scenario: Updating tag
    Given the following tags:
      | Id | Name |
      | 1  | tag1 |
      | 2  | tag2 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 1      |
    When I update the following rule:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 2      |
    Then I expect the following rules in the database:
      | Id | Pattern     | Tag Id | Tag Name |
      | 2  | supermarket | 2      | tag2     |

  Scenario: Unknown rule
    When I update the following rule:
      | Id | Pattern     | Tag Id |
      | 1  | supermarket | 2      |
    Then I expect the result code 404