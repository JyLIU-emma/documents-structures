import csv
from lxml import etree

with open('sanisettesparis.csv', 'r', encoding='utf-8') as csvfile :
    reader = csv.reader(csvfile, delimiter=';')
    rows = [row for row in reader]

racine = etree.Element('toilettes')

for row in rows[1:] :
    toilette = etree.SubElement(racine, 'toilette', type=f'{row[0]}')
    if row[1] :
        toilette.set('statut', row[1])
        
    adresse = etree.SubElement(toilette, 'adresse')
    etree.SubElement(adresse, 'libelle').text = row[2]
    etree.SubElement(adresse, 'arrondissement').text = row[3]

    etree.SubElement(toilette, 'horaire').text = row[4]

    service = etree.SubElement(toilette, 'services')
    etree.SubElement(service, 'acces-pmr').text = row[5]
    etree.SubElement(service, 'relais-bebe').text = row[6]

    etree.SubElement(toilette, 'equipement').text = row[7]


xml_out = etree.tostring(racine, xml_declaration=True, pretty_print=True, encoding='utf-8', doctype='<!DOCTYPE toilettes SYSTEM "wc.dtd">')

with open('toilettes-paris.xml', 'w', encoding='utf-8') as fic :
    print(bytes.decode(xml_out), file=fic)



