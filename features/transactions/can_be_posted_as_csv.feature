Feature: Transactions can be posted

  Scenario: Transaction returns created object
    Given that now is 2019-02-01T20:00:00Z
    When I post the following transactions as csv:
      | lines |
      | "Datum","Naam / Omschrijving","Rekening","Tegenrekening","Code","Af Bij","Bedrag (EUR)","MutatieSoort","Mededelingen" |
      | "20181113","ALBERT HEIJN","NL58INGB001","","BA","Af","50,11","Betaalautomaat","Transactie:G200A1 Term:AAAA1" |
    Then I expect the result code 200
    And I expect the result transaction:
      | Timestamp            | Description  | Sign  | Amount |
      | 2018-11-13T00:00:00Z | ALBERT HEIJN | minus | 50.11    |

  Scenario: Transactions are validated
    Given that now is 2019-02-01T20:00:00Z
    When I post the following transactions as csv:
      | lines |
      | "Datum","Naam / Omschrijving","Rekening","Tegenrekening","Code","Af Bij","Bedrag (EUR)","MutatieSoort","Mededelingen" |
      | "20181113",,"","","BA","Af","50,11","Betaalautomaat","Transactie:G200A1 Term:AAAA1" |
    Then I expect the result code 400

  Scenario: IDs are generated
    Given that now is 2019-02-01T20:00:00Z
    When I post the following transactions as csv:
      | lines |
      | "Datum","Naam / Omschrijving","Rekening","Tegenrekening","Code","Af Bij","Bedrag (EUR)","MutatieSoort","Mededelingen" |
      | "20181113","ALBERT HEIJN","NL58INGB001","","BA","Af","50,11","Betaalautomaat","Transactie:G200A1 Term:AAAA1" |
    Then I expect the generated ID to be a MD5 hash of the following fields:
      | Timestamp | Description | Amount |
      | 2018-11-13T00:00:00Z  | ALBERT HEIJN | 50.11    |