require 'csv'

arr1 = [[1,2],[3,4]]

CSV.open('file.csv', 'w') do |csv|
    arr1.each { |ar| csv << ar }
end