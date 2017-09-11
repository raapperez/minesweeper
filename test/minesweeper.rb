require_relative "../src/minesweeper"
require "test/unit"

class TestMinesweeper < Test::Unit::TestCase

def test_initialize
    width, height, num_mines = 10, 20, 30
    game = Minesweeper.new(width, height, num_mines)
    assert_equal(width, game.width)
    assert_equal(height, game.height)
    assert_equal(num_mines, game.num_mines)
end

def test_still_playing?
    width, height, num_mines = 10, 20, 30    
    game = Minesweeper.new(width, height, num_mines)
    assert_equal(true, game.still_playing?)
end

end