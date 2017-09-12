require_relative "../src/cell"
require "test/unit"

class TestCell < Test::Unit::TestCase

    def test_get_neighbor_bombs_num

        cell = Cell.new

        for i in 0..7
            neighbor_cell = Cell.new
            if i % 2 == 0
                neighbor_cell.put_bomb
            end
            cell.add_neighbor_cell(neighbor_cell)
        end

        assert_equal(4, cell.get_neighbor_bombs_num)
        assert_equal(4, cell.get_neighbor_bombs_num)
        
    end

    def test_flag
        cell = Cell.new

        assert_equal(false, cell.has_flag?)
        assert_equal(true, cell.flag)
        assert_equal(true, cell.has_flag?)
        assert_equal(false, cell.hit) # Cannot hit cell with flag
        assert_equal(true, cell.flag)
        assert_equal(true, cell.hit) # Ok hit without flag
        assert_equal(false, cell.has_flag?)
        assert_equal(false, cell.hit) # Cannot hit cell again
        assert_equal(false, cell.flag) # Cannot flag discovered flag

    end

end