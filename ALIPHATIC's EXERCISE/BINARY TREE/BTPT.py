# Binary Tree Preorder Traversal

# Given the root of a binary tree, return the preorder traversal of its nodes' values.

 

# Example 1:


# Input: root = [1,null,2,3]
# Output: [1,2,3]
# Example 2:

# Input: root = []
# Output: []
# Example 3:

# Input: root = [1]
# Output: [1]
 

# Constraints:

# The number of nodes in the tree is in the range [0, 100].
# -100 <= Node.val <= 100
 

# Follow up: Recursive solution is trivial, could you do it iteratively?



# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution(object):
    def preorderTraversal(self, root):
            """
        :type root: TreeNode
        :rtype: List[int]
        """
        
            if root is None:
                return []
            
            stack = [root]
            result = []
            
            while stack:
                node = stack.pop()
                result.append(node.val)
                
                if node.right:
                    stack.append(node.right)
                if node.left:
                    stack.append(node.left)
                    
            return result
