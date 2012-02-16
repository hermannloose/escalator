Feature: Admin manages escalation policies

  As an admin
  In order to handle issues in different ways, distributing them among
    rotations and escalating them at different intervals
  I want to be able to create, edit and delete escalation policies

  Background: I am logged in as an admin
    Given I am logged in as an admin

  @wip
  Scenario: Adding an escalation policy
    When I add an escalation policy
    Then the escalation policy should exist

  @wip
  Scenario: Editing an escalation policy
    Given an escalation policy exists
    When I edit the escalation policy
    Then I should see those changes

  @wip
  Scenario: Deleting an escalation policy
    Given an escalation policy exists
    When I delete the escalation policy
    Then the escalation policy should not exist
