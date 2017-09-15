require_relative "../cell"
require 'json'

class LoadFieldFactory

    def initialize(file_name)
        load_text = File.read(file_name)
        
        field_info = JSON.parse(load_text)

        @field = []

        @num_mines = 0

        field_info.each do |array|
            @field.push(array.map do |cell_info|

                has_bomb = cell_info["has_bomb"]

                if(has_bomb)
                    @num_mines += 1
                end

                Cell.new(cell_info["has_flag"], cell_info["has_hit"], has_bomb)
            end
            )
        end

        @width = @field.first.length
        @height = @field.length
    end

    def field
        @field
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

    def get_field(width, height, num_mines)
        return @field
    end
        
end
