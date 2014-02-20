def find_coords (ls)
	puts "here"
	possible = []
	ls.each do |c|
		if(is_number c)
			possible << c
		end
	end
	possible = possible.each.map{|c| c.to_f}
	coords = [0,0]
	possible.each do |c|
		if ((55.925 < c) and (c < 55.98))
			coords[1] = c
		end
		if ((-3.29 < c) and (c < -3.15))
			coords[0] = c
		end
	end
	unless (coords[0] == 0 or coords[1] == 0)
		return coords
	end
	return nil
end

def is_number (num)
	true if Float(num) rescue false
end

def read_file(num,file)
	directories = Dir.entries("SOURCE" + num.to_s)
	dirs = []
	directories.each do |l|
		dirs << l.split('.')
	end

	dirs.each do |dir|
		unless (dir[0].nil?)
			text=File.open('SOURCE' + num.to_s + '/' + dir[0] + '.csv').read
			text.gsub!(/\r\n?/, "\n")
			text.each_line do |line|
				begin
					line = line.gsub('"', "")
					line = line.gsub('\'', "")
					line = line.split.join("")
					ls = line.split(',')
					if ls.length >= (3 + num)
						coords = find_coords(ls)
						print coords
						unless (coords.nil?)
							file.write([[dir[0],ls[num - 1],coords[1],coords[0]].join(";;;"),["\n"]].join(""))
						end
					end
				rescue
					#puts "Error at: " + line
				end
			end
		end
	end


end



file = File.open("DATA.TXT", "w")
read_file(1,file)
read_file(2,file)
file.close unless file == nil