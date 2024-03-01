--cod cerinta 10

create sequence flor_seq
    start with 1
    increment by 1
    nocache
    nocycle;

--cod cerinta 11

create table ROL_ANGAJAT
    (id_rol number(5) constraint pkey_rol primary key,
    NumeRol varchar(20) constraint NumeRol not null,
    DescriereRol varchar(100) constraint DescriereRol null
    );

insert into ROL_ANGAJAT
values(flor_seq.nextval,'Florar','Angajatul responsabil cu aranjarea buchetelor și compozițiilor florale.');

insert into ROL_ANGAJAT
values(flor_seq.nextval,'Manager','Angajatul cu rol de supervizare și coordonare a operațiunilor zilnice ale florăriei.');

insert into ROL_ANGAJAT
values(flor_seq.nextval,'Specialist design','Angajatul cu expertiză în creația de aranjamente florale pentru evenimente.');

insert into ROL_ANGAJAT
values(flor_seq.nextval,'Vânzător','Angajatul care interacționează direct cu clienții.');

insert into ROL_ANGAJAT
values(flor_seq.nextval,'Livrator','Angajatul responsabil cu livrarea florilor și aranjamentelor la adresele indicate de clienți.');



create table ANGAJAT
    (id_angajat number(5) constraint pkey_angajat primary key,
    id_rol number(5), constraint fk_angajat_rol foreign key(id_rol) references ROL_ANGAJAT(id_rol),
    NumeAngajat varchar(30) constraint NumeAngajat not null,
    PrenumeAngajat varchar(30) constraint PrenumeAngajat not null,
    DataAngajare date constraint DataAngajare not null,
    Salariu number(10) constraint Salariu not null
    );

