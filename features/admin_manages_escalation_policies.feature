Feature: Admin manages escalation policies

  As an admin
  In order to handle issues in different ways, distributing them among
    rotations and escalating them at different intervals
  I want to be able to create, edit and delete escalation policies

  Background: I am logged in as an admin
    Given I am logged in as an admin

  Scenario Outline: Adding an escalation policy
    When I add an escalation policy with name: "<name>"
    Then an escalation policy should exist with name: "<name>"
    And that escalation policy should be on the list of escalation policies

    Examples:
      | name                   |
      | Demo Escalation Policy |
      | abc                    |
      | 123                    |

  Scenario Outline: Editing an escalation policy
    Given an escalation policy exists with name: "<original>"
    When I edit the escalation policy using name: "<edited>"
    Then the escalation policy's name should be "<edited>"
    And the escalation policy should be on the list of escalation policies

    Examples:
      | original               | edited                        |
      | Demo Escalation Policy | edited Demo Escalation Policy |

  @celerity
  Scenario Outline: Deleting an escalation policy
    Given an escalation policy exists with name: "<name>"
    When I delete the escalation policy
    Then an escalation policy should not exist with name: "<name>"
    And "<name>" should not be on the list of escalation policies

    Examples:
      | name                   |
      | Demo Escalation Policy |
