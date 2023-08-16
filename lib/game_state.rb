require './lib/board/board_specs'

require './lib/piece/bishop_specs'
require './lib/piece/king_specs'
require './lib/piece/knight_specs'
require './lib/piece/piece_specs'
require './lib/piece/queen_specs'


class GameState
  include BoardSpecs
  include PieceSpecs
  include KingSpecs

  def player_checked?(color, board)
    king_to_check = King.new(color)
    opponent_color = (color == white) ? black : white

    (1..8).to_a.each do |rank|
      ('a'..'h').to_a.each do |file|
        square = { file: file, rank: rank }
        piece = board.at(square)

        if piece && piece.color == opponent_color
          case piece.type
          when pawn
            return true if find_king_for_pawn(king_to_check, square, board)
          when rook
            return true if find_king_for_rook(king_to_check, square, board)
          when knight
            return true if find_king_for_knight(king_to_check, square, board)
          when bishop
            return true if find_king_for_bishop(king_to_check, square, board)
          when queen
            return true if find_king_for_queen(king_to_check, square, board)
          when king
            return true if find_king_for_king(king_to_check, square, board)
          end
        end
      end # ('a'..'h')
    end # (1..8)

    false
  end

  def find_king_for_king(king_to_check, king_square, board)
    KingSpecs::DIRECTIONS.each.any? do |dir|
      result = false

      curr_square = { file: (king_square[:file].ord + dir[:file]).chr, rank: king_square[:rank] + dir[:rank] }
      if valid_square?(curr_square)
        curr_square_piece = board.at(curr_square) 

        if (not curr_square_piece.nil?) && curr_square_piece.eql?(king_to_check)
          result = true
        end
      end

      result
    end
  end

  def find_king_for_queen(king_to_check, queen_square, board)
    QueenSpecs::DIRECTIONS.each.any? do |dir|
      curr_square = { file: (queen_square[:file].ord + dir[:file]).chr, rank: queen_square[:rank] + dir[:rank] }

      until not valid_square?(curr_square) do
        curr_square_piece = board.at(curr_square)
        curr_square[:file] = (curr_square[:file].ord + dir[:file]).chr
        curr_square[:rank] += dir[:rank]
        
        next if curr_square_piece.nil?
        break if not curr_square_piece.eql?(king_to_check)
        return true
      end

      false
    end
  end

  def find_king_for_bishop(king_to_check, bishop_square, board)
    BishopSpecs::DIRECTIONS.each.any? do |dir|
      curr_square = { file: (bishop_square[:file].ord + dir[:file]).chr, rank: bishop_square[:rank] + dir[:rank] }

      until not valid_square?(curr_square) do
        curr_square_piece = board.at(curr_square)
        curr_square[:file] = (curr_square[:file].ord + dir[:file]).chr
        curr_square[:rank] += dir[:rank]
        
        next if curr_square_piece.nil?
        break if not curr_square_piece.eql?(king_to_check)
        return true
      end

      false
    end
  end

  def find_king_for_knight(king_to_check, knight_square, board)
    KnightSpecs::DIRECTIONS.each.any? do |dir|
      found = false
      search_square = { file: (knight_square[:file].ord + dir[:file]).chr, rank: knight_square[:rank] + dir[:rank] }

      if valid_square?(search_square)
        search_piece = board.at(search_square) 
        found = true if search_piece.eql? king_to_check
      end

      found
    end
  end

  def find_king_for_rook(king_to_check, rook_square, board)
    curr_square = { file: rook_square[:file], rank: rook_square[:rank] + 1 }

    until not valid_square?(curr_square) do
      curr_square_piece = board.at(curr_square)
      curr_square[:rank] += 1

      next if curr_square_piece.nil?
      break if not curr_square_piece.eql?(king_to_check)
      return true
    end

    curr_square = { file: (rook_square[:file].ord + 1).chr, rank: rook_square[:rank] }

    until not valid_square?(curr_square) do
      curr_square_piece = board.at(curr_square)
      curr_square[:file] = (curr_square[:file].ord + 1).chr

      next if curr_square_piece.nil?
      break if not curr_square_piece.eql?(king_to_check)
      return true
    end

    curr_square = { file: rook_square[:file], rank: rook_square[:rank] - 1 }

    until not valid_square?(curr_square) do
      curr_square_piece = board.at(curr_square)
      curr_square[:rank] -= 1

      next if curr_square_piece.nil?
      break if not curr_square_piece.eql?(king_to_check)
      return true
    end

    curr_square = { file: (rook_square[:file].ord - 1).chr, rank: rook_square[:rank] }

    until not valid_square?(curr_square) do
      curr_square_piece = board.at(curr_square)
      curr_square[:file] = (curr_square[:file].ord - 1).chr

      next if curr_square_piece.nil?
      break if not curr_square_piece.eql?(king_to_check)
      return true
    end

    false
  end

  def find_king_for_pawn(king_to_check, pawn_square, board)
    return false if pawn_square[:rank] == 1 || pawn_square[:rank] == 8

    rank_step = (king_to_check.color == white) ? -1 : 1
    
    left_file = (pawn_square[:file].ord - 1).chr
    right_file = (pawn_square[:file].ord + 1).chr

    if valid_file? left_file
      return true if board.at({ file: left_file, rank: pawn_square[:rank] + rank_step }).eql? king_to_check
    end

    if valid_file? right_file
      return true if board.at({ file: right_file, rank: pawn_square[:rank] + rank_step }).eql? king_to_check
    end

    false
  end

  def checkmate?(color, board)
    king_square = board.search_king(color)

    king_dirs.all? do |dir|
      move_square = { file: (king_square[:file].ord + dir[:file]).chr,
                      rank: king_square[:rank] + dir[:rank] }
      result = true

      if valid_square?(move_square) && board.at(move_square).nil?
        board_copy = board.board_copy
        board.set(king_square)
        board.set(move_square, King.new(color))

        result = false if (not player_checked?(color, board))
        board.ranks = board_copy
      end

      result
    end
  end
end
