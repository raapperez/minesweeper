require_relative "../src/minesweeper"
require_relative "../src/printers/matrix_printer"
require_relative "../src/printers/status_printer"

begin

matrix_printer = MatrixPrinter.new
status_printer = StatusPrinter.new

if ARGV.length == 1
    file_name = ARGV.first
    game = Minesweeper.new(1, 1, 1, nil, true)
    game.load(file_name)
else
    print "Enter the width, height and num_mines: "
    
    width, height, num_mines = gets.chomp.split(" ").map{|e| Integer(e)}
    
    game = Minesweeper.new(width, height, num_mines) 
end



matrix_printer.print(game.board_state)
status_printer.print(game.board_state)

skip_end_game = false

while game.still_playing?
    print "Enter the action (c to click or f to flag or s to save), x and y: "

    action, x, y = gets.chomp.split(" ")

    if action == "s"
        game.save()
        skip_end_game = true
        puts "Game saved"
        break
    end

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

if !skip_end_game

    puts "Fim do jogo!"
    if game.victory?
        puts "Voce venceu!"
    else
        puts "Voce perdeu! As minas eram:"
        board_state = game.board_state(xray: true)
        matrix_printer.print(board_state)
        status_printer.print(board_state)
    end

end

rescue Exception => e
    puts e.message 
    puts e.backtrace
end


