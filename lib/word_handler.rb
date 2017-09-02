class WordHandler
	attr_reader :template

	def initialize
		@word = get_from_dictionary
		@template = ''.rjust(@word.size, '-')
	end
	
	def get_from_dictionary
		size = File.readlines('dictionary.txt').size
		word = File.readlines('dictionary.txt')[rand(0..size)]
		word.chomp
	end
	
	def insert_letter(letter)
		@word.split('').each_with_index do |char, index| 
			@template[index] = char if char == letter  
		end
		@template
	end
	
	def guessed?
		@word == @template
	end
end
