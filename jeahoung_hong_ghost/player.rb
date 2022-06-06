
class Player

    attr_reader :name

    def initialize(name)
        @name = name
    end

    def take_turn
        alphabet = "qwertyuiopasdfghjklzxcvbnm"
        p "please enter a character"
        answer = gets.chomp
        unless alphabet.include?(answer.downcase)
            raise ArgumentError.new "Please enter only a single character"
        end
        return answer
    end
end