#
class Node
  def initialize(args)
    if args.size.zero?
      new
    elsif args.size == 2
      new_with_value(args[0], args[1])
    elsif args.size == 4
      new_with_node(args[0], args[1], args[2], args[3])
    end
  end

  def new
    @code = ''
    @value = ''
    @number = 0
    @left = nil
    @right = nil
  end

  def new_with_value(value, number)
    @code = ''
    @value = value
    @number = number
    @left = nil
    @right = nil
  end

  def new_with_node(value, number, left, right)
    @code = ''
    @value = value
    @number = number
    @left = left
    @right = right
  end

  def inc_number
    @number += 1
  end

  def code_set(code)
    @code = code
  end
end

class Huffman
  def make_node(text)
    nodes = []
    text.each_char do |chr|
      tmp = true
      nodes.each do |n|
        if chr == n.instance_variable_get(:@value)
          n.inc_number
          tmp = false
        end
      end
      if tmp
        n = Node.new([chr, 1])
        nodes.push(n)
      end
    end
    nodes
  end

  def make_tree(nodes, tmp)
    while nodes.size != 1
      x = extract_min(nodes)
      nodes.delete(x)
      y = extract_min(nodes)
      nodes.delete(y)
      name = "z#{tmp}"
      tmp += 1
      parent = Node.new([name, x.instance_variable_get(:@number) + y.instance_variable_get(:@number), x, y])
      nodes.push(parent)
    end
    nodes[0]
  end

  def make_code(root, nodes)
    if root.instance_variable_get(:@left).nil? && root.instance_variable_get(:@right).nil?
      nodes.push(root)
    end
    st = ''
    unless root.instance_variable_get(:@left).nil?
      st = root.instance_variable_get(:@code).to_s + '0'
      root.instance_variable_get(:@left).code_set(st)
      make_code(root.instance_variable_get(:@left), nodes)
    end
    unless root.instance_variable_get(:@right).nil?
      st = root.instance_variable_get(:@code)
      st += '1'
      root.instance_variable_get(:@right).code_set(st)
      make_code(root.instance_variable_get(:@right), nodes)
    end
    nodes
  end

  def extract_min(nodes)
    min = nodes[0]
    nodes.each do |n|
      min.instance_variable_get(:@number) > n.instance_variable_get(:@number) ? min = n : next
    end
    min
  end

  def encrypt(text)
    nodes = make_node(text)
    @root = make_tree(nodes, 1)
    node_list = []
    node_list = make_code(@root, node_list)
    node_list
  end

  def print_all(node_list)
    node_list.each { |n| puts n.instance_variable_get(:@value).to_s + ': ' + n.instance_variable_get(:@code).to_s }
  end

  def get_code(text)
    code = ''
    nodes = encrypt(text)
    text.each_char do |chr|
      nodes.each do |n|
        if chr == n.instance_variable_get(:@value)
          code += n.instance_variable_get(:@code)
          break
        end
      end
    end
    code
  end

  def decrypt(code)
    text = ''
    @root.nil? ? abort : tmp_node = @root
    code.each_char do |chr|
      if chr == '0'
        if tmp_node.instance_variable_get(:@left).nil?
          text += tmp_node.instance_variable_get(:@value)
          tmp_node = @root
        end
        tmp_node = tmp_node.instance_variable_get(:@left)
      else
        if tmp_node.instance_variable_get(:@right).nil?
          text += tmp_node.instance_variable_get(:@value)
          tmp_node = @root
        end
        tmp_node = tmp_node.instance_variable_get(:@right)
      end
    end
    text += tmp_node.instance_variable_get(:@value)
    text
  end
end
