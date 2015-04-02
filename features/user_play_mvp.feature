Feature: MVP
  In order to play a simple game
  As a player
  I want to be able to place and fire at a ship

  Scenario: Homepage contains the board
    Given I visit the homepage
    Then I should see the board

  Scenario: Place Three Ships
    Given I visit the homepage
    And enter some coordinates
    When I press place
    Then i should see 'ships placed!'

  @ships_placed @two_ships_hit
  Scenario: Fire at all three ships
    Given i enter coordinates of ship "C1"
    When I press fire
    Then i should see 'hit'

  @ships_placed
  Scenario: Miss a Ship
    Given i enter coordinates where no ship
    When I press fire
    Then i should see 'miss'
    And i should be able to fire again

  @ships_placed @ship_missed
  Scenario: Have record of misses
    Then I should see my misses

  @ships_placed @two_ships_hit
  Scenario: When all ships are sunk, game ends, Player can start again
    Given i enter coordinates of ship "C1"
    When I press fire
    Then i should see "Game Over, Play again?"
    When i click "Play again?"
    Then I should be on the homepage

  @ships_placed
  Scenario: Once i've placed my ships i will see an empty board
  Then i should see the board

  @ships_placed
  Scenario: Once i've missed a ship I can see it on the board
  When i miss a ship
  Then i should see a "o" on the board

  @ships_placed
  Scenario: Once i've hit a ship I can see it on the board
  When i hit a ship
  Then i should see a "*" on the board