insert into ANGAJAT
values(flor_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Florar'),'Ionescu','Anastasia',to_date('16-08-2019','DD-MM-YYYY'),5000);

insert into ANGAJAT
values(flor_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Florar'),'Florescu','Letitia',to_date('04-07-2019','DD-MM-YYYY'),5100);

insert into ANGAJAT
values(flor_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Manager'),'Stanescu','Stefan',to_date('01-12-2005','DD-MM-YYYY'),9000);

insert into ANGAJAT
values(flor_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Specialist design'),'Dumitrache','Rafael',to_date('10-03-2019','DD-MM-YYYY'),6200);

insert into ANGAJAT
values(flor_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Specialist design'),'Teodorescu','Eleonora',to_date('15-04-2015','DD-MM-YYYY'),6400);



create table ADRESA
    (id_adresa number(5) constraint pkey_adresa primary key,
    Oras varchar(20) constraint Oras not null,
    Strada varchar(30) constraint Strada not null,
    Numar number(5) constraint Numar not null,
    Bloc varchar(20) constraint Bloc null,
    Scara number(5) constraint Scara null,
    Etaj number(5) constraint Etaj null,
    Apartament number(5) constraint Apartament null,
    CodPostal varchar(20) constraint CodPostal not null
    );

insert into ADRESA
values (flor_seq.nextval, 'Bucuresti', 'Str. Victoriei', 10, null, null, null, null, '010101');

insert into ADRESA
values (flor_seq.nextval, 'Cluj-Napoca', 'Str. Bucuriei', 15, 'A', 2, 3, 7, '400000');

insert into ADRESA
values (flor_seq.nextval, 'Timisoara', 'Str. Mihai Viteazu', 8, 'B3', 1, 6, 60, '300100');

insert into ADRESA
values (flor_seq.nextval, 'Iasi', 'Str. Stefan Cel Mare', 25, null, null, null, null, '700300');

insert into ADRESA
values (flor_seq.nextval, 'Constanta', 'Bd. Mamaia', 20, null, null, null, null, '900001');



create table CLIENT
    (id_client number(5) constraint pkey_client primary key,
    id_adresa number(5), constraint fk_client_adresa foreign key(id_adresa) references ADRESA(id_adresa),
    NumeClient varchar(30) constraint NumeClient not null,
    PrenumeClient varchar(30) constraint PrenumeClient not null,
    EmailClient varchar(30) constraint EmailClient not null unique,
    TelefonClient varchar(30) constraint TelefonClient not null unique
    );

insert into CLIENT
values (flor_seq.nextval,11,'Popescu','Ioana','ioanapopescu@gmail.com','0744322188');

insert into CLIENT
values (flor_seq.nextval,12,'Apostol','Teodora','teodoraapostol@yahoo.com','0744325438');

insert into CLIENT
values (flor_seq.nextval,13,'Olteanu','Stefan','stefanolteanu@gmail.com','0734522188');

insert into CLIENT
values (flor_seq.nextval,14,'Tintea','Alexandru','alextintea@gmail.com','0744678388');

insert into CLIENT
values (flor_seq.nextval,15,'Nica','Ana','ananica@ymail.com','0722722722');

insert into CLIENT
values (flor_seq.nextval,11,'Feurdean','Mihai','mihaifeur@gmail.com','0747777788');



create table RECENZIE
    (id_recenzie number(5) constraint pkey_recenzie primary key,
    id_client number(5), constraint fk_recenzie_client foreign key(id_client) references CLIENT(id_client),
    Evaluare number(2) constraint Evaluare not null,
    Comentariu varchar(100) constraint Comentariu null
    );

insert into RECENZIE
values (flor_seq.nextval,(select id_client from CLIENT where EmailClient='mihaifeur@gmail.com'),10,'Foarte mulțumit de servicii, personal amabil.');

insert into RECENZIE
values (flor_seq.nextval,(select id_client from CLIENT where EmailClient='mihaifeur@gmail.com'),9,null);

insert into RECENZIE
values (flor_seq.nextval,(select id_client from CLIENT where EmailClient='ananica@ymail.com'),8,'Produse de calitate, dar livrarea a întârziat.');

insert into RECENZIE
values (flor_seq.nextval,(select id_client from CLIENT where EmailClient='ioanapopescu@gmail.com'),5,'Nu am fost impresionata de calitatea produselor.');

insert into RECENZIE
values (flor_seq.nextval,(select id_client from CLIENT where EmailClient='alextintea@gmail.com'),10,'Recomand cu încredere, livrare rapidă și produse proaspete.');
   


create table COMANDA
    (id_comanda number(5) constraint pkey_comanda primary key,
    id_angajat number(5), constraint fk_comanda_angajat foreign key(id_angajat) references ANGAJAT(id_angajat),
    id_client number(5), constraint fk_comanda_client foreign key(id_client) references CLIENT(id_client),
    DataComanda date constraint DataComanda not null,
    TipPlata varchar(10) default 'cash' constraint TipPlata not null
    );

insert into COMANDA
values (flor_seq.nextval,6,(select id_client from CLIENT where EmailClient='mihaifeur@gmail.com'),to_date('15-12-2020','DD-MM-YYYY'),'card');

insert into COMANDA
values (flor_seq.nextval,6,(select id_client from CLIENT where EmailClient='ananica@ymail.com'),to_date('05-05-2020','DD-MM-YYYY'),'card');

insert into COMANDA
values (flor_seq.nextval,7,(select id_client from CLIENT where EmailClient='ananica@ymail.com'),to_date('27-11-2020','DD-MM-YYYY'),'cash');

insert into COMANDA
values (flor_seq.nextval,10,(select id_client from CLIENT where EmailClient='ioanapopescu@gmail.com'),to_date('04-06-2020','DD-MM-YYYY'),default);

insert into COMANDA
values (flor_seq.nextval,9,(select id_client from CLIENT where EmailClient='alextintea@gmail.com'),to_date('04-06-2021','DD-MM-YYYY'),'cash');



create table CATEGORIE_PRODUS
    (id_categprod number(5) constraint pkey_categprod primary key,
    NumeCategorie varchar(20) constraint NumeCategorie not null,
    Descriere varchar(100) constraint Descriere null
    );

insert into CATEGORIE_PRODUS
values (flor_seq.nextval,'Buchete','Buchete de flori proaspete și aranjamente florale elegante.');

insert into CATEGORIE_PRODUS
values (flor_seq.nextval,'Plante de interior',null);

insert into CATEGORIE_PRODUS
values (flor_seq.nextval,'Plante de exterior','Plante de exterior perene si anuale');

insert into CATEGORIE_PRODUS
values (flor_seq.nextval,'Accesorii','Ghivece, ambalaje, felicitari, ingrasaminte, decoratiuni etc.');

insert into CATEGORIE_PRODUS
values (flor_seq.nextval,'La bucata','Vanzare la fir.');



create table FURNIZOR
    (id_furnizor number(5) constraint pkey_furnizor primary key,
    NumeFurnizor varchar(30) constraint NumeFurnizor not null,
    AdresaFurnizor varchar(100) constraint AdresaFurnizor not null unique,
    TelefonFurnizor varchar(10) constraint TelefonFurnizor not null unique
    );

insert into FURNIZOR
values (flor_seq.nextval,'Fresco Verde','Strada Trandafirilor 10, București, 010101, România','0721123456');

insert into FURNIZOR
values (flor_seq.nextval,'Happy Flower Holland','Aleea Florilor 5, București, 400000, România','0765987654');

insert into FURNIZOR
values (flor_seq.nextval,'GreenLeaf Plants','Bulevardul Liliacului 25, București, 700000, România','0744555888');

insert into FURNIZOR
values (flor_seq.nextval,'Natures Garden Supplies','Strada Irisului 8, București, 300001, România','0782111222');

insert into FURNIZOR
values (flor_seq.nextval,'Bloom Nursery Co.','Splaiul Crizantemelor 3, București, 500100, România','0733999000');



create table PRODUS
    (id_produs number(5) constraint pkey_produs primary key,
    id_categprod number(5), constraint fk_produs_categprod foreign key(id_categprod) references CATEGORIE_PRODUS(id_categprod),
    id_furnizor number(5), constraint fk_produs_furnizor foreign key(id_furnizor) references FURNIZOR(id_furnizor),
    NumeProdus varchar(30) constraint NumeProdus not null,
    Pret number(5) constraint Pret not null
    );
    
insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Buchete'), (select id_furnizor from FURNIZOR where NumeFurnizor='Fresco Verde'), 'Buchet trandafiri', 100);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Buchete'), (select id_furnizor from FURNIZOR where NumeFurnizor='Fresco Verde'), 'Buchet de vara', 80);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Buchete'), (select id_furnizor from FURNIZOR where NumeFurnizor='Fresco Verde'), 'Buchet de primavara', 120);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de interior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Dracena', 50);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de interior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Happy Flower Holland'), 'Ficus lyrata', 30);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de interior'), (select id_furnizor from FURNIZOR where NumeFurnizor='GreenLeaf Plants'), 'Trandafir japonez', 50);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de exterior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Bloom Nursery Co.'), 'Trandafir englezesc', 60);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de exterior'), (select id_furnizor from FURNIZOR where NumeFurnizor='GreenLeaf Plants'), 'Cupressus sempervirens', 80);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de exterior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Bujor', 24);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Accesorii'), (select id_furnizor from FURNIZOR where NumeFurnizor='Happy Flower Holland'), 'Ghiveci ceramic', 25);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Accesorii'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Vaza de sticla', 25);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Accesorii'), (select id_furnizor from FURNIZOR where NumeFurnizor='Bloom Nursery Co.'), 'Felicitare', 15);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='La bucata'), (select id_furnizor from FURNIZOR where NumeFurnizor='GreenLeaf Plants'), 'Trandafir roz', 18);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='La bucata'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Crin alb', 14);

