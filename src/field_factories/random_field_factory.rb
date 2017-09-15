require_relative "../cell"

class RandomFieldFactory
    
    def get_field(width, height, num_mines)
        field = []
        cells = []

        for i in 0..height-1
            field[i] = []
            for j in 0..width-1
                cell = Cell.new
                field[i][j] = cell
                cells.push(cell)
            end
        end

        put_bombs(cells, num_mines)

        return field
    end

private
    
    def put_bombs(cells, num_mines)
        remaining_mines = num_mines
        
        while remaining_mines > 0
            position = rand(cells.length)
            cells[position].put_bomb
            cells.delete_at(position)
            remaining_mines -= 1
        end
    end

end