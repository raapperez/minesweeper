
require_relative "../cell_state"

class StatusPrinter
    
    def print(state)

        cells = state.reduce(:concat)

        occurrences = cells.group_by{|e| e}.map {|k, v| [k, v.length]}.to_h

        unknow_count = occurrences[CellState::UNKNOW] || 0
        puts "# unknow cells: #{unknow_count} - #{get_percent(unknow_count, cells.length)}%"

        clear_count = occurrences[CellState::CLEAR] || 0
        know_count = clear_count
        for i in 1..8
            know_count += occurrences[i.to_s] || 0
        end
        puts "# know cells: #{know_count} - #{get_percent(know_count, cells.length)}%"        
        
        flag_count = occurrences[CellState::FLAG] || 0        
        puts "# flag cells: #{flag_count} - #{get_percent(flag_count, cells.length)}%"

        bomb_count = occurrences[CellState::BOMB] || 0        
        puts "# bomb cells: #{bomb_count} - #{get_percent(bomb_count, cells.length)}%"
 
    end

    private

    def get_percent(num, total)
        return (100.0 * num / total).round(2)
    end

end