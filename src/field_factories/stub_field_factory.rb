require_relative "../cell"

class StubFieldFactory

    def initialize(bombs_matrix)
        @bombs_matrix = bombs_matrix
    end

    def get_field(width, height, num_mines)

        height = @bombs_matrix.length
        width = @bombs_matrix.first.length

        field = []

        for i in 0..height-1
            field[i] = []
            for j in 0..width-1
                cell = Cell.new
                field[i][j] = cell
                if @bombs_matrix[i][j]
                    field[i][j].put_bomb
                end
            end
        end

        put_neighbor_cells(field)

        return field
    end

    private

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
