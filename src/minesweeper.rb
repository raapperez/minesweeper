require_relative "./field_factories/random_field_factory"

class  Minesweeper
    def initialize(width, height, num_mines, field_factory = RandomFieldFactory.new)
        if(width < 1)
            raise "Ivalid value for width"
        end

        if(height < 1)
            raise "Ivalid value for height"
        end

        if(width * height < num_mines)
            raise "The param num_mines must be lower than the number of cells (width * height)"
        end

        @width = width
        @height = height
        @num_mines = num_mines
        @field = field_factory.get_field(width, height, num_mines)

    end

    def width
        @width
    end

    def height
        @height
    end

    def num_mines
        @num_mines
    end

    def play(x, y)
        cell = @field[x][y]
        return cell.hit
    end

    def flag(x, y)
        cell = @field[x][y]
        return cell.flag
    end

    def still_playing?
        true
    end

    def victory?
        true
    end    

    def board_state(params)

    end
end