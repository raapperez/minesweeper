
require_relative "./cell_state"

class Cell

    def initialize(has_flag = false, has_hit = false, has_bomb = false)
        @has_flag = has_flag
        @has_hit = has_hit
        @has_bomb = has_bomb
        @neighbor_cells = []
    end

    def has_flag?
        @has_flag
    end

    def has_hit?
        @has_hit
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
        if has_flag? || has_hit?
            return false
        end

        @has_hit = true

        if !has_bomb? && get_neighbor_bombs_num == 0
            for cell in @neighbor_cells
                cell.hit
            end
        end

        return true
    end
    
    def flag
        if has_hit?
            return false
        end

        @has_flag = !@has_flag

        return true
    end

    def get_state(xray = false)
        if xray && has_bomb?
            return CellState::BOMB
        end

        if has_flag?
            return CellState::FLAG
        end

        if !has_hit?
            return CellState::UNKNOWN
        end

        if has_bomb?
            return CellState::BOMB
        end

        bombs = get_neighbor_bombs_num

        if bombs > 0
            return bombs.to_s
        end

        return CellState::CLEAR
    end
end