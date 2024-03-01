--Proiect SGBD
--Dogareci Bianca-Alexandra
--grupa 243


--Cerinta 4
create table ROL_ANGAJAT(
    id_rol number(5) constraint pkey_rol primary key,
    NumeRol varchar(20) constraint NumeRol not null,
    DescriereRol varchar(100) constraint DescriereRol null
    );
    
create table ANGAJAT(
    id_angajat number(5) constraint pkey_angajat primary key,
    id_rol number(5), constraint fk_angajat_rol foreign key(id_rol) references ROL_ANGAJAT(id_rol),
    NumeAngajat varchar(30) constraint NumeAngajat not null,
    PrenumeAngajat varchar(30) constraint PrenumeAngajat not null,
    DataAngajare date constraint DataAngajare not null,
    Salariu number(10) constraint Salariu not null
    );
    
create table ADRESA(
    id_adresa number(5) constraint pkey_adresa primary key,
    Oras varchar(20) constraint Oras not null,
    Strada varchar(30) constraint Strada not null,
    Numar number(5) constraint Numar not null,
    Bloc varchar(20) constraint Bloc null,
    Scara number(5) constraint Scara null,
    Etaj number(5) constraint Etaj null,
    Apartament number(5) constraint Apartament null,
    CodPostal varchar(20) constraint CodPostal not null
    );
    
create table CLIENT(
    id_client number(5) constraint pkey_client primary key,
    id_adresa number(5), constraint fk_client_adresa foreign key(id_adresa) references ADRESA(id_adresa),
    NumeClient varchar(30) constraint NumeClient not null,
    PrenumeClient varchar(30) constraint PrenumeClient not null,
    EmailClient varchar(30) constraint EmailClient not null unique,
    TelefonClient varchar(30) constraint TelefonClient not null unique
    );
    
create table RECENZIE(
    id_recenzie number(5) constraint pkey_recenzie primary key,
    id_client number(5), constraint fk_recenzie_client foreign key(id_client) references CLIENT(id_client),
    Evaluare number(2) constraint Evaluare not null,
    Comentariu varchar(100) constraint Comentariu null
    );
    
CREATE TABLE REDUCERE(
    id_reducere number(5) constraint pkey_reducere primary key,
    CodReducere varchar(255) constraint CodReducere not null unique,
    ProcentReducere decimal(5,2) constraint ProcentReducere not null,
    DataInceput date constraint DataInceput not null,
    DataSfarsit date constraint DataSfarsit not null
);
    
create table COMANDA(
    id_comanda number(5) constraint pkey_comanda primary key,
    id_angajat number(5), constraint fk_comanda_angajat foreign key(id_angajat) references ANGAJAT(id_angajat),
    id_client number(5), constraint fk_comanda_client foreign key(id_client) references CLIENT(id_client),
    id_reducere number(5), constraint fk_comanda_reducere foreign key(id_reducere) references REDUCERE(id_reducere),
    DataComanda date constraint DataComanda not null,
    TipPlata varchar(10) default 'cash' constraint TipPlata not null
    );
    
create table CATEGORIE_PRODUS(
    id_categprod number(5) constraint pkey_categprod primary key,
    NumeCategorie varchar(20) constraint NumeCategorie not null,
    Descriere varchar(100) constraint Descriere null
    );
    
create table FURNIZOR(
    id_furnizor number(5) constraint pkey_furnizor primary key,
    NumeFurnizor varchar(30) constraint NumeFurnizor not null,
    AdresaFurnizor varchar(100) constraint AdresaFurnizor not null unique,
    TelefonFurnizor varchar(10) constraint TelefonFurnizor not null unique
    );
    
create table PRODUS(
    id_produs number(5) constraint pkey_produs primary key,
    id_categprod number(5), constraint fk_produs_categprod foreign key(id_categprod) references CATEGORIE_PRODUS(id_categprod),
    id_furnizor number(5), constraint fk_produs_furnizor foreign key(id_furnizor) references FURNIZOR(id_furnizor),
    NumeProdus varchar(30) constraint NumeProdus not null unique,
    Pret number(5) constraint Pret not null
    );
    
create table DETALII_COMANDA(
    id_detaliicomanda number(5) constraint pkey_detaliicomanda primary key,
    id_comanda number(5), constraint fk_detaliicomanda_comanda foreign key(id_comanda) references COMANDA(id_comanda),
    id_produs number(5), constraint fk_detaliicomanda_produs foreign key(id_produs) references PRODUS(id_produs),
    NumarProduse number(5) constraint NumarProduse not null
    );
    
    
--Cerinta 5
create sequence id_seq
    start with 1
    increment by 1
    nocache
    nocycle;   
    
insert into ROL_ANGAJAT
values(id_seq.nextval,'Florar','Angajatul responsabil cu aranjarea buchetelor și compozițiilor florale.');

insert into ROL_ANGAJAT
values(id_seq.nextval,'Manager','Angajatul cu rol de supervizare și coordonare a operatiunilor zilnice ale florariei.');

insert into ROL_ANGAJAT
values(id_seq.nextval,'Specialist design','Angajatul cu expertiza în creatia de aranjamente florale pentru evenimente.');

insert into ROL_ANGAJAT
values(id_seq.nextval,'Vanzator','Angajatul care interactioneaza direct cu clientii.');

insert into ROL_ANGAJAT
values(id_seq.nextval,'Ingrijitor','Angajatul responsabil cu curatenia.');

insert into ROL_ANGAJAT
values(id_seq.nextval,'Specialist calitate','Angajatul care gestioneaza procesul de depozitare al florilor ca ele sa ramana proaspete.');



insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Florar'),'Ionescu','Anastasia',to_date('16-08-2019','DD-MM-YYYY'),5000);

insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Florar'),'Florescu','Letitia',to_date('04-07-2019','DD-MM-YYYY'),5100);

insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Manager'),'Stanescu','Stefan',to_date('01-12-2005','DD-MM-YYYY'),7000);

insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Specialist design'),'Dumitrache','Rafael',to_date('10-03-2019','DD-MM-YYYY'),6200);

insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Specialist design'),'Teodorescu','Eleonora',to_date('15-04-2015','DD-MM-YYYY'),6400);

insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Ingrijitor'),'Popescu','Ana',to_date('16-08-2015','DD-MM-YYYY'),4000);

insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Vanzator'),'Marin','Roxana',to_date('16-08-2020','DD-MM-YYYY'),5000);



insert into ADRESA
values (id_seq.nextval, 'Bucuresti', 'Str. Victoriei', 10, null, null, null, null, '010101');

insert into ADRESA
values (id_seq.nextval, 'Cluj-Napoca', 'Str. Bucuriei', 15, 'A', 2, 3, 7, '400000');

insert into ADRESA
values (id_seq.nextval, 'Timisoara', 'Str. Mihai Viteazu', 8, 'B3', 1, 6, 60, '300100');

insert into ADRESA
values (id_seq.nextval, 'Iasi', 'Str. Stefan Cel Mare', 25, null, null, null, null, '700300');

insert into ADRESA
values (id_seq.nextval, 'Constanta', 'Bd. Mamaia', 20, null, null, null, null, '900001');

insert into ADRESA
values (id_seq.nextval, 'Bucuresti', 'Sos. Colentina', 11, 'C', 2, 6, 60, '405110');

insert into ADRESA
values (id_seq.nextval, 'Bucuresti', 'Str. Simetriei', 16, null, null, null, null, '794620');

insert into ADRESA
values (id_seq.nextval, 'Bucuresti', 'Str. Velintei', 20, null, null, null, null, '794264');



insert into CLIENT
values (id_seq.nextval,18,'Popescu','Ioana','ioanapopescu@gmail.com','0744322188');

insert into CLIENT
values (id_seq.nextval,19,'Apostol','Teodora','teodoraapostol@yahoo.com','0744325438');

insert into CLIENT
values (id_seq.nextval,20,'Olteanu','Stefan','stefanolteanu@gmail.com','0734522188');

insert into CLIENT
values (id_seq.nextval,21,'Tintea','Alexandru','alextintea@gmail.com','0744678388');

insert into CLIENT
values (id_seq.nextval,22,'Nica','Ana','ananica@ymail.com','0722722722');

insert into CLIENT
values (id_seq.nextval,23,'Feurdean','Mihai','mihaifeur@gmail.com','0747777788');

insert into CLIENT
values (id_seq.nextval,24,'Marinescu','Andrei','andreimarinescu@gmail.com','0747342999');

insert into CLIENT
values (id_seq.nextval,25,'Dogareci','Bianca','biancadogareci@gmail.com','0740017007');

insert into CLIENT
values (id_seq.nextval,18,'Ionescu','Marian','ionescumarian@gmail.com','0776345967');



insert into RECENZIE
values (id_seq.nextval,(select id_client from CLIENT where EmailClient='mihaifeur@gmail.com'),10,'Foarte mulțumit de servicii, personal amabil.');

insert into RECENZIE
values (id_seq.nextval,(select id_client from CLIENT where EmailClient='mihaifeur@gmail.com'),9,null);

insert into RECENZIE
values (id_seq.nextval,(select id_client from CLIENT where EmailClient='ananica@ymail.com'),10,'Produse de calitate!');

insert into RECENZIE
values (id_seq.nextval,(select id_client from CLIENT where EmailClient='ioanapopescu@gmail.com'),5,'Nu am fost impresionata de calitatea produselor.');

insert into RECENZIE
values (id_seq.nextval,(select id_client from CLIENT where EmailClient='alextintea@gmail.com'),10,'Recomand cu încredere, flori proaspete.');

insert into RECENZIE
values (id_seq.nextval,(select id_client from CLIENT where EmailClient='biancadogareci@gmail.com'),10,'Aranjamente foarte frumoase!');



insert into REDUCERE
values (id_seq.nextval, 'aj4id6iwk', 10.5, to_date('01-01-2023','DD-MM-YYYY'), to_date('31-12-2023','DD-MM-YYYY'));

insert into REDUCERE
values (id_seq.nextval, 'cod235786', 5.0, to_date('01-06-2023','DD-MM-YYYY'), to_date('31-08-2023','DD-MM-YYYY'));

insert into REDUCERE
values (id_seq.nextval, 'codcraciun2', 15.0, to_date('01-12-2023','DD-MM-YYYY'), to_date('31-12-2023','DD-MM-YYYY'));

insert into REDUCERE
values (id_seq.nextval, 'BlackFriday!3', 20.0, to_date('01-11-2023','DD-MM-YYYY'), to_date('30-11-2023','DD-MM-YYYY'));

insert into REDUCERE
values (id_seq.nextval, 'red453466', 5.0, to_date('01-03-2023','DD-MM-YYYY'), to_date('31-08-2023','DD-MM-YYYY'));



insert into COMANDA
values (id_seq.nextval,11,(select id_client from CLIENT where EmailClient='mihaifeur@gmail.com'), 41,to_date('15-12-2023','DD-MM-YYYY'),'card');

insert into COMANDA
values (id_seq.nextval,12,(select id_client from CLIENT where EmailClient='ananica@ymail.com'), null,to_date('05-05-2022','DD-MM-YYYY'),'card');

