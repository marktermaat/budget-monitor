Feature: New transactions get analysed

  Scenario: Posted transactions get analysed
    Given that now is 2019-02-01T20:00:00Z
    And the following tags:
      | Id | Name |
      | 1  | tag1 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 1      |
    When I post the following transactions:
      | Timestamp | Description              | Account | Sign | Amount |
      | now       | Visit to the supermarket | Ing1    | plus | 100    |
    Then I expect the following tagged transactions:
      | Transaction Id | Tag Id |
      | latest         | 1      |

  Scenario: Posted CSV transactions get analysed
    Given that now is 2019-02-01T20:00:00Z
    And the following tags:
      | Id | Name |
      | 1  | tag1 |
    And the following rules:
      | Id | Pattern     | Tag Id |
      | 2  | supermarket | 1      |
    When I post the following transactions as csv:
      | lines |
      | "Datum","Naam / Omschrijving","Rekening","Tegenrekening","Code","Af Bij","Bedrag (EUR)","MutatieSoort","Mededelingen" |
      | "20181113","Visit to the supermarket","NL58INGB001","NL58INGB002","BA","Af","50,11","Betaalautomaat","Transactie:G200A1 Term:AAAA1" |
    Then I expect the following tagged transactions:
      | Transaction Id | Tag Id |
      | latest         | 1      |