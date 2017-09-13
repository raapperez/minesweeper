
class MatrixPrinter
    def print(state)
        line = Array.new(state.first.length + 2, "-").join("-")
        puts line
        for array in state
            puts "| #{array.join(" ")} |"
        end
        puts line
    end
end