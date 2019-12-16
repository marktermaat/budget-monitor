Feature: Tags can be getted

  Scenario: Retrieving tags
    Given the following tags:
      | Id | Name |
      | 1  | tag1 |
    When I request all tags
    Then I expect the result code 200
    And I expect the following tags:
      | Id | Name |
      | 1  | tag1 |