require 'iconv'

def rna(old) 
	return old.gsub(/[\x80-\xff]/,"")
end

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
					line = line.split.join(" ")
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

def remove_duplicates
	text=File.open("DATA.TXT").read
	text.delete!("^\u{0000}-\u{007F}")
	unique = []
	text.each_line do |line|
		ls = line.split.join(" ").split(";;;")
		put_in = true
		unique.each do |u|
			if ((u[2] == ls[2]) and (u[3] == ls[3]))
				put_in = false
			end
		end
		if put_in
			unique << ls
		end
	end
	return unique
end

def write_jsons(unique)
	file = File.open("JSONS.TXT", "w")
	unique.each do |u|
		file.write("{name:\"" + rna(u[1].slice(0, 250)) + "\",y:" + u[2].to_s + ",x:" + u[3].to_s + ",category: \"" + rna(u[0]) + "\"},")
	end
	file.close unless file == nil
end



file = File.open("DATA.TXT", "w")
read_file(1,file)
read_file(2,file)
file.close unless file == nil
write_jsons(remove_duplicates)