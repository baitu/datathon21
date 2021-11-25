# lxml is the library we're using for XML
from lxml import etree


# open file, print content into tree format
tree = etree.parse('Adressbuch1854_complete.xml')

# store root elmt in variable root
root = tree.getroot()

# XPath to persons elements from 19. arrd
xpath = tree.xpath(".//persons/descendant::postcode[contains(., '75019')]/ancestor::persons")

i = 1 # variable to count the loops
for person in root: # iterate over child elements of root
    # check if child elmt is in XPath
    if person not in xpath:
        # remove elements not from 19. arrd
        root.remove(person)
    else:
        # count loops; should be 34
        print(i)
        i += 1

# export resulting tree into file
tree.write("19arrd.xml", xml_declaration=True, encoding="UTF-8")