insert into PRODUS
values (flor_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='La bucata'), (select id_furnizor from FURNIZOR where NumeFurnizor='Happy Flower Holland'), 'Frezie galbenă', 10);



create table DETALII_COMANDA
    (id_detaliicomanda number(5) constraint pkey_detaliicomanda primary key,
    id_comanda number(5), constraint fk_detaliicomanda_comanda foreign key(id_comanda) references COMANDA(id_comanda),
    id_produs number(5), constraint fk_detaliicomanda_produs foreign key(id_produs) references PRODUS(id_produs),
    NumarProduse number(5) constraint NumarProduse not null
    );
    
insert into DETALII_COMANDA
values (flor_seq.nextval,27,(select id_produs from PRODUS where NumeProdus='Cupressus sempervirens'),1);

insert into DETALII_COMANDA
values (flor_seq.nextval,27,(select id_produs from PRODUS where NumeProdus='Ghiveci ceramic'),1);

insert into DETALII_COMANDA
values (flor_seq.nextval,28,(select id_produs from PRODUS where NumeProdus='Buchet trandafiri'),1);

insert into DETALII_COMANDA
values (flor_seq.nextval,29,(select id_produs from PRODUS where NumeProdus='Frezie galbenă'),15);

insert into DETALII_COMANDA
values (flor_seq.nextval,29,(select id_produs from PRODUS where NumeProdus='Vaza de sticla'),1);

