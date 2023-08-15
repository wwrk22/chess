require_relative './board/board'

require_relative './player/player'

require_relative './piece/piece_specs'

require_relative './game_state'

require_relative './move/interpreter/move_interpreter'

require_relative './move/computer/pawn_start_computer'
require_relative './move/computer/rook_start_computer'
require_relative './move/computer/knight_start_computer'
require_relative './move/computer/bishop_start_computer'
require_relative './move/computer/queen_start_computer'
require_relative './move/computer/king_start_computer'

require_relative './move/performer/move_performer'
require_relative './move/executor/castler'


mp = MovePerformer.new

castler = Castler.new

start_computers = { PieceSpecs::PAWN => PawnStartComputer.new,
                    PieceSpecs::ROOK => RookStartComputer.new,
                    PieceSpecs::BISHOP => BishopStartComputer.new,
                    PieceSpecs::KNIGHT => KnightStartComputer.new,
                    PieceSpecs::QUEEN => QueenStartComputer.new,
                    PieceSpecs::KING => KingStartComputer.new }

interpreter = MoveInterpreter.new

gs = GameState.new

wh_player = Player.new("Foo", PieceSpecs::WHITE)
bl_player = Player.new("Bar", PieceSpecs::BLACK)

board = Board.new
board.setup_for_game

# Prompt move and check syntax.
wh_move = nil
bl_move = nil

until gs.game_winner(board) do
  # White's move
  puts board.to_s
  wh_move = Move.new('', PieceSpecs::WHITE)

  until wh_move && wh_move.start do
    print "White, make a move: "
    wh_move = wh_player.prompt_move(board)

    # Interpret move string.
    wh_move.target = interpreter.parse_target(wh_move.str)
    wh_move.capture = interpreter.capture?(wh_move.str)
    wh_move.start_coordinate = interpreter.parse_start_coordinate(wh_move)
    ep_data = interpreter.determine_ep(wh_move, bl_move, board)
    wh_move.ep, wh_move.ep_sq = [ep_data[:ep], ep_data[:ep_sq]]

    # Compute the starting square.
    wh_move.start = start_computers[wh_move.piece.type].compute_start(wh_move, board)

    puts "wh_move:"
    p wh_move

    # Perform the move.
    if wh_move.str == '0-0' || wh_move.str == '0-0-0'
      castler.do_castle(wh_move, 'WH', board)
    else
      mp.do_move(wh_move, board) if wh_move.start
    end
  end

  # Black's move
  puts board.to_s
  bl_move = Move.new('', PieceSpecs::BLACK)

  until bl_move && bl_move.start do
    print "Black, make a move: "
    bl_move = bl_player.prompt_move(board)

    # Interpret move string.
    bl_move.target = interpreter.parse_target(bl_move.str)
    bl_move.capture = interpreter.capture?(bl_move.str)
    bl_move.start_coordinate = interpreter.parse_start_coordinate(bl_move)
    ep_data = interpreter.determine_ep(bl_move, wh_move, board)
    bl_move.ep, bl_move.ep_sq = [ep_data[:ep], ep_data[:ep_sq]]

    # Compute the starting square.
    bl_move.start = start_computers[bl_move.piece.type].compute_start(bl_move, board)

    # Perform the move.
    if bl_move.str == '0-0' || bl_move.str == '0-0-0'
      castler.do_castle(bl_move, 'BL', board)
    else
      mp.do_move(bl_move, board) if bl_move.start
    end
    end
end


puts "#{gs.game_winner(board)} wins"
