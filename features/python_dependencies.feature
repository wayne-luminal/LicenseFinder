Feature: Tracking Python Dependencies
  So that I can track Python dependencies
  As an application developer using license finder
  I want to be able to manage Python dependencies

  Scenario: See the dependencies from the requirements file
    Given a requirements file with a dependency "argparse==1.2.1"
    When I run license_finder
    Then I should only see a license "argparse, 1.2.1, Python Software Foundation License"