insert into DETALII_COMANDA
values (flor_seq.nextval,29,(select id_produs from PRODUS where NumeProdus='Felicitare'),1);

insert into DETALII_COMANDA
values (flor_seq.nextval,30,(select id_produs from PRODUS where NumeProdus='Ghiveci ceramic'),3);

insert into DETALII_COMANDA
values (flor_seq.nextval,30,(select id_produs from PRODUS where NumeProdus='Trandafir englezesc'),1);

insert into DETALII_COMANDA
values (flor_seq.nextval,31,(select id_produs from PRODUS where NumeProdus='Dracena'),1);

insert into DETALII_COMANDA
values (flor_seq.nextval,31,(select id_produs from PRODUS where NumeProdus='Bujor'),2);



--cod cerinta 12

with InformatiiCerute as(
    select rpad(upper(NumeAngajat || ' ' || PrenumeAngajat),25) "Angajat", 
        case
            when length(NumeAngajat || ' ' || PrenumeAngajat)>16 then 'Nume lung'
            else 'Nume scurt'
        end as "Lungimea numelui",
        extract(year from DataAngajare) "An angajare",
        round(months_between(sysdate,DataAngajare)) "Luni de munca la firma",
        Salariu "Salariu",
        case
            when salariu>6000 then last_day(sysdate) 
            else next_day(last_day(sysdate),'Monday')
        end as "Urmatoarea zi de salariu"
    from ANGAJAT,dual
)
select *
from InformatiiCerute;


select rpad(oras,10) "Oras" ,strada "Strada" ,numar "Numar",nvl(bloc,'Nespecificat') "Bloc",
    nvl(to_char(scara),'Nespecificat') "Scara",decode(etaj, NULL, 'Nespecificat', etaj) "Etaj",
    decode(apartament, NULL, 'Nespecificat', apartament) "Apartament",codpostal "Cod postal"
from adresa
order by strada asc;


select c.NumeClient, p.NumeProdus, sum(dc.NumarProduse) "Total Produse"
from client c
join comanda co on c.id_client = co.id_client
join detalii_comanda dc on co.id_comanda = dc.id_comanda
join produs p on dc.id_produs = p.id_produs
where p.id_categprod in (
    select id_categprod
    from categorie_produs
    where NumeCategorie = 'Accesorii'
)
group by c.NumeClient, p.NumeProdus
having sum(dc.NumarProduse) < (
    select avg(NumarProduse)
    from detalii_comanda
);


select p.NumeProdus, c.NumeCategorie, f.NumeFurnizor
from (
    select id_produs, id_categprod, id_furnizor,numeprodus
    from Produs
) p,
(
    select id_categprod, NumeCategorie
    from Categorie_Produs
) c,
(
    select id_furnizor, NumeFurnizor
    from Furnizor
) f
where p.id_categprod = c.id_categprod
and p.id_furnizor = f.id_furnizor
and f.numefurnizor like '%Natures Garden%';


