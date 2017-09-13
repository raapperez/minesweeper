require_relative "./field_factories/random_field_factory"

class  Minesweeper
    def initialize(width, height, num_mines, field_factory = RandomFieldFactory.new)
        if width < 1
            raise "Ivalid value for width"
        end

        if height < 1
            raise "Ivalid value for height"
        end

        if width * height < num_mines
            raise "The param num_mines must be lower than the number of cells (width * height)"
        end

        if !defined?(field_factory) || !defined?(field_factory.get_field)
            raise "Invalid field_factory"
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
        if !still_playing?
            return false
        end

        cell = @field[y][x]
        return cell.hit
    end

    def flag(x, y)
        if !still_playing?
            return false
        end

        cell = @field[y][x]
        return cell.flag
    end

    def still_playing?
        result = false

        for array in @field
            for cell in array
                if cell.has_hit? && cell.has_bomb?
                    return false # Hit a bomb
                end

                if !cell.has_bomb? && !cell.has_hit? && !cell.has_flag?
                    result = true # There is still a not hit cell without bomb and flag
                end
            end
        end

        return result
    end

    def victory?
        if still_playing?
            return false
        end

        for array in @field
            for cell in array
                if cell.has_hit? && cell.has_bomb?
                    return false
                end
            end
        end

        return true
    end    

    def board_state(params = {})

        xray = params[:xray] == true && !still_playing?

        state = []

        for array in @field
            state.push(array.map { |cell| cell.get_state(xray) })            
        end

        return state;
    end
end