#Q2
create database spectacles;
use spectacles;
create table Personne(
idPersonne int primary key auto_increment,
nom varchar(30),
prenom varchar(30),
age int 
);
create table Salle(
idSalle int primary key,
nom varchar(45),
nbPlaces int
);
create table Spectacle(
idSpectacle int primary key,
dateSpectacle date,
nbBilletsVendus int,
idSalle int,
foreign key(idSalle) references Salle(idSalle)
);
create table Categorie(
idCategorie int primary key,
prix decimal
);
create table Billet(
id int primary key auto_increment,
idPersonne int,
idSpectacle int,
idCategorie int,
foreign key(idPersonne) references Personne (idPersonne),
foreign key(idSpectacle) references Spectacle (idSpectacle),
foreign key(idCategorie) references Categorie (idCategorie)
);
#Q3
alter table Personne add column ville text;
#Q4
alter table Personne add constraint age check(age between 20 and 60);
#Q5
select * from Spectacle where dateSpectacle=current_date();
#Q6 
#a

select P.* from Personne P
join Billet B on P.idPersonne = B.idPersonne
join Spectacle S on B.idSpectacle = S.idSpectacle
where S.idSpectacle = 10;

#b
select S.idSpectacle,S.dateSpectacle,COUNT(P.idPersonne) AS NombreParticipants
from Spectacle S join Billet B on S.idSpectacle = B.idSpectacle
join Personne  P on B.idPersonne = P.idPersonne
where P.age between 30 and 60
group by S.idSpectacle, S.dateSpectacle;

#c
select P.nom, P.prenom, S.idSalle,S.idSpectacle from Personne P
join Billet B on P.idPersonne = B.idPersonne join Spectacle S on
B.idSpectacle = S.idSpectacle join Salle Sl on S.idSalle = Sl.idSalle
where S.dateSpectacle=current_date();

#d
select idSpectacle,count(nbBilletsVendus) as MontantTotal from Spectacle group by idSpectacle;

#e
select C.idCategorie,count(*) as MontantTatalCategorie from Categorie C join Billet B on 
C.idCategorie = B.idCategorie join Spectacle S on B.idSpectacle = S.idSpectacle
where year(S.dateSpectacle)= year(current_date) 
group by C.idCategorie;

#Q7
create user admin1@localhost identified By '@dminUN';
Grant select,insert,delete,update on spectacles.* to admin1@localhost;

create user admin2@localhost identified by '@dminDeux';
grant select on spectacles.* to admin2@localhost;

create user admin3@localhost identified by '@dminTrois';
grant select, insert on spectacles.* to admin3@localhost;





