from lxml import etree

# 
tree = etree.parse('Adressbuch1854_complete.xml')
root = tree.getroot()

i = 1
for person in root:
    if person not in tree.xpath(".//persons/descendant::postcode[contains(., '75019')]/ancestor::persons"):
        root.remove(person)
    else:
        print(i)
        i += 1

tree.write("19arrd.xml", xml_declaration=True, encoding="UTF-8")
