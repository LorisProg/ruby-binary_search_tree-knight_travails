class Node

	attr_accessor :value, :parent, :child_left, :child_right

	def initialize(value=nil, parent=nil, child_left=nil, child_right=nil)
		@value = value
		@parent = parent
		@child_left = child_left
		@child_right = child_right
	end	
end

def build_tree(array)
	root = Node.new(array[0])
	array.each do |value|
		place_value(root, value)
	end
	root
end

def place_value(tree, value)
	root = tree
	if value < root.value
		root.child_left = Node.new(value, root) if root.child_left == nil
		place_value(root.child_left, value) if root.child_left != nil
	elsif value > root.value
		root.child_right = Node.new(value, root) if root.child_right == nil
		place_value(root.child_right, value) if root.child_right != nil
	end
end

def breadth_first_search(value, tree)
	queue = []
	queue << tree
	target = nil
	until queue.empty? || target
		currentNode = queue.shift
		if currentNode.value == value
			target = currentNode
		else
			queue << currentNode.child_left if currentNode.child_left != nil
			queue << currentNode.child_right if currentNode.child_right != nil
		end
	end
	target
end

def depth_first_search(value, tree)
	stack = []
	stack << tree
	target = nil
	until stack.empty? || target
		currentNode = stack.pop
		if currentNode.value == value
			target = currentNode
		else
			stack << currentNode.child_right if currentNode.child_right != nil
			stack << currentNode.child_left if currentNode.child_left != nil
		end
	end
	target
end

def dfs_rec(value, node)
	target = nil
	target = node if node.value == value
	if target == nil
		target = dfs_rec(value, node.child_left) if node.child_left !=nil
		if target == nil
			target = dfs_rec(value, node.child_right) if node.child_right != nil
		end
	end
	target
end





