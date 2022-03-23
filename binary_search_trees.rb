class Node
  attr_accessor :data
  attr_accessor :left 
  attr_accessor :right 
  
  def initialize(data)
    @data=data
  end
end
  
 
  
class Tree
  attr_accessor :root

  @@height=0
  @@depth=0
  @@array=[]
  
  #initializes the tree by first sorting the array and deleting repeats before building the tree
  def initialize(array)
    @array=array.uniq.sort!
    @root=build_tree
  end

  def build_tree(arr=@array, start=0, stop=@array.length-1)
    if start>stop
      return
    else
    mid=(start+stop)/2
    node=Node.new(arr[mid])
    node.left=build_tree(arr, start, mid-1)
    node.right=build_tree(arr, mid+1, stop)
    node
    end
  end

  def insert(value, node=@root)
    if node==nil
      node=Node.new(value)
    else
      if value==node.data
      node
      elsif value<node.data
        node.left=insert(value, node.left)
      elsif value>node.data
        node.right=insert(value, node.right)
      end
    node
    end
  end
      
  def find(value, node=@root)
    if node==nil
      return
    else
      if value==node.data
      node
      elsif value<node.data
        find(value, node.left)
        @@depth+=1
      elsif value>node.data
        find(value, node.right)
        @@depth+=1
      end
    end
  end

  def delete(value, node=@root)
    if node==nil
      return
    else
      if value<node.data
      node.left=delete(value, node.left)
      elsif value>node.data
      node.right=delete(value, node.right)
      else
        if node.left==nil&&node.right==nil
          node=nil
        elsif node.left!=nil&&node.right==nil
          node=node.left
          node.left=nil
        elsif node.right!=nil&&node.left==nil
          node=node.right
          node.right=nil
        else 
          current=node.right
          until current.left==nil
            current=current.left
          end
          node.data=current.data
          node.right=delete(current.data, node.right)
        end
      end
    node
    end
  end

  def level_order(node=@root)
    if node==nil
      return
    else
      queue=[]
      queue.push(node)
      target=node.right
      until queue==[]
        current=queue[0]
        current.data
        unless current.left==nil
          queue.push(current.left)
        end
        unless current.right==nil
          queue.push(current.right)
        end
        queue[0].data
        queue.shift()
        
        if current==target
          @@height+=1
          target=current.right
        end
      end
    end
  end

  def inorder(node=@root)
    if node==nil
      return
    else
      inorder(node.left)
      p node.data
      inorder(node.right)
    end
  end

  def preorder(node=@root)
    if node==nil
      return
    else
      p node.data
      preorder(node.left)
      preorder(node.right)
    end
  end

  def postorder(node=@root)
    if node==nil
      return
    else
      postorder(node.left)
      postorder(node.right)
      p node.data
    end
  end

  def find_height(value, node=@root)
    if node==nil
      return
    else
      if value<node.data
        node.left=find_height(value, node.left)
      elsif value>node.data
        node.right=find_height(value, node.right)
      else
        level_order(node)
      end
    end
  end

  def height(value)
    find_height(value)
    puts @@height
    @@height=0
  end
  
  def depth(value, node=@root)
    find(value)
    puts @@depth
    @@depth=0
  end

  def tree_as_array(node=@root)
    if node==nil
      return
    else
      tree_as_array(node.left)
      @@array.append(node.data)
      tree_as_array(node.right)
    end
    result=@@array
  end

  def rebalance
    sorted_array=tree_as_array
    @array=sorted_array
    @root=build_tree
    @@array=[]
  end

# prints out the tree as a human readable tree (not my code, shared from another student)
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

# ----simple driver script-----

# creates a random array of 15 numbers
array=(Array.new(15) { rand(1..100) })

# creates and prints a new bst
tree=Tree.new(array)
puts "Original bst."
tree.pretty_print

# inserts 4 numbers greater than 100 inorder to unbalance the tree
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)
puts "Four numbers inserted. Tree unbalanced."
tree.pretty_print

# rebalances the tree
tree.rebalance
puts "Tree rebalanced after insertion."
tree.pretty_print

# deletes 4 numbers
tree.delete(101)
tree.delete(102)
tree.delete(103)
tree.delete(104)
puts "Four numbers deleted. Tree might be unbalanced."
tree.pretty_print

# rebalances the tree
tree.rebalance
puts "Tree rebalanced after deletion."
tree.pretty_print

# prints out nodes in order
puts "Inorder list of nodes in the current tree."
tree.inorder