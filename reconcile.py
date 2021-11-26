strlist = [] # intermediate output in list form
out = "" # final output in string form

# open csv file
csvfile = open("streets.csv", "r")
# write csv content line by line to a list of strings
content = csvfile.readlines()
# close csv file
csvfile.close()

# iterate over lines in list
for line in content: # for each line
    split = line.split(",") # split the line into cells
    string = "\n\t<streetname>" + split[3] + "</streetname>\n\t<qnumber>" + split[5] + "</qnumber>\n" # write content of cell 4 and 6 to a string
    strlist.append(string) # add the string  to a list

# iterate over strings in the list
for string in strlist: # for each string
    out += "<street>" + string + "</street>\n" # add string between tags to output string

xfile = open("output.xml", "w") # create xml file
xfile.write(out) # write output string to xml file
xfile.close() # close xml file