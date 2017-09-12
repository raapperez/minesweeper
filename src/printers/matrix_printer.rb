
class MatrixPrinter
    def print(state)
        for array in state
            puts array.join(" ") + " |"
        end        
    end
end