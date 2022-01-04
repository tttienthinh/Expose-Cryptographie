# PB 1
# 1
/*
Les clés primaires :
	- Astre : nomAstre
	- Planète : nomAstre, nomPlanète
	- Astrophysicien : nom, prenom
	- Asteroide : nomAsteroide
	- Collision : nomAstre, nomPlanète, nomAsteroide
*/

# 2
/*
Les clés étrangères :
	- Astre : 
	- Planète : nomAstre ref Astre
	- Astrophysicien : 
	- Asteroide : (nom, prenom) ref Astrophysicien
	- Collision : nomAstre ref Astre, nomPlanète ref Planete, nomAsteroide ref Asteroide
*/


# 3
# 3.a
SELECT * FROM Astre WHERE diametre>1000000;

# 3.b
SELECT nomPlanete, tempsRevolution 
FROM Planete 
WHERE nomAstre="soleil" AND tempsRevolution>500;

# 4
# 4.a
SELECT DISTINCT nom, prenom FROM Asteroide;

# 4.b
SELECT nom, prenom 
FROM Astrophysicien
WHERE (nom, prenom) 
	NOT IN (
	SELECT nom, prenom
	FROM Asteroide
);

# 4.c
SELECT Astre.nomAstre 
FROM Astre
JOIN Planete ON Planete.nomAstre=Astre.nomAstre
JOIN Collision ON Planete.nomAstre=Collision.nomAstre 
	AND Planete.nomPlanete=Collision.nomPlanete
GROUP BY nomAstre
HAVING (Astre.nomAstre, COUNT(DISTINCT Collision.nomPlanete)) in (
	SELECT Planete.nomAstre, COUNT(*)
	FROM Planete
	GROUP BY Planete.nomAstre
);

# 5
# 5.a
SELECT nom, prenom, COUNT(*)
FROM Asteroide
GROUP BY nom, prenom;

# 5.b
SELECT nomAstre
FROM Planete
GROUP BY nomAstre
HAVING COUNT(*) = (
	SELECT MAX(Planete_filtre.nb)
	FROM (
		SELECT nomAstre,  COUNT(*) AS nb
		FROM Planete
		GROUP BY nomAstre
	) AS Planete_filtre
);

# 5.c
SELECT nomAstre, nomPlanete
FROM Collision
GROUP BY nomAstre, nomPlanete
HAVING COUNT(*) = (
	SELECT MAX(Collision_filtre.nb) 
	FROM (
		SELECT COUNT(*) as nb
		FROM Collision
		GROUP BY nomAstre, nomPlanete
	) AS Collision_filtre
);

# PB 2
# 1
/*

Les clés primaires :
	- Fabricant : Numero
	- Produit : Numero
	- Client : Numero
	- Commande : Numclient, Numproduit, Date
*/

# 2


# 3
SELECT count(Client.Numero) FROM Client;

# 4
SELECT Nom, Prenom FROM Client ORDER BY Nom, Prenom;

# 5
SELECT DISTINCT Numclient FROM Commande WHERE Quantite>1 
UNION
SELECT DISTINCT Numclient FROM Commande GROUP BY Numclient, Numproduit HAVING SUM(Quantite);

# 6
SELECT Numero, Nom FROM Produit WHERE Nom LIKE "%ski%";

# 7
SELECT Date, Numclient, Numproduit, Prix*Quantite
FROM Commande
JOIN Produit ON Numero=Numproduit
ORDER BY Date;

# 8
SELECT Date, Numclient, Numproduit, Client.Nom, Prix*Quantite
FROM Commande
JOIN Produit ON Produit.Numero=Numproduit
JOIN Client ON Client.Numero=Numclient
ORDER BY Date_c;

# 9
SELECT Numclient, COUNT(*) 
FROM Commande 
JOIN Client ON Numero=Numclient
GROUP BY Numclient
ORDER BY DateNaiss DESC;

# 10
SELECT Numclient, Client.Nom, Numproduit, Prix*Quantite
FROM Commande
JOIN Client ON Client.Numero=Numclient
JOIN Produit ON Produit.Numero=Numproduit
ORDER BY Client.Nom;

# 11
SELECT DISTINCT Fabricant.Numero 
FROM Commande
JOIN Client ON Client.Numero=Numclient
JOIN Produit ON Produit.Numero=Numproduit
JOIN Fabricant ON Fabricant.Numero=Numfab
WHERE Client.Nom="Chivé" AND Client.Prenom="Florian";

# 12
SELECT Client.Nom, Client.Prenom, Prix*Quantite
FROM Commande
JOIN Client ON Client.Numero=Numclient
JOIN Produit ON Produit.Numero=Numproduit
JOIN Fabricant ON Fabricant.Numero=Numfab
WHERE Fabricant.Nom="APPLE";




