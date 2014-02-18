def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False


lines = [line.strip() for line in open('Source.txt')]
file = open("result", 'w')
category = "Parks and gardens"
for line in lines :
	line = line.replace("\"", "")
	line = line.replace("\'", "")
	line = line.replace("\n", "")
	data = line.split(",")
	if len(data) > 3 :
		name = data[0].strip()
		name = (name[:75] + '..') if len(name) > 75 else name
		print line
		y = data[len(data) - 2].strip()
		x = data[len(data) - 1].strip()
		if ((name != "") and (x != "") and (y != "") and (is_number(x)) and (is_number(y))) :
			file.write("{")
			file.write("name:\"lala\",")
			file.write("y:" + y + ",")
			file.write("x:" + x + ",")
			file.write("category: \"" + category + "\"")
			file.write("},")

