
class Cell

    def initialize
        @has_bomb = false
        @neighbor_cells = []
    end
    
    def put_bomb
        @has_bomb = true
    end

    def add_neighbor_cell(neighbor_cell)
        @neighbor_cells.push(neighbor_cell)
    end

    def has_bomb?
        @has_bomb
    end
end