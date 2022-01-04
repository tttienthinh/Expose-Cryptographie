
# PROBLEME 1

create table Astre(nomAstre varchar(100), diametre int , PRIMARY KEY (nomAstre));
insert into Astre(nomAstre, diametre) values("Soleil", 1372000);
insert into Astre(nomAstre, diameDROPtre) values("Alpha Centauri", 851120);

create table Planete(nomAstre varchar(100), nomPlanete varchar(100) ,  diametre int, masse int ,tempsRevolution int , PRIMARY KEY (nomPlanete,nomAstre) ,FOREIGN KEY (nomAstre) REFERENCES Astre(nomAstre));
insert into Planete(nomAstre, nomPlanete , diametre , masse, tempsRevolution) values("Soleil" , "Terre", 12000, 59,365);
insert into Planete(nomAstre, nomPlanete , diametre , masse, tempsRevolution) values("Soleil" , "Mars", 6000, 10,600);
insert into Planete(nomAstre, nomPlanete , diametre , masse, tempsRevolution) values("Alpha Centauri" , "Proxima", 180000, 200,100);


create table Astrophysicien(nom varchar(100), prenom varchar(100) ,  pays varchar(100) , PRIMARY KEY (nom,prenom));
insert into Astrophysicien(nom, prenom , pays) values("Einstein","Albert","Allemagne");
insert into Astrophysicien(nom, prenom , pays) values("Curie","Marie","France");
insert into Astrophysicien(nom, prenom , pays) values("Curie","Pierre","France");
insert into Astrophysicien(nom, prenom , pays) values("Feynman","Richard","USA");


create table Asteroide(nomAsteroide varchar(100), masse int ,nom varchar(100), prenom varchar(100) ,  PRIMARY KEY (nomAsteroide) ,FOREIGN KEY (nom,prenom) REFERENCES Astrophysicien(nom,prenom));
insert into Asteroide(nomAsteroide,masse,nom,prenom) values("Albertum 1 " , 50 , "Einstein", "Albert");
insert into Asteroide(nomAsteroide,masse,nom,prenom) values("Albertum 2" , 150 , "Einstein","Albert");
insert into Asteroide(nomAsteroide,masse,nom,prenom) values("Currium 2" , 10 , "Curie","Marie" );
insert into Asteroide(nomAsteroide,masse,nom,prenom) values("Currium 3" , 10 , "Curie","Marie" );
insert into Asteroide(nomAsteroide,masse,nom,prenom) values("Currium 1" , 20 , "Curie","Pierre");

create table Colision(nomAstre varchar(20) , nomPlanete varchar(20) , nomAsteroide varchar(20) , date_c varchar(100) ,
PRIMARY KEY (nomPlanete,nomAstre,nomAsteroide) ,FOREIGN KEY (nomAstre) REFERENCES Astre(nomAstre) , FOREIGN KEY (nomPlanete) REFERENCES Planete(nomPlanete) , FOREIGN KEY (nomAsteroide) REFERENCES Asteroide(nomAsteroide));
insert into Colision(nomAstre,nomPlanete, nomAsteroide,date_c) values ("Soleil","Terre","Albertum 1","10/10/2002");
insert into Colision(nomAstre,nomPlanete, nomAsteroide,date_c) values ("Soleil","Terre","Albertum 2","10/10/2002");
insert into Colision(nomAstre,nomPlanete, nomAsteroide,date_c) values ("Alpha Centauri","Proxima","Albertum 2","9/10/2002");
insert into Colision(nomAstre,nomPlanete, nomAsteroide,date_c) values ("Alpha Centauri","Proxima","Currium 2","8/10/2002");
insert into Colision(nomAstre,nomPlanete, nomAsteroide,date_c) values ("Alpha Centauri","Proxima","Albertum 1","7/10/2002");




# PROBLEME 2

create table Fabricant(Numero int , Nom varchar(100) , PRIMARY KEY (Numero));
create table Produit(Numero int,Nom varchar(100) , Prix int ,Numfab int, PRIMARY KEY (Numero) , FOREIGN KEY (Numfab) REFERENCES Fabricant(Numero));
create table Client(Numero int,Nom varchar(100), Prenom varchar(100) , DateNaiss date,Ville varchar(100), Adresse varchar(100) , PRIMARY KEY (Numero));
create table Commande(Numclient int,Numproduit int, Date_c date , Quantite int , FOREIGN KEY (Numclient) REFERENCES Client(Numero) , FOREIGN KEY (Numproduit) REFERENCES Produit(Numero));

insert into Fabricant(Numero, Nom) values(1,"Carrefour");
insert into Fabricant(Numero, Nom) values(2,"Amazon");
insert into Fabricant(Numero, Nom) values(3,"Apple");

insert into Produit(Numero,Nom,Prix,Numfab) values(1,"Iphone",500,3);
insert into Produit(Numero,Nom,Prix,Numfab) values(2,"Ipad",700,3);
insert into Produit(Numero,Nom,Prix,Numfab) values(3,"Casque de Ski",30,2);
insert into Produit(Numero,Nom,Prix,Numfab) values(4,"Tenue de Ski",100,2);
insert into Produit(Numero,Nom,Prix,Numfab) values(5,"Pommees",5,1);

insert into Client(Numero, Nom , Prenom,DateNaiss, Ville,Adresse) values(1,"Dupont","Jean","2000-01-01","Paris","3 rue des coniferes");
insert into Client(Numero, Nom , Prenom,DateNaiss, Ville,Adresse) values(2,"Auchet","Pierre","2000-01-01","Paris","3 rue des coniferes");
insert into Client(Numero, Nom , Prenom,DateNaiss, Ville,Adresse) values(3,"Bodot","Paul","2000-01-01","Paris","3 rue des coniferes");
insert into Client(Numero, Nom , Prenom,DateNaiss, Ville,Adresse) values(4,"Josh","Jacques","2000-01-01","Paris","3 rue des coniferes");
insert into Client(Numero, Nom , Prenom,DateNaiss, Ville,Adresse) values(5,"Smith","Aaron","2000-01-01","Paris","3 rue des coniferes");


insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(1,2,"2021-12-12",4);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(2,3,"2021-2-12",10);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(5,2,"2021-03-12",2);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(1,1,"2021-02-12",4);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(4,4,"2021-12-09",4);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(4,4,"2021-12-02",1);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(1,2,"2021-12-11",2);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(1,5,"2021-12-11",2);
insert into Commande(Numclient, Numproduit,Date_c,Quantite) values(3,1,"2021-12-11",2);


















