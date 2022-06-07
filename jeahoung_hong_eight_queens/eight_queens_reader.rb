require 'csv'

def diag_down?(arr)
    diagonal_is_clear = true
    arr.each_with_index do |el,i|
        (i+1...arr.length).each do |n|
            num = n - i
            diagonal_is_clear = false if el.to_i == arr[n].to_i - num
        end
    end
    return diagonal_is_clear
end
def diag_up?(arr)
    diagonal_is_clear = true
    arr.each_with_index do |el,i|
        (i+1...arr.length).each do |n|
            num = n - i
            diagonal_is_clear = false if el.to_i == arr[n].to_i + num
        end
    end
    return diagonal_is_clear
end
# arr = [1,2,3,4,5,6,7,8]
# arr = [1,1]
# p diag_down?(arr)
# p diag_up?(arr)

possible_layouts = CSV.read('file.csv')
arr = []
possible_layouts.each do |el|
    arr << el if diag_down?(el) && diag_up?(el)
end

p arr.length



