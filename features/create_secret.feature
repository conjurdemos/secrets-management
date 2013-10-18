Feature: Creating secrets

  Scenario: Anonymous users cannot create secrets
    When I try to create a secret
    Then I am not authenticated

  Scenario: Alice can create a secret
    Given I am logged in as Alice
    When I try to create a secret
    Then it is allowed

  Scenario: Bob cannot create a secret
    Given I am logged in as Bob
    When I try to create a secret
    Then it is denied

  Scenario: Claire cannot create a secret
    Given I am logged in as Claire
    When I try to create a secret
    Then it is denied
    