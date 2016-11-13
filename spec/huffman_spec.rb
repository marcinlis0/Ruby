require 'simplecov'
SimpleCov.start

require_relative '../lib/huffman.rb'

describe 'Node' do
  describe '#constructors' do
    it 'Should be defined' do
      expect { Node.new([]) }.not_to raise_error
    end
    it 'Initialize without arguments should return good values' do
      node = Node.new([])
      expect(node.instance_variable_get(:@code)).to eq('')
      expect(node.instance_variable_get(:@value)).to eq('')
      expect(node.instance_variable_get(:@number)).to eq(0)
      expect(node.instance_variable_get(:@left)).to eq(nil)
      expect(node.instance_variable_get(:@right)).to eq(nil)
    end
    it 'Initialize with 2 arguments should return good values' do
      node = Node.new(['a', 1])
      expect(node.instance_variable_get(:@code)).to eq('')
      expect(node.instance_variable_get(:@value)).to eq('a')
      expect(node.instance_variable_get(:@number)).to eq(1)
      expect(node.instance_variable_get(:@left)).to eq(nil)
      expect(node.instance_variable_get(:@right)).to eq(nil)
    end
    it 'Initialize with 4 arguments should return good values' do
      node = Node.new(['b', 2, Node.new([]), Node.new([])])
      expect(node.instance_variable_get(:@code)).to eq('')
      expect(node.instance_variable_get(:@value)).to eq('b')
      expect(node.instance_variable_get(:@number)).to eq(2)
      expect(node.instance_variable_get(:@left)).to be_kind_of(Node)
      expect(node.instance_variable_get(:@right)).to be_kind_of(Node)
    end
  end
  describe 'method' do
    it 'should increase a variable' do
      node = Node.new(['c', 2])
      node.inc_number
      expect(node.instance_variable_get(:@number)).to eq(3)
    end
    it 'should set a code' do
      node = Node.new([])
      node.code_set('test')
      expect(node.instance_variable_get(:@code)).to eq('test')
    end
  end
end
describe 'Huffman' do
  it 'Method should make good calculation' do
    h = Huffman.new
    expect(h.make_node('aaabaccaaadddab').size).to eq(4)
  end
  it 'Method should return the first smallest value' do
    h = Huffman.new
    min = h.extract_min([Node.new(['a', 2]), Node.new(['b', 4]), Node.new(['c', 2])])
    expect(min.instance_variable_get(:@number)).to eq(2)
    expect(min.instance_variable_get(:@value)).to eq('a')
  end
  it 'Method should return a root' do
    h = Huffman.new
    nodes = h.make_node('aaabaccaaadddab')
    expect(h.make_tree(nodes, 1).instance_variable_get(:@value)).to eq('z3')
    expect(h.make_tree(nodes, 1).instance_variable_get(:@number)).to eq(15)
  end
  it 'Method should encrypt text' do
    h = Huffman.new
    nodes = h.make_node('aaabaccaaadddab')
    root = h.make_tree(nodes, 1)
    node_list = []
    expect(h.make_code(root, node_list)[0].instance_variable_get(:@code)).to eq('00')
    expect(h.make_code(root, node_list)[1].instance_variable_get(:@code)).to eq('010')
    expect(h.make_code(root, node_list)[2].instance_variable_get(:@code)).to eq('011')
    expect(h.make_code(root, node_list)[3].instance_variable_get(:@code)).to eq('1')
  end
  it 'Method should return 4 nodes' do
    h = Huffman.new
    expect(h.encrypt('aaabaccaaadddab').size).to eq(4)
  end
  it 'Method should return right code' do
    h = Huffman.new
    expect(h.get_code('aaabbc')).to eq('000111110')
  end
  it 'Method should decrypt the code' do
    h = Huffman.new
    code = h.get_code('test text')
    expect(h.decrypt(code)).to eq('test text')
  end
end
