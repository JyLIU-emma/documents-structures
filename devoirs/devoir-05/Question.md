## Question sur 2e exercice
Quand je fait le 2e exercice, je ne vois pas les messages d'erreur, c'est toujours validation réussie (même si j'essaie avec une structure différente du fichier Rom.xml), je ne sais pas pourquoi donc je fais l'exo selon l'exemple mais je ne peux pas examiner la réponse.  

Réponse: le fichier Rom.xml contient un espace de nom, donc on doit aussi ajouter `<sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="t"/>` dans le schema (fichier.sch) et ajouter le prefixe chaque fois on indique l'élément du xml.
