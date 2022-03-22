class Node
    attr_accessor :data
    attr_accessor :left 
    attr_accessor :right 
    
    def initialize(data)
      @data=data
    end
  end
  
  module Comparable
  end
  
  class Tree
    attr_accessor :root
  
    @@height=0
    @@depth=0
    @@right_height=0
    @@left_height=0
    @@balanced=0
    
    
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
        node.data
        inorder(node.right)
      end
    end
  
    def preorder(node=@root)
      if node==nil
        return
      else
        node.data
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
        node.data
      end
    end
  
    def height(value, node=@root)
      if node==nil
        return
      else
        if value<node.data
         
          node.left=height(value, node.left)
          
        elsif value>node.data
          
          node.right=height(value, node.right)
          
          
        else
          level_order(node)
          puts @@height
        end
      end
    end
  
    def depth(value, node=@rooth)
      find(value)
      puts @@depth
    end
  
    def check_for_balance(node=@root)
      if node==nil
        return
      else
        check_for_balance(node.left)
        current=node
        until current.left==nil
        current=current.left
        @@left_height+=1
        end
        until current.right==nil
         current=current.right
         @@right_height+=1
        end
        if @@left_height-@@right_height>1||@@right_height-@@left_height>1
          puts "The tree is NOT balanced."
          @@balanced=1
          return
        end
        check_for_balance(node.right)
        @@left_height=0
        @@right_height=0
      end
    end
  
    def balanced?
      check_for_balance
      if @@balanced==0
      puts "The tree is balanced."
      end
      @@balanced=0
    end
  
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
  
    
  end
    
  array=[1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
  
  tree=Tree.new(array)
  
  tree.balanced?
  tree.insert(7000)
  tree.pretty_print
  tree.balanced?
  
  
  
  
  
  
  
  