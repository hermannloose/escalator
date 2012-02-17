Feature: Admin manages rotations

  As an admin
  In order to distribute responsibilities among users
  I want to create, edit and delete rotations

  Background: I am logged in as an admin
    Given I am logged in as an admin

  @wip
  Scenario Outline: adding a rotation
    When I add a rotation with name: "<name>"
    Then a rotation should exist with name: "<name>"

    Examples:
      | name          |
      | Demo Rotation |
      | abc           |
      | 123           |

  Scenario Outline: editing a rotation
    Given a rotation exists with name: "<original>"
    When I edit the rotation using name: "<edited>"
    Then the rotation's name should be "<edited>"
    And the rotation should be on the list of rotations

    Examples:
      | original      | edited               |
      | Demo Rotation | edited Demo Rotation |


  Scenario Outline: deleting a rotation
    Given a rotation exists with name: "<name>"
    When I delete the rotation
    Then a rotation should not exist with name: "<name>"
    And "<name>" should not be on the list of rotations

    Examples:
      | name          |
      | Demo Rotation |