select c.NumeClient || ' ' || c.PrenumeClient as "Client",
       (select count(*)
        from recenzie r
        where r.id_client = c.id_client) as "NumarRecenzii",
        (select count(dc.id_produs)
        from detalii_comanda dc
        inner join comanda co on co.id_comanda = dc.id_comanda
        inner join produs p on p.id_produs = dc.id_produs
        inner join furnizor f on f.id_furnizor = p.id_furnizor
        where co.id_client = c.id_client) as "Numar produse cumparate",
       (select count(dc.id_produs)
        from detalii_comanda dc
        inner join comanda co on co.id_comanda = dc.id_comanda
        inner join produs p on p.id_produs = dc.id_produs
        inner join furnizor f on f.id_furnizor = p.id_furnizor
        where f.NumeFurnizor like '%Natures%'
        and co.id_client = c.id_client) as "Numar produse cumparate de la Natures Garden"
from client c;


--cod cerinta 13

update angajat
set salariu = salariu * 1.1
where id_angajat in (
    select id_angajat
    from angajat
    where id_rol=(select id_rol
                  from rol_angajat
                  where numerol = 'Florar')
);


update produs
set pret = pret * 0.95
where id_produs in (
    select id_produs
    from produs
    where id_categprod=(select id_categprod
                  from categorie_produs
                  where numecategorie = 'Accesorii')
);


delete client c
where not exists ( 
    select *
    from comanda cmd
    where cmd.id_client = c.id_client 
);



--cerinta 14
create view Vizualizare_Complexa as
select c.id_client, c.NumeClient, c.PrenumeClient, 
    (select count(*) from RECENZIE r where r.id_client = c.id_client) as NumarRecenzii,
    (select sum(dc.NumarProduse) from COMANDA co 
        inner join DETALII_COMANDA dc on co.id_comanda = dc.id_comanda
        where co.id_client = c.id_client) as NumarProduseCumparate
from client c;


select *
from Vizualizare_Complexa
where NumarRecenzii >= 2;


insert into Vizualizare_Complexa (id_client, NumeClient, PrenumeClient, NumarRecenzii, NumarProduseCumparate)
values (500, 'Jane', 'Doe', 3, 10);



--cerinta 15
select *
from client cl
left join comanda co on cl.id_client = co.id_client
left join detalii_comanda dc on dc.id_comanda=co.id_comanda
left join produs p on dc.id_produs = p.id_produs
left join categorie_produs cp on cp.id_categprod=p.id_categprod;


select *
from (
    select c.NumeClient, c.PrenumeClient, count(r.id_recenzie) as NumarRecenzii
    from client c
    left join recenzie r on c.id_client = r.id_client
    group by c.NumeClient, c.PrenumeClient
    order by count(r.id_recenzie) desc
) where rownum <= 3;


select a.id_angajat, a.NumeAngajat, a.PrenumeAngajat
from angajat a
where not exists (
    select r.id_rol
    from rol_angajat r
    where not exists (
        select *
        from (
            select c.id_rol
            from angajat a2
            join rol_angajat c on a2.id_rol = c.id_rol
            where a2.id_angajat = a.id_angajat
            union all
            select null
            from dual
        )
        minus
        select c.id_rol
        from rol_angajat c
    )
);



--cerinta 16
select c.numeclient, c.prenumeclient
from comanda co
join client c on co.id_client=c.id_client
join adresa a on a.id_adresa=c.id_adresa
where a.oras='Bucuresti';


select c.numeclient, c.prenumeclient
from comanda co
join client c on co.id_client=c.id_client
join (select * from adresa where oras=’Bucuresti’) a on a.id_adresa=c.id_adresa;



--cerinta 19
select id_angajat, NumeAngajat, PrenumeAngajat
from angajat
where id_rol =1;

create index idx_angajat_id_rol on angajat (id_rol);

select id_produs, NumeProdus
from produs
where id_categprod = 34;

create index idx_produs_id_categprod on produs (id_categprod);

