Feature: Creating secrets

  Scenario: Alice can update the secret
    Given I am logged in as user Alice
    When I try to update the secret
    Then it is allowed

  Scenario: Harry cannot update the secret
    Given I am logged in as host Harry
    When I try to update the secret
    Then it is denied

  Scenario: Balthazar can fetch the secret
    Given I am logged in as host Balthazar
    When I try to fetch the secret
    Then it is allowed

  Scenario: Anonymous users cannot fetch secrets
    When I try to fetch the secret
    Then it is denied
