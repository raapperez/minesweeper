require_relative "../src/minesweeper"
require_relative "../src/printers/matrix_printer"
require_relative "../src/printers/status_printer"

width, height, num_mines = 10, 20, 10
game = Minesweeper.new(width, height, num_mines)

while game.still_playing?
    valid_move = game.play(rand(width), rand(height))
    valid_flag = game.flag(rand(width), rand(height))
    if valid_move or valid_flag
        MatrixPrinter.new.print(game.board_state)
        StatusPrinter.new.print(game.board_state)
    end
end

puts "Fim do jogo!"
if game.victory?
    puts "Voce venceu!"
else
    puts "Voce perdeu! As minas eram:"
    MatrixPrinter.new.print(game.board_state(xray: true))
    StatusPrinter.new.print(game.board_state(xray: true))
end