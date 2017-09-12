
class Cell

    def initialize
        @has_flag = false
        @has_hit = false
        @has_bomb = false
        @neighbor_cells = []
    end

    def has_flag?
        @has_flag
    end

    def has_bomb?
        @has_bomb
    end
    
    def put_bomb
        @has_bomb = true
    end

    def add_neighbor_cell(neighbor_cell)
        @neighbor_cells.push(neighbor_cell)
    end

    def get_neighbor_bombs_num
        if !defined?(@neighbor_bombs_num)
            @neighbor_bombs_num = 0;

            for cell in @neighbor_cells
                if cell.has_bomb?
                    @neighbor_bombs_num += 1
                end
            end
        end

        return @neighbor_bombs_num
    end

    def hit
        if(@has_flag || @has_hit)
            return false
        end

        @has_hit = true

        if(!@has_bomb && get_neighbor_bombs_num == 0)
            for cell in @neighbor_cells
                cell.hit
            end
        end

        return true
    end
    
    def flag
        if(@has_hit)
            return false
        end

        @has_flag = !@has_flag

        return true
    end
end