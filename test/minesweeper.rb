require_relative "../src/minesweeper"
require_relative "../src/cell_state"
require_relative "../src/field_factories/stub_field_factory"
require_relative "../src/printers/matrix_printer"
require "test/unit"

def create_bombs_matrix(width, height)
    field = []
    
    for y in 0..height-1
        field[y] = []
        for x in 0..width-1
            field[y][x] = false
        end
    end    

    return field
end

class TestMinesweeper < Test::Unit::TestCase

    def test_initialize
        width, height, num_mines = 10, 20, 30
        game = Minesweeper.new(width, height, num_mines)
        assert_equal(width, game.width)
        assert_equal(height, game.height)
        assert_equal(num_mines, game.num_mines)
    end

    def test_initialize_invalid_width
        width, height, num_mines = 0, 20, 30
        assert_raise do
        game = Minesweeper.new(width, height, num_mines)    
        end
    end

    def test_initialize_invalid_height
        width, height, num_mines = 10, 0, 30
        assert_raise do
        game = Minesweeper.new(width, height, num_mines)    
        end
    end

    def test_initialize_invalid_num_mines
        width, height, num_mines = 10, 20, 201
        assert_raise do
        game = Minesweeper.new(width, height, num_mines)    
        end
    end

    def test_initialize_invalid_field_factory
        width, height, num_mines = 10, 20, 30
        assert_raise do
        game = Minesweeper.new(width, height, num_mines, nil)    
        end
    end

    def test_still_playing
        width, height, num_mines = 10, 20, 30    
        game = Minesweeper.new(width, height, num_mines)
        assert_equal(true, game.still_playing?)
    end

    def test_game_1
        width, height = 4, 3

        bombs_matrix = create_bombs_matrix(width, height)
        bombs_matrix[0][0] = true
        bombs_matrix[1][0] = true
        bombs_matrix[2][0] = true
        bombs_matrix[0][1] = true
        bombs_matrix[2][1] = true
        bombs_matrix[0][2] = true
        bombs_matrix[1][2] = true
        bombs_matrix[2][2] = true
        bombs_matrix[1][3] = true

        game = Minesweeper.new(width, height, 9, StubFieldFactory.new(bombs_matrix))

        assert_equal(true, game.still_playing?)
        assert_equal(false, game.victory?)
        state = game.board_state()

        for y in 0..height-1
            for x in 0..width-1                
                assert_equal(CellState::UNKNOWN, state[y][x])
            end
        end

        assert_equal(true, game.play(1,1))
        assert_equal(false, game.play(1,1))
        assert_equal(false, game.flag(1,1))
        assert_equal(true, game.still_playing?)
        assert_equal(false, game.victory?)
        state = game.board_state()
        
        for y in 0..height-1
            for x in 0..width-1                
                if y == 1 && x ==1
                    assert_equal('8', state[y][x])    
                else
                    assert_equal(CellState::UNKNOWN, state[y][x])    
                end
            end
        end

        assert_equal(true, game.play(3, 0))
        assert_equal(false, game.play(3, 0))
        assert_equal(false, game.flag(3, 0))
        assert_equal(true, game.still_playing?)
        assert_equal(false, game.victory?)
        state = game.board_state()        

        for y in 0..height-1
            for x in 0..width-1                
                if y == 1 && x == 1
                    assert_equal('8', state[y][x])    
                elsif y == 0 && x == 3
                    assert_equal('3', state[y][x])    
                else
                    assert_equal(CellState::UNKNOWN, state[y][x])    
                end
            end
        end

        assert_equal(true, game.flag(2, 0))
        assert_equal(true, game.flag(2, 1))
        assert_equal(true, game.flag(3, 1))
        assert_equal(true, game.still_playing?)
        assert_equal(false, game.victory?)
        state = game.board_state()
        
        for y in 0..height-1
            for x in 0..width-1                
                if x == 1 && y == 1
                    assert_equal('8', state[y][x])    
                elsif x == 3 && y == 0
                    assert_equal('3', state[y][x])    
                elsif (x == 2 && y == 0) || (x == 2 && y == 1) || (x == 3 && y == 1)
                    assert_equal(CellState::FLAG, state[y][x])    
                else
                    assert_equal(CellState::UNKNOWN, state[y][x])    
                end
            end
        end

        assert_equal(true, game.play(3, 2))
        assert_equal(false, game.still_playing?)
        assert_equal(true, game.victory?)
        state = game.board_state()

        for y in 0..height-1
            for x in 0..width-1                
                if x == 1 && y == 1
                    assert_equal('8', state[y][x])    
                elsif (x == 3 && y == 0) || (x == 3 && y == 2)
                    assert_equal('3', state[y][x])    
                elsif (x == 2 && y == 0) || (x == 2 && y == 1) || (x == 3 && y == 1)
                    assert_equal(CellState::FLAG, state[y][x])
                else
                    assert_equal(CellState::UNKNOWN, state[y][x])    
                end
            end
        end

        state = game.board_state(xray: true)

        for y in 0..height-1
            for x in 0..width-1                
                if x == 1 && y == 1
                    assert_equal('8', state[y][x])    
                elsif (x == 3 && y == 0) || (x == 3 && y == 2)
                    assert_equal('3', state[y][x])    
                else
                    assert_equal(CellState::BOMB, state[y][x])    
                end
            end
        end
        
    end

    def test_game_2
        width, height = 4, 4

        bombs_matrix = create_bombs_matrix(width, height)
        bombs_matrix[0][0] = true
        bombs_matrix[3][3] = true

        game = Minesweeper.new(width, height, 2, StubFieldFactory.new(bombs_matrix))

        assert_equal(true, game.still_playing?)
        assert_equal(false, game.victory?)
        state = game.board_state()

        for y in 0..height-1
            for x in 0..width-1                
                assert_equal(CellState::UNKNOWN, state[y][x])
            end
        end

        assert_equal(true, game.play(0, 2))
        assert_equal(false, game.play(0, 2))        
        assert_equal(false, game.still_playing?)
        assert_equal(true, game.victory?)
        state = game.board_state()

        for y in 0..height-1
            for x in 0..width-1                
                if (x == 2 && y == 0) || (x == 3 && y == 0) || (x == 2 && y == 1) || (x == 3 && y == 1) || (x == 0 && y == 2) || (x == 1 && y == 2) || (x == 0 && y == 3) || (x == 1 && y == 3)
                    assert_equal(CellState::CLEAR, state[y][x])
                elsif (x == 1 && y == 0) || (x == 0 && y == 1) || (x == 1 && y == 1) || (x == 2 && y == 2) ||(x == 3 && y == 2) || (x == 2 && y == 3)
                    assert_equal('1', state[y][x])
                else
                    assert_equal(CellState::UNKNOWN, state[y][x])    
                end
            end
        end

        assert_equal(false, game.play(0, 0))  
        assert_equal(false, game.flag(0, 0))  
        state = game.board_state(xray: true)

        for y in 0..height-1
            for x in 0..width-1                
                if (x == 2 && y == 0) || (x == 3 && y == 0) || (x == 2 && y == 1) || (x == 3 && y == 1) || (x == 0 && y == 2) || (x == 1 && y == 2) || (x == 0 && y == 3) || (x == 1 && y == 3)
                    assert_equal(CellState::CLEAR, state[y][x])
                elsif (x == 1 && y == 0) || (x == 0 && y == 1) || (x == 1 && y == 1) || (x == 2 && y == 2) ||(x == 3 && y == 2) || (x == 2 && y == 3)
                    assert_equal('1', state[y][x])
                else
                    assert_equal(CellState::BOMB, state[y][x])    
                end
            end
        end

    end

end