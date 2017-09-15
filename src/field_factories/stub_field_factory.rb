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
        
        return field
    end
        
end
