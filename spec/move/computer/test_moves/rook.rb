require './lib/board/board_specs'

require './lib/move/move'

require './lib/piece/piece_specs'
require './lib/piece/rook'


module TestRookMoves
  include BoardSpecs
  include PieceSpecs

  def legal_rook_moves
    test_rook_moves + test_rook_captures + test_rook_moves_with_start
  end

  def test_rook_moves
    ranks.map do |rank|
      a = files.map do |file|
        move = Move.new(rook + file + rank.to_s, white)
        move.target = { file: file, rank: rank }
        move.piece = Rook.new(white)

        exp_start = { file: file, rank: (move.target[:rank] + 2) % 8 + 1 }

        { move: move, exp_start: exp_start }
      end

      b = files.map do |file|
        move = Move.new(rook + file + rank.to_s + '+', white)
        move.target = { file: file, rank: rank }
        move.piece = Rook.new(white)

        exp_start = { file: file, rank: (move.target[:rank] + 2) % 8 + 1 }

        { move: move, exp_start: exp_start }
      end

      c = files.map do |file|
        move = Move.new(rook + file + rank.to_s + '#', white)
        move.target = { file: file, rank: rank }
        move.piece = Rook.new(white)

        exp_start = { file: file, rank: (move.target[:rank] + 2) % 8 + 1 }

        { move: move, exp_start: exp_start }
      end

      a.concat(b).concat(c)
    end.flatten
  end

  def test_rook_captures
    test_rook_moves.map do |move|
      move[:move].capture = true
      move[:move].str.sub(rook, rook + 'x')

      { move: move[:move], exp_start: move[:exp_start] }
    end
  end

  def test_rook_moves_with_start
    a = test_rook_moves.map do |move|
      files.map do |file|
        m = Move.new(move[:move].str.sub(rook, rook + file), white)
        m.target = move[:move].target
        m.start_coordinate = file
        m.piece = Rook.new(white)

        exp_start = { file: file, rank: m.target[:rank] }

        if file == m.target[:file]
          exp_start[:rank] = ((exp_start[:rank] + 2) % 8) + 1
        end

        { move: m, exp_start: exp_start }
      end
    end.flatten

    b = test_rook_moves.map do |move|
      ranks.map do |rank|
        m = Move.new(move[:move].str.sub(rook, rook + rank.to_s), white)
        m.start_coordinate = rank
        m.target = move[:move].target
        m.piece = Rook.new(white)

        exp_start = { file: m.target[:file], rank: rank }

        if rank == m.target[:rank]
          exp_start[:file] = (((exp_start[:file].ord - 97 + 2) % 8) + 97).chr
        end

        { move: m, exp_start: exp_start }
      end
    end.flatten

    c = test_rook_captures.map do |move|
      files.map do |file|
        m = Move.new(move[:move].str.sub(rook, rook + file), white)
        m.start_coordinate = file
        m.target = move[:move].target
        m.piece = Rook.new(white)

        exp_start = { file: file, rank: m.target[:rank] }

        if file == m.target[:file]
          exp_start[:rank] = ((exp_start[:rank] + 2) % 8) + 1
        end

        { move: m, exp_start: exp_start }
      end
    end.flatten

    d = test_rook_captures.map do |move|
      ranks.map do |rank|
        m = Move.new(move[:move].str.sub(rook, rook + rank.to_s), white)
        m.start_coordinate = rank
        m.target = move[:move].target
        m.piece = Rook.new(white)

        exp_start = { file: m.target[:file], rank: rank }

        if rank == m.target[:rank]
          exp_start[:file] = (((exp_start[:file].ord - 97 + 2) % 8) + 97).chr
        end

        { move: m, exp_start: exp_start }
      end
    end.flatten

    a + b + c + d
  end
end
