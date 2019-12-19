Feature: Rules can be deleted

  Scenario: Deleting pattern
    Given the following tags:
      | Id | Name |
      | 1  | tag1 |
      | 2  | tag2 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 1      |
    When I delete rule 2
    Then I expect 0 rules in the database

  Scenario: Unknown rule
    When I delete rule 1
    Then I expect the result code 404