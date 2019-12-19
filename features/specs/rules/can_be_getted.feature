Feature: Rules can be getted

  Scenario: Retrieving rules
    Given the following tags:
      | Id | Name |
      | 1  | tag1 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 1      |
    When I request all rules
    Then I expect the result code 200
    And I expect the following rules:
      | Id | Pattern     | Tag Id | Tag Name |
      | 2  | supermarket | 1      | tag1     |