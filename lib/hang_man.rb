require 'yaml'
require_relative 'word_handler.rb'

@@regex = /\A[a-z]|[A-Z]\z/

def new_game
	game_info
	attempts = 15
	ridle = WordHandler.new
	game(attempts, ridle)
end

def game(attempts, ridle)
	until attempts == 0
		input = gets.chomp
		break if input == 'quit'
		save_game(attempts, ridle) if input == 'save'	
		ridle.guessed? ? break : game_core(attempts, ridle)
		attempts -= 1
	end
	puts "Sorry. Your haven't any attempts" if attempts == 0
end

def game_info
	puts 'To save game put "save"'
	puts 'To quit game put "quit"'
	puts 'I guess a word, you have 15 attempts to learn it'
end

def game_core(attempts, ridle)
	puts "You still have #{attempts} attempts"
	print "Enter a letter: "
	letter = gets.chomp
	until @@regex =~ letter
		puts 'Wrong letter'
		letter = gets.chomp
	end
	ridle.insert_letter(letter)
	puts ridle.template
end

def save_game(attempts_to_save, ridle_to_save)
	yaml_object = YAML.dump({:ridle => ridle_to_save, 
							:attempts => attempts_to_save})
	Dir.mkdir('saved') unless Dir.exists?('saved')
	File.open('saved/saved_game.yaml', 'w') do |file|
		file.puts yaml_object
	end
	puts 'Game was saved'
end

def load_game
	saved_content = File.read('saved/saved_game.yaml')
	object = YAML.load(saved_content)
	attempts = object[:attempts]
	ridle = object[:ridle]
	game(attempts, ridle)
end

loop do
	puts 'To start new game enter "new"'
	puts 'To load last saved game enter "load"'
	puts 'To quit app put "exit"'
	command = gets.chomp
	if command == 'new'
		new_game
	elsif command == 'load'
		load_game
	else
		exit
	end
end
