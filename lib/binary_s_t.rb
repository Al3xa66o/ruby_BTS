require_relative "node.rb"

class Bst
  attr_accessor :root, :size

  def initialize()
    @root = nil
    @size = 0
  end



  def build_tree
    arr = Array.new(15) { rand(1..100) }
    sorted_arr = arr.sort
    @root = sorted_arr_bts(sorted_arr, 0, sorted_arr.length - 1)
  end

  def sorted_arr_bts(arr, start_ind, end_ind)
    return nil if start_ind > end_ind
    mid_ind = (start_ind + end_ind) / 2
    node = Node.new(arr[mid_ind])

    node.left = sorted_arr_bts(arr, start_ind, mid_ind - 1)
    node.right = sorted_arr_bts(arr, mid_ind + 1, end_ind)

    node
  end
  
  def insert(value)
    new_node = Node.new(value)
    if @root.nil?
      @root = new_node
    else
      insert_node(@root, new_node)
    end
  end

  def insert_node(node, new_node)
    if new_node.value < node.value
      if node.left.nil?
        node.left = new_node
      else
        insert_node(node.left, new_node)
      end
    else
      if node.right.nil?
        node.right = new_node
      else
        insert_node(node.right, new_node)
      end
    end
  end

  def remove(value, node = self.root)
    removeHelper(value, node = self.root)
    @size -=1
    node
  end

  private
  def removeHelper(value, node = self.root)
    if node == nil
      return nil
    end
    if node.value > value
      node.left = removeHelper(value, node.left)
    elsif node.value < value
      node.right = removeHelper(value, node.right)
    else
      if node.left != nil && node.right != nil
        temp = node
        min_of_right_subtree = find_min(node.right)
        node.value = min_of_right_subtree.value
        node.right = removeHelper(min_of_right_subtree.value, node.right)
      elsif node.left != nil
        node = node.left
      elsif node.right != nil
        node = node.right
      else
        node = nil
      end
    end
    return node
  end

  def find_min(node = self.root)
    if node == nil
      return nil
    elsif node.left == nil
      return node
    end
    return find_min(node.left)
  end



  def find(value)
  #method which accepts a value and returns the node with the given value.
   search_node(@root, value)
  end

  def search_node(node, value)
    return nil if node.nil?
    return node if node == value

    if value < node.value
      search_node(node.left, value)
    else
      search_node(node.right, value)
    end
  end
  

  def height(node)
    #method that accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.
    return 0 if node.nil?
    left_height = height(node.left)
    right_height = height(node.right)

    [left_height + right_height].max + 1
  end


  def depth(node, current_node = @root, current_depth = 0)
    #method that accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.
    return nil if current_node.nil?

    return current_depth if node.value == current_node.value
    
    if node.value < current_node.value
      depth(node, current_node.left, current_depth + 1)
    else
      depth(node, current_node.right, current_depth + 1)
    end
  end

  def balanced?(node = @root)
    #method that checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1
    left_height = height(node.left)
    right_height = height(node.right)

    if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
      return true
    else
      return false
    end
    
  end

  def in_order(node = @root &block)
    return if node.nil?

    in_order(node.left, &block)
    block.call(node)
    in_order(node.right, &block)
  end

  def rebalance
    #method which rebalances an unbalanced tree. Tip: You’ll want to use a traversal method to provide a new array to the #build_tree method.
    node []
  end


  def level_order
    #method which accepts a block. This method should traverse the tree in breadth-first level order and yield each node to the provided block. 
    #This method can be implemented using either iteration or recursion (try implementing both!). The method should return an array of values if no block is given.
    return if @root.nil?

    queue = []
    queue.push(@root)

    until queue.empty?
      node = queue.shift
      yield(node)

      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
  end

  
  def visualize(node = @root, prefix = "", is_left = true)
    return if node.nil?

    visualize(node.right, "#{prefix}#{is_left ? "|     " : "     "}", false)

    puts "#{prefix}#{is_left ? " └── " : " ┌── "}#{node.value}"

    visualize(node.let, "#{prefix}#{is_left ? "     " : "|    "}", true)
  end
 


end

