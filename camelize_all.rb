def camelize_all(dir)
  paths = Dir.glob("#{dir}/**/*.*")
  paths.each do |path|
    before = IO.read(path)
    before.force_encoding('UTF-8')
    before = before.scrub('?')
    list = before.split("\n")
    after = list.map do |line|
      if line.match(/(_)([a-z]+)/).nil?
        line
      else
        line.gsub!(/(_)([a-z]+)/) do |word|
          $2.capitalize unless word.nil?
        end
      end
    end.join("\n")
    IO.write(path, after)
  end
end
