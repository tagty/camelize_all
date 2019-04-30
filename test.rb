require 'fileutils'
require_relative './camelize_all'

FileUtils.mkdir_p('./dir0/dir1/dir2')
['./dir0/test0.txt', './dir0/dir1/test1.txt', './dir0/dir1/dir2/test2.txt'].each do |path|
  File.open(path, 'w', 0777) { |f| f.print "this_is_snake_case\nand_this_too\nthisIsCamelCase" }
end

camelize_all('./dir0')

test0 = IO.read('./dir0/test0.txt')
test1 = IO.read('./dir0/dir1/test1.txt')
test2 = IO.read('./dir0/dir1/dir2/test2.txt')
test_expected = "thisIsSnakeCase\nandThisToo\nthisIsCamelCase"

errors = []
3.times do |n|
  if eval("test#{n}") == test_expected
    print '*'
  else
    print 'f'
    errors << "test#{n} is:\n#{test0}"
  end
end

puts ''
if errors.empty?
  puts 'succeeded!'
else
  puts errors.join("\n")
end