insert into COMANDA
values (id_seq.nextval,14,(select id_client from CLIENT where EmailClient='ananica@ymail.com'), null,to_date('27-11-2022','DD-MM-YYYY'),'cash');

insert into COMANDA
values (id_seq.nextval,15,(select id_client from CLIENT where EmailClient='ioanapopescu@gmail.com'), 44,to_date('18-11-2023','DD-MM-YYYY'),default);

insert into COMANDA
values (id_seq.nextval,11,(select id_client from CLIENT where EmailClient='alextintea@gmail.com'), 45,to_date('04-05-2023','DD-MM-YYYY'),'cash');

insert into COMANDA
values (id_seq.nextval,12,(select id_client from CLIENT where EmailClient='teodoraapostol@yahoo.com'), null,to_date('05-03-2023','DD-MM-YYYY'),'card');

insert into COMANDA
values (id_seq.nextval,12,(select id_client from CLIENT where EmailClient='stefanolteanu@gmail.com'), null,to_date('14-07-2023','DD-MM-YYYY'),'cash');

insert into COMANDA
values (id_seq.nextval,14,(select id_client from CLIENT where EmailClient='andreimarinescu@gmail.com'), 42,to_date('04-07-2023','DD-MM-YYYY'),'cash');

insert into COMANDA
values (id_seq.nextval,11,(select id_client from CLIENT where EmailClient='biancadogareci@gmail.com'), null,to_date('16-02-2023','DD-MM-YYYY'),'card');

insert into COMANDA
values (id_seq.nextval,15,(select id_client from CLIENT where EmailClient='ionescumarian@gmail.com'), null,to_date('08-03-2023','DD-MM-YYYY'),'cash');



insert into CATEGORIE_PRODUS
values (id_seq.nextval,'Buchete','Buchete de flori proaspete și aranjamente florale elegante.');

insert into CATEGORIE_PRODUS
values (id_seq.nextval,'Plante de interior',null);

insert into CATEGORIE_PRODUS
values (id_seq.nextval,'Plante de exterior','Plante de exterior perene si anuale');

insert into CATEGORIE_PRODUS
values (id_seq.nextval,'Accesorii','Ghivece, ambalaje, felicitari, ingrasaminte, decoratiuni etc.');

insert into CATEGORIE_PRODUS
values (id_seq.nextval,'La bucata','Vanzare la fir.');



insert into FURNIZOR
values (id_seq.nextval,'Fresco Verde','Strada Trandafirilor 10, București, 010101, România','0721123456');

insert into FURNIZOR
values (id_seq.nextval,'Happy Flower Holland','Aleea Florilor 5, București, 400000, România','0765987654');

insert into FURNIZOR
values (id_seq.nextval,'GreenLeaf Plants','Bulevardul Liliacului 25, București, 700000, România','0744555888');

insert into FURNIZOR
values (id_seq.nextval,'Natures Garden Supplies','Strada Irisului 8, București, 300001, România','0782111222');

insert into FURNIZOR
values (id_seq.nextval,'Bloom Nursery Co.','Splaiul Crizantemelor 3, București, 500100, România','0733999000');


    
insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Buchete'), (select id_furnizor from FURNIZOR where NumeFurnizor='Fresco Verde'), 'Buchet trandafiri', 100);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Buchete'), (select id_furnizor from FURNIZOR where NumeFurnizor='Fresco Verde'), 'Buchet de vara', 80);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Buchete'), (select id_furnizor from FURNIZOR where NumeFurnizor='Fresco Verde'), 'Buchet de primavara', 120);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de interior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Dracena', 50);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de interior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Happy Flower Holland'), 'Ficus lyrata', 30);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de interior'), (select id_furnizor from FURNIZOR where NumeFurnizor='GreenLeaf Plants'), 'Trandafir japonez', 50);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de exterior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Bloom Nursery Co.'), 'Trandafir englezesc', 60);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de exterior'), (select id_furnizor from FURNIZOR where NumeFurnizor='GreenLeaf Plants'), 'Cupressus sempervirens', 80);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Plante de exterior'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Bujor', 24);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Accesorii'), (select id_furnizor from FURNIZOR where NumeFurnizor='Happy Flower Holland'), 'Ghiveci ceramic', 25);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Accesorii'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Vaza de sticla', 25);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Accesorii'), (select id_furnizor from FURNIZOR where NumeFurnizor='Bloom Nursery Co.'), 'Felicitare', 15);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='La bucata'), (select id_furnizor from FURNIZOR where NumeFurnizor='GreenLeaf Plants'), 'Trandafir roz', 18);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='La bucata'), (select id_furnizor from FURNIZOR where NumeFurnizor='Natures Garden Supplies'), 'Crin alb', 14);

insert into PRODUS
values (id_seq.nextval, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='La bucata'), (select id_furnizor from FURNIZOR where NumeFurnizor='Happy Flower Holland'), 'Frezie galbenă', 10);



