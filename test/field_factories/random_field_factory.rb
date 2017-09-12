require_relative "../../src/field_factories/random_field_factory"
require "test/unit"

class TestRandomFieldFactory < Test::Unit::TestCase

    def test_get_field

        width, height, num_mines = 10, 20, 30    
        field_factory = RandomFieldFactory.new

        field = field_factory.get_field(width, height, num_mines)
        
        assert_equal(height, field.length)

        mines = 0

        for array in field
            assert_equal(width, array.length)
            for cell in array
                if cell.has_bomb?
                    mines += 1
                end
            end        
        end

        assert_equal(num_mines, mines)

    end

end