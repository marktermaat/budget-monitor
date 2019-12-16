Feature: Rules can be getted

  Scenario: Updating pattern
    Given the following tags:
      | Id | Name |
      | 1  | tag1 |
      | 2  | tag2 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 1      |
    And I update the following rule:
      | Id | Pattern     | Tag Id |
      | 2  | new pattern | 1      |
    When I request all rules
    And I expect the following rules:
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
    And I update the following rule:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 2      |
    When I request all rules
    And I expect the following rules:
      | Id | Pattern     | Tag Id | Tag Name |
      | 2  | supermarket | 2      | tag2     |