insert into DETALII_COMANDA
values (id_seq.nextval,46,(select id_produs from PRODUS where NumeProdus='Cupressus sempervirens'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,46,(select id_produs from PRODUS where NumeProdus='Ghiveci ceramic'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,48,(select id_produs from PRODUS where NumeProdus='Buchet trandafiri'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,47,(select id_produs from PRODUS where NumeProdus='Frezie galbenă'),15);

insert into DETALII_COMANDA
values (id_seq.nextval,47,(select id_produs from PRODUS where NumeProdus='Vaza de sticla'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,47,(select id_produs from PRODUS where NumeProdus='Felicitare'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,50,(select id_produs from PRODUS where NumeProdus='Ghiveci ceramic'),3);

insert into DETALII_COMANDA
values (id_seq.nextval,50,(select id_produs from PRODUS where NumeProdus='Trandafir englezesc'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,51,(select id_produs from PRODUS where NumeProdus='Dracena'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,51,(select id_produs from PRODUS where NumeProdus='Bujor'),2);

insert into DETALII_COMANDA
values (id_seq.nextval,49,(select id_produs from PRODUS where NumeProdus='Trandafir roz'),50);

insert into DETALII_COMANDA
values (id_seq.nextval,49,(select id_produs from PRODUS where NumeProdus='Felicitare'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,52,(select id_produs from PRODUS where NumeProdus='Ficus lyrata'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,53,(select id_produs from PRODUS where NumeProdus='Buchet trandafiri'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,53,(select id_produs from PRODUS where NumeProdus='Vaza de sticla'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,53,(select id_produs from PRODUS where NumeProdus='Felicitare'),1);

insert into DETALII_COMANDA
values (id_seq.nextval,54,(select id_produs from PRODUS where NumeProdus='Bujor'),3);

insert into DETALII_COMANDA
values (id_seq.nextval,55,(select id_produs from PRODUS where NumeProdus='Crin alb'),15);

insert into DETALII_COMANDA
values (id_seq.nextval,55,(select id_produs from PRODUS where NumeProdus='Felicitare'),1);


--Cerinta 6
create or replace procedure AdaugaProdus
    (v_id_produs produs.id_produs%type,
     v_numecategorie categorie_produs.numecategorie%type,
     v_numefurnizor furnizor.numefurnizor%type,
     v_numeprodus produs.numeprodus%type,
     v_pret produs.pret%type)
is
    type tablou_indexat is table of varchar2(255) index by pls_integer;
    type tablou_imbricat is table of varchar2(255);
    type vector is varray(50) of varchar2(255);

    tablou_categprod tablou_indexat;
    tablou_furnizori tablou_imbricat := tablou_imbricat();
    vector_produse vector := vector();

    v_categprod_exista boolean := false;
    v_furnizor_exista boolean := false;
    v_produs_exista boolean := false;
    v_id_produs_exista number;
begin
    select NumeCategorie
    bulk collect into tablou_categprod
    from categorie_produs;
    
    for i in tablou_categprod.first..tablou_categprod.last loop
        if tablou_categprod(i) = v_numecategorie then
            v_categprod_exista := true;
            exit;
        end if;
    end loop;
    
    select NumeFurnizor
    bulk collect into tablou_furnizori
    from furnizor;
    
    for i in tablou_furnizori.first..tablou_furnizori.last loop
        if tablou_furnizori(i) = v_numefurnizor then
            v_furnizor_exista := true;
            exit;
        end if;
    end loop;
    
    select NumeProdus
    bulk collect into vector_produse
    from produs;
    
    for i in vector_produse.first..vector_produse.last loop
        if vector_produse(i) = v_numeprodus then
            v_produs_exista := true;
            exit;
        end if;
    end loop;
    
    select count(*)
    into v_id_produs_exista
    from produs
    where id_produs = v_id_produs;
    
    if v_categprod_exista = false then
        dbms_output.put_line('Categoria de produs nu exista.');
    end if;
    
    if v_furnizor_exista = false then
        dbms_output.put_line('Furnizorul nu exista.');
    end if;
    
    if v_produs_exista = true then
        dbms_output.put_line('Produsul deja exista.');
    end if;
    
    if v_id_produs_exista > 0 then
        dbms_output.put_line('ID-ul produsului nu este unic.');
    end if;
    
    if v_categprod_exista = false or v_furnizor_exista = false or v_produs_exista = true or v_id_produs_exista > 0 then
        return;
    end if;
    
    insert into produs
    values 
    (v_id_produs, 
     (select id_categprod from categorie_produs where numecategorie = v_numecategorie),
     (select id_furnizor from furnizor where numefurnizor = v_numefurnizor),
     v_numeprodus,
     v_pret);
     
     dbms_output.put_line('Produsul a fost adaugat cu succes!');
exception
    when others then
        raise_application_error(-20002,'A aparut o eroare!');
end AdaugaProdus;
/

-- Apelare:
--SQL*PLUS
execute AdaugaProdus(70,'Buchete','Bloom Nursery Co.','Buchet rosu',100);
execute AdaugaProdus(101,'Ingrijire','Bloom Paris','Ingrasamant',40);
execute AdaugaProdus(71,'Ingrijire','Bloom Londra','Bujor',50);
execute AdaugaProdus(100,'Buchete','Bloom Nursery Co.','Buchet flori roz',100);
execute AdaugaProdus(120,'Buchete','Bloom Nursery Co.','Buchet rosu',10000000000000);

--PLSQL
begin
    AdaugaProdus(70,'Buchete','Bloom Nursery Co.','Buchet rosu',100);
end;
/

begin
    AdaugaProdus(101,'Ingrijire','Bloom Paris','Ingrasamant',40);
end;
/

begin
    AdaugaProdus(71,'Ingrijire','Bloom Londra','Bujor',50);
end;
/

begin
    AdaugaProdus(101,'Buchete','Bloom Nursery Co.','Buchet flori galbene',100);
end;
/

begin
    AdaugaProdus(120,'Buchete','Bloom Nursery Co.','Buchet rosu',10000000000000);
end;
/


--Cerinta 7
create or replace procedure AfiseazaProduseDupaCategorie is
    cursor CursorCategorii is
        select id_categprod id_categorie, numecategorie nume_categorie
        from CATEGORIE_PRODUS;
        
    cursor CursorProduse (v_id_categprod categorie_produs.id_categprod%type) is
        select numeprodus nume_produs, id_produs idprodus
        from PRODUS 
        where id_categprod = v_id_categprod;

    var_nume_produs produs.numeprodus%type;
    var_id_produs produs.id_produs%type;
begin
    for i in CursorCategorii loop
        dbms_output.put_line('Categorie: ' || i.nume_categorie);
        open CursorProduse(i.id_categorie);
        loop
            fetch CursorProduse into var_nume_produs, var_id_produs;
            exit when CursorProduse%notfound;
            dbms_output.put_line('   Produs: ' || var_nume_produs || ' (id = ' || var_id_produs || ')');
        end loop;
        dbms_output.put_line('     ');
        close CursorProduse;
    end loop;
end AfiseazaProduseDupaCategorie;
/

-- Apelarea subprogramului
begin
    AfiseazaProduseDupaCategorie;
end;
/

execute AfiseazaProduseDupaCategorie;


--Cerinta 8
create or replace function ComenziAngajat(
    p_nume_angajat angajat.numeangajat%type,
    p_prenume_angajat angajat.prenumeangajat%type
) return number is  
    cursor CursorClienti (id_ang comanda.id_angajat%type) is
        select id_client id_client_
        from comanda
        where id_angajat = id_ang;
    
    var_id_client client.id_client%type;
    v_id_angajat angajat.id_angajat%type;
    nr_comenzi number;
    nume client.numeclient%type;
    prenume client.prenumeclient%type;
    angajat_unic number;
    id_rol_angajat number;
    comenzi_reduse number;
    
    --exceptii
    angajatul_nu_exista exception;
    angajatul_nu_are_comenzi exception;
    angajat_care_nu_e_responsabil_de_comenzi exception;
begin
    select count(*) into angajat_unic
    from angajat
    where NumeAngajat = p_nume_angajat and PrenumeAngajat = p_prenume_angajat;

    if angajat_unic < 1 then
        raise angajatul_nu_exista;
    end if;

    select id_angajat into v_id_angajat
    from angajat
    where NumeAngajat = p_nume_angajat and PrenumeAngajat = p_prenume_angajat;

    select id_rol into id_rol_angajat
    from angajat
    where id_angajat = v_id_angajat;
    
    if id_rol_angajat not in (1,3) then
        raise angajat_care_nu_e_responsabil_de_comenzi;
    end if;
        
    select count(*) into nr_comenzi
    from comanda
    where id_angajat = v_id_angajat;
    
    if nr_comenzi = 0 then
        raise angajatul_nu_are_comenzi;
    end if;
    
    dbms_output.put_line('Numele clientilor care au plasat comenzile:');
    open CursorClienti(v_id_angajat);
        loop
            fetch CursorClienti into var_id_client;
            exit when CursorClienti%notfound;
            select numeclient, prenumeclient into nume, prenume
            from client
            where id_client = var_id_client;
            dbms_output.put_line('   ' || nume || ' ' || prenume);
        end loop;
    close CursorClienti;
    
    select count (*) into comenzi_reduse
    from comanda c 
    left join reducere r on c.id_reducere = r.id_reducere
    left join angajat a on a.id_angajat = c.id_angajat
    where a.numeangajat = p_nume_angajat and a.prenumeangajat = p_prenume_angajat and r.codreducere is not null;
    
    dbms_output.put_line('Numar comenzi reduse:');
    dbms_output.put_line(comenzi_reduse);
    
    dbms_output.put_line('Numar comenzi:');
    return nr_comenzi;
exception
    when angajatul_nu_exista then
        dbms_output.put_line('Acest angajat nu exista');
        return -1;
    when angajatul_nu_are_comenzi then
        dbms_output.put_line('Angajatului nu ii corespunde nicio comanda');
        return -1;
    when angajat_care_nu_e_responsabil_de_comenzi then
        dbms_output.put_line('Angajatul nu poate sa se ocupe de comenzi deoarece are un rol care nu ii permite sa faca acest lucru');
        return -1;
    when others then
        dbms_output.put_line('Alta eroare: ' || SQLERRM);
        return -1;
end;
/

--Apelare:
--PLSQL
begin
    dbms_output.put_line(ComenziAngajat('Ionescu','Anastasia'));
end;
/

begin
    dbms_output.put_line(ComenziAngajat('Popescu','Anastasia'));
end;
/

begin
    dbms_output.put_line(ComenziAngajat('Popescu','Ana'));
end;
/

--Pentru a putea vedea si cum functioneaza exceptia ''
--inseram un nou angajat care se poate ocupa de comenzi 
--dar care nu are deocamdata nicio comanda atribuita

insert into ANGAJAT
values(id_seq.nextval,(select id_rol from ROL_ANGAJAT where NumeRol='Florar'),'Munteanu','Iulia',to_date('16-08-2023','DD-MM-YYYY'),5000);

begin
    dbms_output.put_line(ComenziAngajat('Munteanu','Iulia'));
end;
/

--SQL
select ComenziAngajat('Ionescu','Anastasia')
from dual;

select ComenziAngajat('Popescu','Anastasia')
from dual;

select ComenziAngajat('Popescu','Ana')
from dual;


--Cerinta 9
create or replace procedure DateComenzi
    (nume client.numeclient%type) 
is
    type tabel_info_rec is record(
        numar_produse number,
        nume_produs varchar2(255),
        pret number,
        nume_furnizor varchar2(255)
    );
    
    type tabel_info is table of tabel_info_rec index by pls_integer;
    type tabel_verificare is table of client%rowtype index by pls_integer;
    
    tabel_date tabel_info;
    tabel_client tabel_verificare;
    
    no_data_found1 exception;
    no_data_found2 exception;
    too_many_rows exception;
begin
    select *
    bulk collect into tabel_client
    from client
    where numeclient = nume;
    
    if sql%notfound then
        raise no_data_found1;
    end if;
    
    if tabel_client.count >=2 then
        raise too_many_rows;
    end if;

    select dc.numarproduse, p.numeprodus, p.pret, f.numefurnizor
    bulk collect into tabel_date
    from client cl
    join comanda co on cl.id_client = co.id_client
    join detalii_comanda dc on co.id_comanda = dc.id_comanda
    join produs p on dc.id_produs = p.id_produs
    join furnizor f on p.id_furnizor = f.id_furnizor
    where cl.numeclient = nume;
    
    if sql%notfound then
        raise no_data_found2;
    end if;
    
    for i in tabel_date.first..tabel_date.last loop
        dbms_output.put_line('Pret pentru numarul de articole comandate: ' || tabel_date(i).numar_produse * tabel_date(i).pret);
        dbms_output.put_line('Nume produs: ' || tabel_date(i).nume_produs);
        dbms_output.put_line('Nume furnizor: ' || tabel_date(i).nume_furnizor);
        dbms_output.new_line;
end loop;
    
exception
    when no_data_found1 then
        dbms_output.put_line('Nu exista clientul cu acel nume.');
    when no_data_found2 then
        dbms_output.put_line('Clientul a ramas in baza de date chiar daca nu are atribuita vreo comanda.');
    when too_many_rows then
        dbms_output.put_line('Exista mai multi clienti cu acest nume.');
    when others then
        dbms_output.put_line('Codul de eroare: ' || SQLCODE);
        dbms_output.put_line('Mesajul erorii: ' || SQLERRM);
end DateComenzi;
/

--Apelare:
--SQL*PLUS
execute DateComenzi('Nica');
execute DateComenzi('Lisman');

--pentru a putea vedea un exemplu cu exceptia too_many_rows am modificat numele unui client astfel incat sa avem doi clienti cu numele 'Apostol'
UPDATE client
SET numeclient = 'Apostol'
WHERE numeclient = 'Popescu';

execute DateComenzi('Apostol');

--pentru a putea vedea un exemplu cu exceptia no_data_found2 inseram un nou client care nu are asociata vreo comanda
insert into CLIENT
values (35,20,'Dogaru','Mihai','mihaidogaru@gmail.com','0758564358');

execute DateComenzi('Dogaru');

--PLSQL
begin
    DateComenzi('Nica');
end;
/

begin
    DateComenzi('Lisman');
end;
/

begin
    DateComenzi('Apostol');
end;
/

begin
    DateComenzi('Dogaru');
end;
/


--Cerinta 10
create or replace trigger program_lucru
    before insert or update or delete on produs
begin
    if (to_char(sysdate, 'D') in (7,1)) or (to_char(sysdate,'HH24') not between 12 and 24) or (to_char(sysdate, 'DD-MM') = '25-12') then
        if inserting then
            raise_application_error(-20001, 'Inserarea e permisa doar de luni pana vineri intre orele 12 si 24 (de Craciun nu se pot face inserari!)');
        elsif deleting then
            raise_application_error(-20001, 'Stergerea e permisa doar de luni pana vineri intre orele 12 si 24 (de Craciun nu se pot sterge date!)');
        else
            raise_application_error(-20001, 'Update-urile sunt permise doar de luni pana vineri intre orele 12 si 24 (de Craciun nu se pot face update-uri!)');
        end if;
    end if;
end;
/

insert into PRODUS
values (102, (select id_categprod from CATEGORIE_PRODUS where NumeCategorie='Buchete'), (select id_furnizor from FURNIZOR where NumeFurnizor='Fresco Verde'), 'Buchet flori albe', 100);

update PRODUS
set Pret = 2
where id_produs = 101;

delete from PRODUS
where id_produs = 101;


--Cerinta 11
--VARIANTA 1
create or replace trigger note_fixe
    before update of evaluare on recenzie
    for each row
begin
    if(:new.evaluare < :old.evaluare) then
        raise_application_error(-20002, 'Evaluarea nu poate fi micsorata');
    end if;
    if(:new.evaluare > :old.evaluare) then
        raise_application_error(-20002, 'Evaluarea nu poate fi marita');
    end if;
end;
/

update RECENZIE
set Evaluare = Evaluare + 1
where id_recenzie = 38;

update RECENZIE
set Evaluare = Evaluare - 1
where id_recenzie = 38;

drop trigger note_fixe;

--VARIANTA 2
create or replace trigger note_fixe
    before update of evaluare on recenzie
    for each row
    when (new.evaluare < old.evaluare or new.evaluare > old.evaluare)
begin
    raise_application_error(-20002, 'Evaluarea nu poate fi modificata!');
end;
/

update RECENZIE
set Evaluare = Evaluare + 1
where id_recenzie = 38;

drop trigger note_fixe;

--VARIANTA 3
create or replace procedure procedura
is
begin
    raise_application_error(-20000, 'Evaluarea nu poate fi modificata!');
end;
/

create or replace trigger note_fixe
    before update of evaluare on recenzie
    for each row
    when (new.evaluare <> old.evaluare)
begin
    procedura;
end;
/

update RECENZIE
set Evaluare = Evaluare - 1
where id_recenzie = 38;

drop trigger note_fixe;

--VARIANTA 4
create or replace trigger note_fixe
    before update of evaluare on recenzie
    for each row
    when (new.evaluare <> old.evaluare)
    call procedura
/

update RECENZIE
set Evaluare = Evaluare + 3
where id_recenzie = 38;

drop trigger note_fixe;


--Cerinta 12
create table modificari_efectuate(
    utilizator varchar2(100),
    baza_de_date varchar2(100),
    actiune varchar2(100),
    nume_obiect varchar2(100),
    tip_obiect varchar2(100),
    data_modificare date
    );
    
create or replace trigger Modificare
    after create or alter or drop on schema
begin
    insert into modificari_efectuate
    values(sys.login_user, sys.database_name, sys.sysevent, sys.dictionary_obj_name, sys.dictionary_obj_type, sysdate);
end;
/

create table test_trigger(
    id number,
    nume varchar2(50),
    nota number
    );
    
alter table test_trigger
drop column nota;

alter table test_trigger
add (prenume varchar(50));

drop table test_trigger;

select *
from modificari_efectuate;

drop trigger Modificare;


--Cerinta 13
create or replace package pachet as
    procedure AdaugaProdus
        (v_id_produs produs.id_produs%type,
         v_numecategorie categorie_produs.numecategorie%type,
         v_numefurnizor furnizor.numefurnizor%type,
         v_numeprodus produs.numeprodus%type,
         v_pret produs.pret%type);
     
    procedure AfiseazaProduseDupaCategorie;
     
    function ComenziAngajat
        (p_nume_angajat angajat.numeangajat%type,
         p_prenume_angajat angajat.prenumeangajat%type)
    return number;
    
    procedure DateComenzi
        (nume client.numeclient%type);
end pachet;
/

create or replace package body pachet as
    procedure AdaugaProdus
        (v_id_produs produs.id_produs%type,
         v_numecategorie categorie_produs.numecategorie%type,
         v_numefurnizor furnizor.numefurnizor%type,
         v_numeprodus produs.numeprodus%type,
         v_pret produs.pret%type)
    is
        type tablou_indexat is table of varchar2(255) index by pls_integer;
        type tablou_imbricat is table of varchar2(255);
        type vector is varray(50) of varchar2(255);
    
        tablou_categprod tablou_indexat;
        tablou_furnizori tablou_imbricat := tablou_imbricat();
        vector_produse vector := vector();
    
        v_categprod_exista boolean := false;
        v_furnizor_exista boolean := false;
        v_produs_exista boolean := false;
        v_id_produs_exista number;
    begin
        select NumeCategorie
        bulk collect into tablou_categprod
        from categorie_produs;
        
        for i in tablou_categprod.first..tablou_categprod.last loop
            if tablou_categprod(i) = v_numecategorie then
                v_categprod_exista := true;
                exit;
            end if;
        end loop;
        
        select NumeFurnizor
        bulk collect into tablou_furnizori
        from furnizor;
        
        for i in tablou_furnizori.first..tablou_furnizori.last loop
            if tablou_furnizori(i) = v_numefurnizor then
                v_furnizor_exista := true;
                exit;
            end if;
        end loop;
        
        select NumeProdus
        bulk collect into vector_produse
        from produs;
        
        for i in vector_produse.first..vector_produse.last loop
            if vector_produse(i) = v_numeprodus then
                v_produs_exista := true;
                exit;
            end if;
        end loop;
        
        select count(*)
        into v_id_produs_exista
        from produs
        where id_produs = v_id_produs;
        
        if v_categprod_exista = false then
            dbms_output.put_line('Categoria de produs nu exista.');
        end if;
        
        if v_furnizor_exista = false then
            dbms_output.put_line('Furnizorul nu exista.');
        end if;
        
        if v_produs_exista = true then
            dbms_output.put_line('Produsul deja exista.');
        end if;
        
        if v_id_produs_exista > 0 then
            dbms_output.put_line('ID-ul produsului nu este unic.');
        end if;
        
        if v_categprod_exista = false or v_furnizor_exista = false or v_produs_exista = true or v_id_produs_exista > 0 then
            return;
        end if;
        
        insert into produs
        values 
        (v_id_produs, 
         (select id_categprod from categorie_produs where numecategorie = v_numecategorie),
         (select id_furnizor from furnizor where numefurnizor = v_numefurnizor),
         v_numeprodus,
         v_pret);
         
         dbms_output.put_line('Produsul a fost adaugat cu succes!');
    exception
        when others then
            raise_application_error(-20002,'A aparut o eroare!');
    end AdaugaProdus;
    
    procedure AfiseazaProduseDupaCategorie is
        cursor CursorCategorii is
            select id_categprod id_categorie, numecategorie nume_categorie
            from CATEGORIE_PRODUS;
            
        cursor CursorProduse (v_id_categprod categorie_produs.id_categprod%type) is
            select numeprodus nume_produs, id_produs idprodus
            from PRODUS 
            where id_categprod = v_id_categprod;
    
        var_nume_produs produs.numeprodus%type;
        var_id_produs produs.id_produs%type;
    begin
        for i in CursorCategorii loop
            dbms_output.put_line('Categorie: ' || i.nume_categorie);
            open CursorProduse(i.id_categorie);
            loop
                fetch CursorProduse into var_nume_produs, var_id_produs;
                exit when CursorProduse%notfound;
                dbms_output.put_line('   Produs: ' || var_nume_produs || ' (id = ' || var_id_produs || ')');
            end loop;
            dbms_output.put_line('     ');
            close CursorProduse;
        end loop;
    end AfiseazaProduseDupaCategorie;

    function ComenziAngajat(
        p_nume_angajat angajat.numeangajat%type,
        p_prenume_angajat angajat.prenumeangajat%type
    ) return number is  
        cursor CursorClienti (id_ang comanda.id_angajat%type) is
            select id_client id_client_
            from comanda
            where id_angajat = id_ang;
        
        var_id_client client.id_client%type;
        v_id_angajat angajat.id_angajat%type;
        nr_comenzi number;
        nume client.numeclient%type;
        prenume client.prenumeclient%type;
        angajat_unic number;
        id_rol_angajat number;
        comenzi_reduse number;
        
        --exceptii
        angajatul_nu_exista exception;
        angajatul_nu_are_comenzi exception;
        angajat_care_nu_e_responsabil_de_comenzi exception;
    begin
        select count(*) into angajat_unic
        from angajat
        where NumeAngajat = p_nume_angajat and PrenumeAngajat = p_prenume_angajat;
    
        if angajat_unic < 1 then
            raise angajatul_nu_exista;
        end if;
    
        select id_angajat into v_id_angajat
        from angajat
        where NumeAngajat = p_nume_angajat and PrenumeAngajat = p_prenume_angajat;
    
        select id_rol into id_rol_angajat
        from angajat
        where id_angajat = v_id_angajat;
        
        if id_rol_angajat not in (1,3) then
            raise angajat_care_nu_e_responsabil_de_comenzi;
        end if;
            
        select count(*) into nr_comenzi
        from comanda
        where id_angajat = v_id_angajat;
        
        if nr_comenzi = 0 then
            raise angajatul_nu_are_comenzi;
        end if;
        
        dbms_output.put_line('Numele clientilor care au plasat comenzile:');
        open CursorClienti(v_id_angajat);
            loop
                fetch CursorClienti into var_id_client;
                exit when CursorClienti%notfound;
                select numeclient, prenumeclient into nume, prenume
                from client
                where id_client = var_id_client;
                dbms_output.put_line('   ' || nume || ' ' || prenume);
            end loop;
        close CursorClienti;
        
        select count (*) into comenzi_reduse
        from comanda c 
        left join reducere r on c.id_reducere = r.id_reducere
        left join angajat a on a.id_angajat = c.id_angajat
        where a.numeangajat = p_nume_angajat and a.prenumeangajat = p_prenume_angajat and r.codreducere is not null;
        
        dbms_output.put_line('Numar comenzi reduse:');
        dbms_output.put_line(comenzi_reduse);
        
        dbms_output.put_line('Numar comenzi:');
        return nr_comenzi;
    exception
        when angajatul_nu_exista then
            dbms_output.put_line('Acest angajat nu exista');
            return -1;
        when angajatul_nu_are_comenzi then
            dbms_output.put_line('Angajatului nu ii corespunde nicio comanda');
            return -1;
        when angajat_care_nu_e_responsabil_de_comenzi then
            dbms_output.put_line('Angajatul nu poate sa se ocupe de comenzi deoarece are un rol care nu ii permite sa faca acest lucru');
            return -1;
        when others then
            dbms_output.put_line('Alta eroare: ' || SQLERRM);
            return -1;
    end;
    
    procedure DateComenzi
        (nume client.numeclient%type) 
    is
        type tabel_info_rec is record(
            numar_produse number,
            nume_produs varchar2(255),
            pret number,
            nume_furnizor varchar2(255)
        );
        
        type tabel_info is table of tabel_info_rec index by pls_integer;
        type tabel_verificare is table of client%rowtype index by pls_integer;
        
        tabel_date tabel_info;
        tabel_client tabel_verificare;
        
        no_data_found1 exception;
        no_data_found2 exception;
        too_many_rows exception;
    begin
        select *
        bulk collect into tabel_client
        from client
        where numeclient = nume;
        
        if sql%notfound then
            raise no_data_found1;
        end if;
        
        if tabel_client.count >=2 then
            raise too_many_rows;
        end if;
    
        select dc.numarproduse, p.numeprodus, p.pret, f.numefurnizor
        bulk collect into tabel_date
        from client cl
        join comanda co on cl.id_client = co.id_client
        join detalii_comanda dc on co.id_comanda = dc.id_comanda
        join produs p on dc.id_produs = p.id_produs
        join furnizor f on p.id_furnizor = f.id_furnizor
        where cl.numeclient = nume;
        
        if sql%notfound then
            raise no_data_found2;
        end if;
        
        for i in tabel_date.first..tabel_date.last loop
            dbms_output.put_line('Pret pentru numarul de articole comandate: ' || tabel_date(i).numar_produse * tabel_date(i).pret);
            dbms_output.put_line('Nume produs: ' || tabel_date(i).nume_produs);
            dbms_output.put_line('Nume furnizor: ' || tabel_date(i).nume_furnizor);
            dbms_output.new_line;
    end loop;
        
    exception
        when no_data_found1 then
            dbms_output.put_line('Nu exista clientul cu acel nume.');
        when no_data_found2 then
            dbms_output.put_line('Clientul a ramas in baza de date chiar daca nu are atribuita vreo comanda.');
        when too_many_rows then
            dbms_output.put_line('Exista mai multi clienti cu acest nume.');
        when others then
            dbms_output.put_line('Codul de eroare: ' || SQLCODE);
            dbms_output.put_line('Mesajul erorii: ' || SQLERRM);
    end DateComenzi;
end pachet;
/

--apelare
declare
    v_rezultat_functie number;
begin
    dbms_output.put_line('Cerinta 6');
    pachet.AdaugaProdus(71,'Ingrijire','Bloom Londra','Bujor',50);
    dbms_output.put_line(null);
    
    dbms_output.put_line('Cerinta 7');
    pachet.AfiseazaProduseDupaCategorie;
    dbms_output.put_line(null);
    
    dbms_output.put_line('Cerinta 8');
    v_rezultat_functie := pachet.ComenziAngajat('Ionescu','Anastasia');
    dbms_output.put_line(v_rezultat_functie);
    dbms_output.put_line(null);
    
    dbms_output.put_line('Cerinta 9');
    pachet.DateComenzi('Nica');
    dbms_output.put_line(null);
end;
/


