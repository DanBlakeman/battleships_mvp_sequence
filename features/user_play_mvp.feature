Feature: MVP
  In order to play a simple game
  As a player
  I want to be able to place and fire at a ship

  Scenario: Place Ship
    Given I visit the homepage
    And enter some coordinates
    When I press place
    Then i should see 'ship placed!'

  @ship_placed
  Scenario: Fire at Ship
    Given i enter coordinates of a ship
    When I press fire
    Then i should see 'hit'

  @ship_placed
  Scenario: Miss a Ship
    Given i enter coordinates where no ship
    When I press fire
    Then i should see 'miss'
    And i should be able to fire again