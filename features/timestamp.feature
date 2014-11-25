Feature: Timestamps
  So that I don't have to commit files every time I run a test
  As an application developer using license finder
  I want timestamps to indicate only meaningful changes.

  Scenario: No meaningful changes occur
    Given an actual ruby project
    When I run license_finder
    Then I note the timestamp from the html
    And I wait 10 minutes

    When I run license_finder
    Then the timestamp should not have changed
