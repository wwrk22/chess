require './lib/board/board_specs'


module MoveSamples
  module Pawn
    include BoardSpecs

    def wh_non_captures
      files.map do |file|
        (3..8).to_a.map do |rank|
          file + rank.to_s
        end
      end.flatten
    end

    def bl_non_captures
      files.map do |file|
        (1..6).to_a.map do |rank|
          file + rank.to_s
        end
      end.flatten
    end

    def wh_captures
      files.map do |file|
        wh_non_captures.map do |non_capture|
          file + 'x' + non_capture if not non_capture.include? file
        end
      end.flatten.filter { |square| square }
    end

    def bl_captures
      files.map do |file|
        bl_non_captures.map do |non_capture|
          file + 'x' + non_capture if not non_capture.include? file
        end
      end.flatten.filter { |square| square }
    end

    def wh_illegal_moves
      files.map do |file|
        (1..2).to_a.map do |rank|
          file + rank.to_s
        end
      end.flatten
    end

    def wh_illegal_captures
      a = files.map do |file|
        wh_non_captures.map do |non_capture|
          file + 'x' + non_capture if non_capture.include? file
        end
      end.flatten.filter { |square| square }

      b = files.map do |file|
        wh_illegal_moves.map do |illegal_move|
          file + 'x' + illegal_move
        end
      end.flatten

      a + b
    end

    def bl_illegal_moves
      files.map do |file|
        (7..8).to_a.map do |rank|
          file + rank.to_s
        end
      end.flatten
    end

    def bl_illegal_captures
      a = files.map do |file|
        bl_non_captures.map do |non_capture|
          file + 'x' + non_capture if non_capture.include? file
        end
      end.flatten.filter { |square| square }

      b = files.map do |file|
        bl_illegal_moves.map do |illegal_move|
          file + 'x' + illegal_move
        end
      end.flatten

      a + b
    end
  end
end
