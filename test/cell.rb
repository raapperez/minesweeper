require_relative "../src/cell"
require "test/unit"

class TestCell < Test::Unit::TestCase

    def test_get_neighbor_bombs_num

        cell = Cell.new

        for i in 0..7
            neighbor_cell = Cell.new
            if(i % 2 == 0)
                neighbor_cell.put_bomb
            end
            cell.add_neighbor_cell(neighbor_cell)
        end

        assert_equal(4, cell.get_neighbor_bombs_num)
        assert_equal(4, cell.get_neighbor_bombs_num)
        
    end

end