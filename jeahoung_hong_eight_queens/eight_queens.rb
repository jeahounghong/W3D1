require 'csv'
def repeats?(arr)
    hash = Hash.new{0}
    arr.each do |el|
        hash[el] += 1
    end
    return !hash.any? {|k,v| v > 1}
end

possible_layouts = []
len = 8

(0...len).each do |q|
    arr = []
    arr << q
    (0...len).each do |w|
        arr << w
        (0...len).each do |e|
            arr << e
            (0...len).each do |r|
                arr << r
                (0...len).each do |t|
                    arr << t
                    (0...len).each do |y|
                        arr << y
                        (0...len).each do |u|
                            arr << u
                            (0...len).each do |i|
                                arr << i
                                temp = [arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7]]
                                print temp
                                # puts temp
                                possible_layouts << temp if repeats?(temp)

                                arr.pop
                            end
                            arr.pop
                        end
                        arr.pop
                    end
                    arr.pop
                end
                arr.pop
            end
            arr.pop
        end
        arr.pop
    end
end




# only_diag_layout = []
# possible_layouts.each_with_index do |arr,i|
#     hash = Hash.new{0}
#     arr.each do |el|
#         hash[el] += 1
#     end
#     if !hash.any? {|k,v| v > 1}
#         only_diag_layout << arr
#     end
# end



puts
puts possible_layouts.length
puts possible_layouts[0]
puts
CSV.open('file.csv', 'w') do |csv|
    possible_layouts.each { |ar| csv << ar }
end

# possible_layouts.each do |el|
#     puts
#     puts el
# end

# (0...len).each do |q|
#     layout = Array.new(len) {Array.new(len, :X)}
#     layout[q][0] = :Q
#     (0..len).each do |w|
#         layout[w][1] = :Q
#         p layout
#         possible_layouts << layout
#         # CODE
#         layout[w].each_with_index do |el,i|
#             el = :X
#         end
#     end
# end
