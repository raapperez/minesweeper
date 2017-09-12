
require_relative "../cell_state"

class StatusPrinter
    
    def print(state)

        cells = state.reduce(:concat)

        occurrences = cells.group_by{|e| e}.map {|k, v| [k, v.length]}.to_h

        unknown_count = occurrences[CellState::UNKNOWN] || 0
        puts "# unknown cells: #{unknown_count} - #{get_percent(unknown_count, cells.length)}%"

        clear_count = occurrences[CellState::CLEAR] || 0
        known_count = clear_count
        for i in 1..8
            known_count += occurrences[i.to_s] || 0
        end
        puts "# known cells: #{known_count} - #{get_percent(known_count, cells.length)}%"        
        
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