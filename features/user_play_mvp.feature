Feature: MVP
  In order to play a simple game
  As a player
  I want to be able to place and fire at a ship

  Scenario: Place Ships
    Given I visit the homepage
    And enter some coordinates
    When I press place
    Then i should see 'ships placed!'

  @ship_placed
  Scenario: Fire at all ships
    Given i enter coordinates of ship "A1"
    When I press fire
    Then i should see 'hit'
    Given i enter coordinates of ship "B1"
    When I press fire
    Then i should see 'hit'
    Given i enter coordinates of ship "C1"
    When I press fire
    Then i should see 'hit'

  @ship_placed
  Scenario: Miss a Ship
    Given i enter coordinates where no ship
    When I press fire
    Then i should see 'miss'
    And i should be able to fire again

  @ship_placed @ship_missed
  Scenario: Have record of misses
    Then I should see my misses

  @ship_placed
  Scenario: All ships sunk, won game
