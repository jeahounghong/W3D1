class Array

    def my_each(&prc)
        i = 0
        while i < self.length do
            prc.call(self[i])
            i += 1
        end

        self
    end

    def my_select(&prc)
        i = 0
        new_arr = []
        self.my_each do |el|
            new_arr << el if prc.call(el)
        end

        new_arr
    end

    def my_reject(&prc)
        new_arr = []
        self.my_each do |el|
            new_arr << el if !prc.call(el)
        end

        new_arr
    end

    def my_any?(&prc)
        self.my_each do |el|
            return true if !prc.call(el)
        end

        false    
    end

    def all?(&prc)
        self.my_each do |el|
            return false if !prc.call(el)
        end

        true
    end


    def my_flatten
        arr = []
        self.each do |el|
            if el.kind_of?(Array)
                arr += el.my_flatten
            else
                arr += [ el ]
            end

        end
        arr
    end

    def my_zip(*args)
        new_arr = []
        self.each_with_index do |el,i|
            arr = []
            arr << el
            args.each do |ele|
                arr << ele[i]
            end
            new_arr << arr
        end
        new_arr
    end

    def my_rotate(n = 1)
        return self if n == 0
        arr = []
        actual_rotate = n % self.length
        if n < 0
            actual_rotate = actual_rotate*-1
            arr = self[(-1*actual_rotate)..-1] + self[0..(-1*actual_rotate - 1)]
        else
            arr = self[(actual_rotate) .. -1 ]+self[0...actual_rotate]
        end
        arr
    end

    def my_join(str = "")
        return_string = ""
        self.my_each do |el|
            return_string += el.to_s + str
        end
        return return_string[0..-(str.length + 1)]
    end

    def my_reverse
        new_arr = []
        self.my_each do |el|
            new_arr.unshift(el)
        end
        new_arr
    end
end


# MY SELECT
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []
puts

# MY_FLATTEN
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten
puts

# MY ZIP
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
puts

# MY ROTATE
a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
puts

# MY JOIN
a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"
puts

# MY REVERSE
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]


