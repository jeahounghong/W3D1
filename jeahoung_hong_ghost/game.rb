require_relative 'player.rb'

class Game

    @@ALPHABET = "abcdefghijklmnopqrstuvwxyz"

    attr_reader :players

    def initialize(names)
        @players = []
        names.each do |name|
            @players << [Player.new(name), 0]
        end

        @current_player = @players[0][0]
        @previous_player = nil
        @fragment = ""
        @dictionary = Hash.new {0}
        file = File.open('dictionary.txt')
        file.each_line do |line|
            @dictionary[line.chomp] += 1
        end
        file.close
    end

    def next_player!
        @previous_player = @current_player
        idx = 0
        @players.each_with_index do |el,i|
            idx = (i + 1) % @players.length if el[0] == @current_player
        end
        @current_player = @players[idx][0]
    end

    def play_round
        begin 
            puts "The word is currently #{@fragment.upcase}"
            answer = @current_player.take_turn
            valid_keys?(answer)
        rescue ArgumentError => e
            p e.message
            p "Please enter only a valid single character"
            retry
        end
        @fragment += answer
        puts "The word so far is '#{@fragment}'"

        self.next_player!
    end

    def valid_keys?(str)
        new_fragment = @fragment + str
        valid_keys = @dictionary.select { |e| e.start_with?(@fragment + str) }.keys
        unless valid_keys.length > 0
            raise ArgumentError.new "Not a valid character"
        end
    end

    def no_more_keys?
        arr = @@ALPHABET.split("")
        count = 0
        arr.each do |el|
            c = @dictionary.select { |e| e.start_with?(@fragment + el) }.keys
            count += c.length
        end
        return count == 0
    end

    def run
        while !self.game_over? do
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            puts
            p "The current player is #{@current_player.name}"
            self.play_round
            if no_more_keys?
                @players.each_with_index do |el,i|
                    @players[i][1] += 1 if el[0] == @previous_player
                end
                puts "*********************************************"
                puts "#{@previous_player.name} lost this round!!!!!!"
                puts "#{@previous_player.name} finished the word #{@fragment.upcase}"
                puts "SCORES:"
                @players.each do |el|
                    puts "#{el[0].name}: #{el[1]} LOSSES"
                end
                @fragment = ""
                puts "#{@current_player.name} is starting a new game: "

            end
        end
    end

    def game_over?
        @players.each do |el|
            return true if el[1] == 5
        end
        false
    end

end

# Where the game begins
begin
    puts "Hello, welcome to the game of GHOST! How many players would you like to have today?"
    answer = gets.chomp
    p answer
    if answer.to_i.to_s != answer
        raise ArgumentError.new "Please enter an integer"
    end
rescue ArgumentError => e
    p e.message
    retry
end

num_players = answer.to_i
names = []
(0...num_players).each do |i|
    puts "What is the name of Player #{i + 1}?"
    names << gets.chomp
end
p names

game = Game.new(names)
game.run
