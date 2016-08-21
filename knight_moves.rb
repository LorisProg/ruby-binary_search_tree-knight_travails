class GameBoard

	attr_reader :min, :max
	
	def initialize
	# board size 8x8 squares
	@min = 0
	@max = 7
	end
end


class Knight

	attr_reader :position, :parent, :next_possible_positions

	def initialize(position, parent=nil)
		@board = GameBoard.new
		if valid_position?(position)
			@position = position
		else
			puts "Wrong position to initialize the Knight"
		end
		@parent = parent
		@next_possible_positions = self.find_next(position)
	end

	def find_next(position)
		possible_positions = []
		possible_moves = [[position[0] + 1, position[1] + 2], [position[0] + 1, position[1] - 2], [position[0] - 1, position[1] + 2], [position[0] - 1, position[1] - 2], [position[0] + 2, position[1] + 1], [position[0] + 2, position[1] - 1], [position[0] - 2, position[1] + 1], [position[0] - 2, position[1] - 1]]
		possible_moves.each do |move|
			possible_positions << move if valid_position?(move)
		end
		possible_positions
	end

	def valid_position?(position)
		return true if position[0].between?(@board.min, @board.max) && position[1].between?(@board.min, @board.max)
		false
	end
end


def knight_moves(initial, target)
	knight = Knight.new(initial)
	return "The target is not inside the board" unless knight.valid_position?(target)
	queue = []
	queue << knight
	target_knight = nil
	until target_knight
		current_knight = queue.shift
		if current_knight.position == target
			target_knight = current_knight
		else
			current_knight.next_possible_positions.each do |position|
				queue << Knight.new(position, current_knight)
			end
		end
	end
	path = []
	next_knight = target_knight
	while next_knight
		path = path.unshift(next_knight.position)
		next_knight = next_knight.parent
	end
	path
end



