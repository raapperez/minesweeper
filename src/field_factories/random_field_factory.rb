require_relative "../cell"

class RandomFieldFactory
    
    def get_field(width, height, num_mines)
        field = []
        cells = []

        for i in 0..width-1
            field[i] = []
            for j in 0..height-1
                cell = Cell.new
                field[i][j] = cell
                cells.push(cell)
            end
        end

        put_bombs(cells, num_mines)
        put_neighbor_cells(field)

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

    def put_neighbor_cells(field)
        for i in 0..field.length-1
            for j in 0..field[i].length-1
                cell = field[i][j]

                for r in [0, i - 1].max..[i + 1, field.length - 1].min
                    for c in [0, j - 1].max..[j + 1, field[i].length - 1].min
                        neighbor_cell = field[r][c]
                        cell.add_neighbor_cell(neighbor_cell)
                    end
                end
            end
        end
    end

end