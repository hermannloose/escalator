Feature: Admin manages escalation policies

  As an admin
  In order to handle issues in different ways, distributing them among
    rotations and escalating them at different intervals
  I want to be able to create, edit and delete escalation policies

  Background: I am logged in as an admin
    Given I am logged in as an admin

  Scenario: Adding an escalation policy
    When I add an escalation policy with name: "foobar"
    Then an escalation policy should exist with name: "foobar"
    And that escalation policy should be on the list of escalation policies

  Scenario: Editing an escalation policy
    Given an escalation policy exists
    When I edit the escalation policy using name: "barfoo"
    Then the escalation policy's name should be "barfoo"
    And the escalation policy should be on the list of escalation policies

  @celerity
  Scenario: Deleting an escalation policy
    Given an escalation policy exists with name: "barbaz"
    When I delete the escalation policy
    Then an escalation policy should not exist with name: "barbaz"
    And "barbaz" should not be on the list of escalation policies
