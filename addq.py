from lxml import etree

tree = etree.parse("Adressbuch1854_complete.xml")

# open csv file
csvfile = open("streets.csv", "r")
# write csv content line by line to a list of strings
csv = csvfile.readlines()
# close csv file
csvfile.close()

streetdict = {}

# iterate over lines in list
for line in csv: # for each line
    split = line.split(",") # split the line into cells
    streetdict[split[3]] = split[5] # in dict save col3 as key, col5 as value

# delete noise
del(streetdict['Unbekannt'])
del(streetdict['Vermutlich: Rue Feutrier'])

xpath = tree.xpath(".//name_new") # extract street names

# check if street name is saved in dict, add id attribute if it is
for street in xpath:
    if street.text in streetdict.keys():
        street.attrib["id"] = streetdict[street.text]

# print to file
tree.write("Adressbuch_new.xml", xml_declaration=True, encoding="UTF-8")