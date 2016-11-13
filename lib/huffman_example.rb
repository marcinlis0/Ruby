require_relative 'huffman.rb'

print 'Podaj tekst do zakodowania: '
text = gets.strip
h = Huffman.new
node_list = h.encrypt(text)
puts "\nKodowanie:"
h.print_all(node_list)
code = h.get_code(text)
puts "\nZakodowany tekst: " + code
puts "\nOdkodować tekst(t/n)?"
inp = ''
loop do
  inp = gets.strip
  if inp == 't' || inp == 'n'
    break
  end
  puts 'Wpisz poprawny znak!'
end
if inp == 't'
  puts "\nOdkodowany tekst: " + h.decrypt(code)
end
