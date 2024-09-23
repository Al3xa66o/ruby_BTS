require_relative "lib/binary_s_t"
require_relative "lib/node"


bst = Bst.new

bst.insert(4)
bst.insert(33)
bst.insert(8)
bst.insert(99)
bst.insert(21)


bst.visualize
bst.preorder