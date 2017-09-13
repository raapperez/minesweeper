require_relative "../src/minesweeper"
require_relative "../src/printers/matrix_printer"
require_relative "../src/printers/status_printer"

begin

matrix_printer = MatrixPrinter.new
status_printer = StatusPrinter.new

print "Enter the width, height and num_mines: "

width, height, num_mines = gets.chomp.split(" ").map{|e| Integer(e)}

game = Minesweeper.new(width, height, num_mines)

matrix_printer.print(game.board_state)
status_printer.print(game.board_state)

while game.still_playing?
    print "Enter the action (c to click or f to flag), x and y: "    
    action, x, y = gets.chomp.split(" ")

    x = Integer(x)
    y = Integer(y)

    if action == "c"
        if !game.play(x, y)
            puts "Invalid move"
            next
        end
    elsif action == "f"
        if !game.flag(x, y)
            puts "Invalid move"
            next
        end
    end

    board_state = game.board_state
    matrix_printer.print(board_state)
    status_printer.print(board_state)
end

puts "Fim do jogo!"
if game.victory?
    puts "Voce venceu!"
else
    puts "Voce perdeu! As minas eram:"
    board_state = game.board_state(xray: true)
    matrix_printer.print(board_state)
    status_printer.print(board_state)
end

rescue Exception => e
    puts e.message    
end


