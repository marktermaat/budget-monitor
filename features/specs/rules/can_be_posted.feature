Feature: Rules can be posted

  Scenario: Post returns created object
    Given the following tags:
      | Id | Name |
      | 1  | tag1 |
    When I post the following rules:
      | Pattern     | Tag Id | Tag Name |
      | supermarket | 1      |          |
    Then I expect the result code 200
    And I expect the result rule:
      | Pattern     | Tag Id | Tag Name |
      | supermarket | 1      | tag1     |

  Scenario: A new tag name can be created
    When I post the following rules:
      | Pattern     | Tag Name |
      | supermarket | tag2     |
    Then I expect the result code 200
    And I expect the result rule:
      | Pattern     | Tag Name |
      | supermarket | tag2     |

  Scenario: Rules are validated
    When I post the following rules:
       | Tag Name |
       | tag2     |
    Then I expect the result code 400