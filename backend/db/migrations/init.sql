-- Initial schema for user registration
DROP TABLE IF EXISTS user_favorites;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS user_activity_log;

-- Crear tabla roles primero
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    rol VARCHAR(50)
);

-- Insertar roles por defecto
INSERT INTO roles (id, rol) VALUES (1, 'Admin') ON CONFLICT (id) DO NOTHING;
INSERT INTO roles (id, rol) VALUES (2, 'Usuario') ON CONFLICT (id) DO NOTHING;
INSERT INTO roles (id, rol) VALUES (3, 'Invitado') ON CONFLICT (id) DO NOTHING;

-- Ahora sí, crear users con la FK a roles
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  lastname VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(10) NOT NULL,
  role_id INT REFERENCES roles(id) DEFAULT 2,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS movies (
  id SERIAL PRIMARY KEY,
  movie_poster text,
  title text,
  year integer,
  summary text,
  genres text,
  runtime text,
  director text,
  "cast" text,
  rating text,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Inserción manual de datos de películas
INSERT INTO movies(id,movie_poster,title,year,summary,genres,runtime,director,"cast",rating) VALUES
 ('1','https://m.media-amazon.com/images/M/MV5BZGQ5NGEyYTItMjNiMi00Y2EwLTkzOWItMjc5YjJiMjMyNTI0XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Misión: Imposible - Sentencia final','2025','Ethan y su equipo tienen la misión de encontrar y destruir a una IA conocida como La Entidad. El viaje por todo el mundo da lugar a increíbles escenas de acción y a más de un giro inesperado.','Acción, Aventura, Suspense','2h 49m','Christopher McQuarrie','Tom Cruise, Hayley Atwell, Ving Rhames','7,5')
,('2','https://m.media-amazon.com/images/M/MV5BOWUyM2Y5YWMtZTUzZC00ODBiLTg1N2QtNGMzOTNkOTVjMDY4XkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Lilo y Stitch','2025','Una solitaria niña hawaiana se hace amiga de un extraterrestre fugitivo y ayuda a sanar a su fragmentada familia.','Acción, Aventura, Comedia','1h 48m','Dean Fleischer Camp','Maia Kealoha, Sydney Agudong, Chris Sanders','7,0')
,('3','https://m.media-amazon.com/images/M/MV5BNTUwNzJhOWMtN2E2NC00NWQxLWI1NTctZTY0MzZiZGNiOGFjXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Destino final: Lazos de sangre','2025','Atormentada por una pesadilla violenta recurrente, una estudiante universitaria regresa a casa para encontrar a la única persona que puede romper el ciclo y salvar a su familia del horrible destino que inevitablemente les espera.','Terror','1h 50m','Zach Lipovsky, Adam B. Stein','Kaitlyn Santa Juana, Teo Briones, Rya Kihlstedt','7,0')
,('4','https://m.media-amazon.com/images/M/MV5BNWRlZmU3ZTItM2JlYi00YTg1LTgxNTItMjMyNzIyZWY5YWJmXkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','La fuente de la eterna juventud','2025','Dos hermanos unen sus fuerzas para buscar la legendaria fuente de la juventud. Utilizando pistas históricas, se embarcan en una búsqueda épica llena de aventuras. Si tienen éxito, la mítica fuente podría concederles la inmortalidad.','Acción, Aventura, Fantasía','2h 5m','Guy Ritchie','John Krasinski, Natalie Portman, Eiza González','5,7')
,('5','https://m.media-amazon.com/images/M/MV5BMWY3MzM1Y2YtZWIzOS00ZWJiLWI1YzYtZDY5MzFkY2I4ZjY5XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Los pecadores','2025','Tratando de descubrir sus problemáticas vidas detrás, los hermanos gemelos regresan a su ciudad natal para comenzar de nuevo, solo para descubrir que un mal aún mayor los espera para darles la bienvenida nuevamente.','Acción, Drama, Terror','2h 17m','Ryan Coogler','Michael B. Jordan, Miles Caton, Saul Williams','8,0')
,('6','https://m.media-amazon.com/images/M/MV5BNjJlMDJjZTctNDlkYi00YTNmLWIyZjUtZjdmZTFhNDQwMTQ4XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','La calle del terror: La reina del baile','2025','En la ciudad de Shadyside, Ohio, se acerca el baile de graduación. Las chicas populares compiten por la corona. Pronto, las chicas comienzan a desaparecer misteriosamente.','Terror, Misterio, Suspense','1h 30m','Matt Palmer','India Fowler, Suzanna Son, Fina Strazza','5,2')
,('7','https://m.media-amazon.com/images/M/MV5BMDM3ZTVkMGUtYjcyNi00NGY1LTlkY2ItZWJhODk1MjZiZGU0XkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Thunderbolts*','2025','Un mundo sin Vengadores no significa que no haya un grupo de superhéroes. Hay un grupo y se llaman Thunderbolts.','Acción, Aventura, Crimen','2h 7m','Jake Schreier','Florence Pugh, Sebastian Stan, Julia Louis-Dreyfus','7,6')
,('8','https://m.media-amazon.com/images/M/MV5BODM0M2M4YWQtMzhlNy00NjdkLWFkODktOGNlNTc4OTFiZjZmXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Nonnas','2025','Joe Scaravella, se da cuenta de que ha perdido el tiempo como soltero en un trabajo sin futuro y anhela una segunda oportunidad, abre un restaurante y contrata a un grupo de abuelas como chefs.','Comedia','1h 51m','Stephen Chbosky','Vince Vaughn, Lorraine Bracco, Talia Shire','6,9')
,('9','https://m.media-amazon.com/images/M/MV5BZTg0YzRkNDMtZTJjZS00Mjk0LTgwNGQtZWIzMTM3ZDRmZTQwXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Misión: Imposible - Sentencia mortal. Parte Uno','2023','Séptima entrega de la saga ''Misión Imposible''.','Acción, Aventura, Suspense','2h 43m','Christopher McQuarrie','Tom Cruise, Hayley Atwell, Ving Rhames','7,6')
,('10','https://m.media-amazon.com/images/M/MV5BY2I5MmUxZGMtNTI0MC00OWU0LThjZjMtMDRjYTNmZDdkYmJhXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Mickey 17','2025','Mickey participa en una expedición humana para colonizar el planeta helado Niflheim. Es un "prescindible", un empleado descartable. Cada vez que muere, sus recuerdos se implantan en un nuevo cuerpo y su misión se reanuda.','Aventura, Comedia, Fantasía','2h 17m','Bong Joon Ho','Robert Pattinson, Steven Yeun, Michael Monroe','6,8')
,('11','https://m.media-amazon.com/images/M/MV5BNzg5MTNkOTQtZDU2ZC00MjM3LTk1MDAtMTYyZDFmN2Y2MTY5XkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Until Dawn','2025','Un grupo pasa el fin de semana en un refugio de esquí en el aniversario de la desaparición de sus amigos, sin saber que no están solos.','Drama, Terror','1h 43m','David F. Sandberg','Ella Rubin, Michael Cimino, Odessa A''zion','5,8')
,('12','https://m.media-amazon.com/images/M/MV5BMGJjMDZiNzYtOWNjNS00MmYwLTg4NjAtYTJmYjZmODBlMzYzXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Una película de Minecraft','2025','El malvado dragón de Ender está en su camino a la destrucción, haciendo que una chica joven y su grupo de aventureros amigos intenten salvar Overworld.','Acción, Aventura, Comedia','1h 41m','Jared Hess','Jason Momoa, Jack Black, Sebastian Hansen','5,7')
,('13','https://m.media-amazon.com/images/M/MV5BMWFiZjUwZmEtMGVjYi00MjI0LTk5MzAtMjM0MjRkODcyNjI5XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Superman','2025','Sigue al superhéroe titular mientras reconcilia su herencia con su educación humana. Es la encarnación de la verdad, la justicia y un mañana mejor en un mundo que ve la bondad como algo anticuado.','Acción, Aventura, Fantasía','2h 2m','James Gunn','David Corenswet, Rachel Brosnahan, Nicholas Hoult',NULL)
,('14','https://m.media-amazon.com/images/M/MV5BYmQxZGIxNTYtYTQwMy00ODdkLWI0MmQtM2E0ZmIyNmYzMGMzXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','A Working Man','2025','Levon Cade dejó su profesión para trabajar en la construcción. Pero cuando una chica de la localidad desaparece, se le pide que retome las habilidades que le convirtieron en una figura mítica en la lucha antiterrorista.','Acción, Suspense','1h 56m','David Ayer','Jason Statham, Jason Flemyng, Merab Ninidze','5,7')
,('15','https://m.media-amazon.com/images/M/MV5BODhhMjU4ZGItZjEzZC00MzM1LWEyMTEtMDhmOTNiN2Y3MDg5XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Blancanieves','2025','Una princesa une fuerzas con siete enanitos y un grupo de rebeldes para liberar su reino de su cruel madrastra, la Reina Malvada.','Aventura, Familiar, Fantasía','1h 49m','Marc Webb','Rachel Zegler, Emilia Faucher, Gal Gadot','1,7')
,('16','https://m.media-amazon.com/images/M/MV5BZWMwNTc4NjItNzJhZC00OWY5LWE2NGYtMzkwNTZmOTI4YWMzXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Destino final','2000','Alex Browning forma parte de un grupo de estudiantes de secundaria que se prepara para un viaje a Europa. Cuando tiene una premonición de que su avión se va a estrellar, grita para avisar a los demás, pero es expulsado del avión.','Terror, Suspense','1h 38m','James Wong','Devon Sawa, Ali Larter, Kerr Smith','6,7')
,('17','https://m.media-amazon.com/images/M/MV5BYzk2MjdkZDMtNmU0ZC00ZTEyLTk0ZTAtZDM1MmFhNDdhMjFiXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','La hermanastra fea','2025','En una retorcida versión del clásico cuento de Cenicienta, "La hermanastra fea" sigue a Elvira en su lucha por competir con su increíblemente bella hermanastra. En un reino de cuento de hadas donde la belleza es un negocio brutal.','Comedia, Drama, Terror','1h 49m','Emilie Blichfeldt','Lea Myren, Ane Dahl Torp, Thea Sofie Loch Næss','7,0')
,('18','https://m.media-amazon.com/images/M/MV5BNTJmODQzYmItNTZlMy00Mjg0LTk1NjctYjM4ZGI0NTM3ZTVjXkEyXkFqcGc@._V1_QL75_UX140_CR0,6,140,207_.jpg','El esquema fenicio','2025','Una oscura historia de espionaje que sigue a una tensa relación padre-hija en un negocio familiar. Los giros giran en torno a la traición y las elecciones moralmente grises.','Acción, Comedia, Crimen','1h 41m','Wes Anderson','Benicio Del Toro, Mia Threapleton, Michael Cera','6,8')
,('19','https://m.media-amazon.com/images/M/MV5BYzRiYTA1YTEtMjYwMi00NGVhLThkOGYtZDBlYjNjZDk2NDEwXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Lilo & Stitch','2002','Una niña hawaiana adopta a supuesto un perro, sin saber que es un peligroso experimento científico que se ha refugiado en la Tierra y que ahora se esconde de su creador y de quienes lo ven como una amenaza.','Animación, Aventura, Comedia','1h 25m','Dean DeBlois, Chris Sanders','Daveigh Chase, Chris Sanders, Tia Carrere','7,3')
,('20','https://m.media-amazon.com/images/M/MV5BMzZhODk0NDktMjJjOC00NThjLWE5MDctNmUzYjA3MjIwNDA0XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Warfare: Tiempo de guerra','2025','Basado en las experiencias reales del ex Navy Seal Ray Mendoza durante la guerra de Irak.','Acción, Drama, Bélico','1h 35m','Alex Garland, Ray Mendoza','D''Pharaoh Woon-A-Tai, Will Poulter, Cosmo Jarvis','7,4')
,('21','https://m.media-amazon.com/images/M/MV5BMzljN2M1MWMtYmUwMi00YWM5LTllMGItNzZlMmU1NWM2NTY5XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Friendship','2024','Cuando el nuevo vecino Brian amenaza su tranquila vida, Craig Waterman lucha por proteger la seguridad de su familia.','Comedia','1h 40m','Andrew DeYoung','Tim Robinson, Paul Rudd, Kate Mara','7,5')
,('22','https://m.media-amazon.com/images/M/MV5BMjgyMDE3ZGEtYmJjNS00MzI1LTk5ZmUtZTc4OGQzZWJlODk4XkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Mission: Impossible','1996','Un agente americano, bajo falsas sospechas de deslealtad, debe descubrir y desenmascarar al verdadero espía sin la ayuda de su organización.','Acción, Aventura, Suspense','1h 50m','Brian De Palma','Tom Cruise, Jon Voight, Emmanuelle Béart','7,2')
,('23','https://m.media-amazon.com/images/M/MV5BMjEwMzMxODIzOV5BMl5BanBnXkFtZTgwNzg3OTAzMDI@._V1_QL75_UX140_CR0,0,140,207_.jpg','Rogue One: Una historia de Star Wars','2016','La hija de un científico imperial se une a la Alianza Rebelde en una arriesgada jugada para robar los planos de la Estrella de la Muerte.','Acción, Aventura, Ciencia ficción','2h 13m','Gareth Edwards','Felicity Jones, Diego Luna, Alan Tudyk','7,8')
,('24','https://m.media-amazon.com/images/M/MV5BZWJjMjdhNGEtZjEyMi00OTg2LTllMzQtN2JlZWNjYzI4YzFhXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Estragos','2025','Tras un negocio de drogas que sale mal, un detective magullado debe abrirse camino a través del submundo criminal para rescatar al hijo distanciado de un político, desentrañando una profunda red de corrupción que atrapa a toda su ciudad.','Acción, Crimen, Drama','1h 47m','Gareth Evans','Tom Hardy, Jessie Mei Li, Justin Cornwell','5,7')
,('25','https://m.media-amazon.com/images/M/MV5BM2Q5MTBkNTgtOTg3My00MmMxLWE5ZWYtZjk4ZWJhYTkyZWUxXkEyXkFqcGc@._V1_QL75_UX140_CR0,7,140,207_.jpg','Jurassic World: El renacer','2025','Cinco años después de Jurassic World: Dominion, una expedición se aventura en remotas regiones ecuatoriales para extraer ADN de tres enormes criaturas prehistóricas, con el objetivo de lograr un avance médico revolucionario.','Acción, Aventura, Ciencia ficción','2h 14m','Gareth Edwards','Scarlett Johansson, Rupert Friend, Jonathan Bailey',NULL)
,('26','https://m.media-amazon.com/images/M/MV5BYThlZjg0MmItMjViYy00NjQ1LWJlOWQtMzIxMzI4NjhiMDA1XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','El contable 2','2025','Christian Wolff aplica su mente brillante y sus métodos poco legales para reconstruir el rompecabezas sin resolver del asesinato de un jefe de Hacienda.','Acción, Crimen, Drama','2h 12m','Gavin O''Connor','Ben Affleck, Jon Bernthal, Cynthia Addai-Robinson','7,0')
,('27','https://m.media-amazon.com/images/M/MV5BODJiNDcwMGEtNTA3Zi00NDgwLWFhMWMtZmU5NzkwMjA3NmZmXkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Die My Love','2025','En una remota zona rural olvidada, una madre lucha por mantener la cordura mientras lucha contra la psicosis.','Comedia, Suspense','1h 58m','Lynne Ramsay','Jennifer Lawrence, Robert Pattinson, Nick Nolte','6,5')
,('28','https://m.media-amazon.com/images/M/MV5BNTY1MDg1MWYtZmJkMC00Y2I2LWFhNmItYmUxZjRiODk3OGNiXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Misión: Imposible - Fallout','2018','Ethan Hunt y su equipo del FMI, junto con algunos aliados conocidos, corren contrarreloj después de que una misión saliera mal.','Acción, Aventura, Suspense','2h 27m','Christopher McQuarrie','Tom Cruise, Henry Cavill, Ving Rhames','7,7')
,('29','https://m.media-amazon.com/images/M/MV5BMzg1MDk5NTMtZjQ5Mi00ZmRlLTg3ZTUtZTFlZGQ1YzBhMjcwXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Karate Kid: Legends','2025','Daniel llega a Beijing, donde el Sr. Han lo ha estado buscando. Han tiene un nuevo protegido, Li Fong. Los dos mentores deben colaborar para instruir a Li Fong, pero queda por ver si sus enfoques educativos serán compatibles.','Acción, Drama, Familiar','1h 34m','Jonathan Entwistle','Jackie Chan, Ben Wang, Joshua Jackson','6,5')
,('30','https://m.media-amazon.com/images/M/MV5BNDQ2MGIyNDQtYjVhOS00ZjI1LWFmYzctMWI2MGZhZGFhZWM4XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Untitled the Weeknd & Trey Edward Shults Project','2025','Un músico que sufre de insomnio se topa con un enigmático desconocido, desencadenando una aventura que pondrá en duda toda su realidad.','Suspense','1h 45m','Trey Edward Shults','The Weeknd, Jenna Ortega, Barry Keoghan','5,3')
,('31','https://m.media-amazon.com/images/M/MV5BNTMyYzNiZjEtZTM3NC00OGRkLTkzMjEtZGI2NDcwZTk5NmNhXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','The Brutalist','2024','Cuando el visionario arquitecto László Toth y su esposa Erzsébet huyen de la Europa de posguerra en 1947 para reconstruir su legado y ver el nacimiento de la América moderna, sus vidas cambian a causa de un misterioso y adinerado cliente.','Drama','3h 36m','Brady Corbet','Adrien Brody, Felicity Jones, Guy Pearce','7,4')
,('32','https://m.media-amazon.com/images/M/MV5BMjdkNzJlYzgtY2MwZC00NWFjLTgwMDgtOTJkY2Q3NjA3MjMzXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Ballerina','2025','Una asesina entrenada por la Ruska Roma desde su infancia, la misma organización criminal encargada del adiestramiento de John Wick, intentará por todos los medios averiguar quién está detrás del asesinato de su padre.','Acción, Suspense','2h 5m','Len Wiseman','Ana de Armas, Keanu Reeves, Ian McShane',NULL)
,('33','https://m.media-amazon.com/images/M/MV5BOWM4MjIxZmQtYzA3YS00YThiLWI5MjItZDM0YjZmNDFhZDA3XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','The Legend of Ochi','2025','Una niña descubre los misterios de la comunicación animal.','Aventura, Familiar, Fantasía','1h 35m','Isaiah Saxon','Helena Zengel, Willem Dafoe, Emily Watson','6,0')
,('34','https://m.media-amazon.com/images/M/MV5BN2FhYjgzYTctZDcyZS00MTdlLWIzYzUtOGIyMTYzZWJkYzc4XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Confidencial (Black Bag)','2025','En un viaje de autodescubrimiento, un hombre se enfrenta al deber de amar y defender su patria, encontrándose en tres encrucijadas vitales.','Drama, Misterio, Romance','1h 33m','Steven Soderbergh','Michael Fassbender, Gustaf Skarsgård, Cate Blanchett','6,8')
,('35','https://m.media-amazon.com/images/M/MV5BNjQyMjNiMDEtOTFlNy00NmI3LTljMzctNDU5ZDI3N2EzNDFmXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','La acompañante','2025','La muerte de un multimillonario desencadena una serie de acontecimientos para Iris y sus amigos durante un viaje de fin de semana a su finca junto al lago.','Ciencia ficción, Suspense','1h 37m','Drew Hancock','Sophie Thatcher, Jack Quaid, Lukas Gage','6,9')
,('36','https://m.media-amazon.com/images/M/MV5BMGQ1MTAzNmItOWQ0Ny00MDJhLWJkZmMtYWY2MWY3OTE3MjU2XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Novocaine','2025','Un hombre introvertido y apacible nace con un extraño trastorno genético que le hace inmune al dolor físico. Cuando su nueva novia es tomada como rehén en el atraco a un banco, su aflicción se convierte en su superpoder.','Acción, Comedia, Suspense','1h 50m','Dan Berk, Robert Olsen','Jack Quaid, Amber Midthunder, Ray Nicholson','6,5')
,('37','https://m.media-amazon.com/images/M/MV5BNGJiMzU2M2MtMjMyNC00YmFmLTljYjgtNWIzNDI5ZjE2YjZjXkEyXkFqcGc@._V1_QL75_UY207_CR2,0,140,207_.jpg','Cónclave','2024','Sigue al cardenal Lomeli mientras supervisa al grupo de cardenales encargados de elegir a un nuevo líder de la Iglesia, al tiempo que intenta descubrir un secreto del difunto Pontífice.','Drama, Suspense','2h','Edward Berger','Ralph Fiennes, Stanley Tucci, John Lithgow','7,4')
,('38','https://m.media-amazon.com/images/M/MV5BMjIxODZlM2EtODU5Ny00OTFkLTgyNjAtNzNmMWJkNmRhZjZkXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Gladiator II','2024','Años después de presenciar la muerte del héroe Máximo a manos de su tío, Lucio se ve forzado a entrar en el Coliseo tras ser testigo de la conquista de su hogar por parte de los tiránicos emperadores que dirigen Roma con puño de hierro.','Acción, Aventura, Drama','2h 28m','Ridley Scott','Paul Mescal, Denzel Washington, Pedro Pascal','6,5')
,('39','https://m.media-amazon.com/images/M/MV5BMWUwYmJmNDYtNjJhNi00ZjZiLWFhNzktYjEyMWQ5NWM3MmE5XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','28 años después','2025','Trama no develada. Tercera película de la franquicia "28 días después".','Terror, Suspense','1h 55m','Danny Boyle','Jack O''Connell, Ralph Fiennes, Aaron Taylor-Johnson',NULL)
,('40','https://m.media-amazon.com/images/M/MV5BYjkyNmFiYTYtODE4Mi00ZWRlLWI3OWUtY2RjMmYxNzljYWM1XkEyXkFqcGc@._V1_QL75_UX140_CR0,6,140,207_.jpg','Misión: Imposible - Nación secreta','2015','Ethan y su equipo asumen su misión más imposible hasta la fecha, erradicar al Sindicato, una organización internacional clandestina tan altamente cualificada como ellos, comprometida con la destrucción del FMI.','Acción, Aventura, Suspense','2h 11m','Christopher McQuarrie','Tom Cruise, Rebecca Ferguson, Jeremy Renner','7,4')
,('41','https://m.media-amazon.com/images/M/MV5BY2E5YjE2YTQtZGIxYi00YTU4LTk3YzItYmMyZTM3M2I5ZTM3XkEyXkFqcGc@._V1_QL75_UX140_CR0,7,140,207_.jpg','Cómo entrenar a tu dragón','2025','Un joven vikingo aspira a cazar dragones, pero se convierte inesperadamente en amigo de un joven dragón.','Acción, Aventura, Comedia','2h 5m','Dean DeBlois','Mason Thames, Nico Parker, Gerard Butler',NULL)
,('42','https://m.media-amazon.com/images/M/MV5BNzY1MzdjMjYtNDJiZS00N2U4LWI0MWQtZTRiZWYxMzU3ZmI4XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Misión: Imposible 3','2006','Agente del IMF Ethan Hunt se enfrenta a un peligroso y sádico traficante de armas que amenaza su vida y la de su prometida.','Acción, Aventura, Suspense','2h 6m','J.J. Abrams','Tom Cruise, Michelle Monaghan, Ving Rhames','6,9')
,('43','https://m.media-amazon.com/images/M/MV5BZmI5NjIyZmMtMjBhOC00NGE0LTkwZDYtMzFkMDY1MDQ0NWQxXkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg','Destino final 2','2003','Kimberly tiene una premonición sobre una colisión múltiple y mantiene a salvo a algunos de los destinados a morir. La muerte acecha a ese grupo de supervivientes.','Terror, Suspense','1h 30m','David R. Ellis','A.J. Cook, Ali Larter, Tony Todd','6,2')
,('44','https://m.media-amazon.com/images/M/MV5BNTViNGI0MzMtYTJlMS00Y2NiLTg5MDYtZTE3NTY1OWY3YmU3XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Robot salvaje','2024','La robot Roz, que ha naufragado en una isla deshabitada, debe aprender a adaptarse al duro entorno, forjando poco a poco relaciones con la fauna local y convirtiéndose en madre adoptiva de una cría de ganso huérfana.','Animación, Ciencia ficción','1h 42m','Chris Sanders','Lupita Nyong''o, Pedro Pascal, Kit Connor','8,2')
,('45','https://m.media-amazon.com/images/M/MV5BZWY5ZmYyMDctZTA3YS00ODY1LTgyMjEtOTA3YmNhMmY2NWNlXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Misión: Imposible - Protocolo fantasma','2011','El IMF es clausurado cuando se ve incriminado en un ataque bomba al Kremlin. Ethan Hunt y su nuevo equipo se embarcan en un misión clandestina para limpiar el nombre de la organización.','Acción, Aventura, Suspense','2h 12m','Brad Bird','Tom Cruise, Jeremy Renner, Simon Pegg','7,4')
,('46','https://m.media-amazon.com/images/M/MV5BMDgzZTgzOTEtMTllZS00ZDdjLWE4NWUtOTkwOTk0Mjk3ODA5XkEyXkFqcGc@._V1_QL75_UY207_CR13,0,140,207_.jpg','Eddington','2025','Una pareja varada en un pequeño pueblo de Nuevo México durante la pandemia encuentra que la comunidad inicialmente acogedora se vuelve siniestra al caer la noche.','Comedia, Drama, Del oeste','2h 28m','Ari Aster','Joaquin Phoenix, Deirdre O''Connell, Emma Stone','5,8')
,('47','https://m.media-amazon.com/images/M/MV5BYTI4NjcwODMtZGVhMi00ODhhLWIwODItZTQ4MmY0ZmU5OTliXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','The Last Rodeo','2025','Un ex jinete de rodeo de 50 años distanciado de su hija decide montar de nuevo cuando surge una crisis con su nieto, enfrentando sus demonios y considerando el máximo sacrificio por su familia.','Drama','1h 56m','Jon Avnet','Neal McDonough, Mykelti Williamson, Sarah Jones','6,9')
,('48','https://m.media-amazon.com/images/M/MV5BOWM0YjkwNTYtNDYxNS00NTk5LWEwYzEtN2U0MzQyYTA3ODkyXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Misión: Imposible 2','2000','"El agente del FMI Ethan Hunt es enviado a Sydney, para encontrar y destruir una enfermedad genéticamente modificada llamada ""Quimera""."','Acción, Aventura, Suspense','2h 3m','John Woo','Tom Cruise, Dougray Scott, Thandiwe Newton','6,1')
,('49','https://m.media-amazon.com/images/M/MV5BZTlhYTk1ZTEtOWY3NC00NWQ5LTlkOTctNjQ3ZDYyZGE5ZWNlXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Bring Her Back','2025','Un hermano y una hermana descubren un ritual aterrador en la apartada casa de su nueva madre adoptiva.','Terror, Misterio','1h 44m','Danny Philippou, Michael Philippou','Billy Barratt, Sally Hawkins, Mischa Heywood','7,7')
,('50','https://m.media-amazon.com/images/M/MV5BYTA2NTA5NDYtMzlkOC00MTQxLWI0NDQtMzk2M2YzMGE4MTkxXkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','A Complete Unknown','2024','En 1961, un desconocido de 19 años llamado Bob Dylan llegó a Nueva York sólo con su guitarra. Conoció a iconos de la música folk y pronto se hizo notar por su talento.','Biografía, Drama, Música','2h 21m','James Mangold','Timothée Chalamet, Edward Norton, Elle Fanning','7,4')
,('51','https://m.media-amazon.com/images/M/MV5BOWRiOThkM2YtYzI4NS00OWViLTk0ODMtMjNlNDYyZWQ3MzNjXkEyXkFqcGc@._V1_QL75_UY207_CR13,0,140,207_.jpg','F1','2025','Sigue a un piloto de Fórmula Uno que sale de su retiro para convertirse en mentor y formar equipo con un piloto más joven.','Acción, Drama, Deporte','2h 35m','Joseph Kosinski','Brad Pitt, Javier Bardem, Kerry Condon',NULL)
,('52','https://m.media-amazon.com/images/M/MV5BNmE0NGQ5NmUtNWY3OS00MjRjLTgyZTYtNWY3Y2E3YTEzYzg0XkEyXkFqcGc@._V1_QL75_UY207_CR1,0,140,207_.jpg','Anora','2024','Anora, una joven trabajadora sexual de Brooklyn, conoce a Ivan, el hijo de un oligarca. Se casan por capricho. Su cuento de hadas se ve amenazado cuando los padres de Iván se enteran de la noticia y deciden anular el matrimonio.','Comedia, Drama, Romance','2h 19m','Sean Baker','Mikey Madison, Paul Weissman, Yura Borisov','7,5')
,('53','https://m.media-amazon.com/images/M/MV5BMDBhNTg1MWMtMDc5Ni00YTk1LWFjNGUtMmE2Y2Q5MGQ2M2Q2XkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Otro pequeño favor','2025','Sigue a Stephanie Smothers y Emily Nelson cuando se dirigen a la hermosa isla de Capri, Italia, para la extravagante boda de Emily con un rico hombre de negocios italiano.','Comedia, Crimen, Misterio','2h','Paul Feig','Blake Lively, Anna Kendrick, Allison Janney','5,3')
,('54','https://m.media-amazon.com/images/M/MV5BMTgyOTExNDc1M15BMl5BanBnXkFtZTcwMDA0MTA4NQ@@._V1_QL75_UY207_CR0,0,140,207_.jpg','Destino final 5','2011','La muerte vuelve para reclamar a los afortunados supervivientes del derrumbe de un mortífero puente.','Terror, Suspense','1h 32m','Steven Quale','Nicholas D''Agosto, Emma Bell, Arlen Escarpeta','5,9')
,('55','https://m.media-amazon.com/images/M/MV5BOWM1NWVmMGQtZTUzNC00NzAwLWIzMmMtMmUwMmQwYzY3MjVkXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Destino final 3','2006','Una adolescente tiene la premonición de que ella y sus amigos se verán involucrados en un accidente en una montaña rusa. Cuando la visión se hace realidad, los supervivientes se enfrentan a las repercusiones de haber engañado a la muerte.','Terror, Suspense','1h 33m','James Wong','Mary Elizabeth Winstead, Ryan Merriman, Kris Lemche','5,9')
,('56','https://m.media-amazon.com/images/M/MV5BNGQ0YTY2OWEtMmFhZC00MjFjLWEwODMtMjFkMjRmZjNlNGRhXkEyXkFqcGc@._V1_QL75_UY207_CR7,0,140,207_.jpg','El destino final','2009','Una espeluznante premonición salva a un joven y a sus amigos de la muerte durante un accidente en una pista de carreras, pero a pesar de ello les espera un destino terrible.','Terror, Suspense','1h 22m','David R. Ellis','Nick Zano, Krista Allen, Andrew Fiscella','5,1')
,('57','https://m.media-amazon.com/images/M/MV5BNDcwMmIwMTUtZGNkZC00Nzk0LTgzOWQtYTJiMTVlMzRlMmJkXkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Sentimental Value','2025','Una exploración íntima y conmovedora de la familia, los recuerdos y el poder reconciliador del arte.','Comedia, Drama','2h 12m','Joachim Trier','Renate Reinsve, Stellan Skarsgård, Inga Ibsdotter Lilleaas','7,9')
,('58','https://m.media-amazon.com/images/M/MV5BZTBhNTE0OTgtMTkxYy00OTZhLWE2MjQtZDNkMjgyNzE4ODA1XkEyXkFqcGc@._V1_QL75_UY207_CR2,0,140,207_.jpg','La cita','2025','En su primera cita en años, la viuda Violet ve truncado su romance con el encantador Henry al recibir siniestros mensajes anónimos.','Drama, Misterio, Suspense','1h 35m','Christopher Landon','Meghann Fahy, Brandon Sklenar, Violett Beane','6,1')
,('59','https://m.media-amazon.com/images/M/MV5BZTU1MzU1YzctMDQ1MS00ZmRhLWFkZmYtZmNjM2YwYzIwMDgxXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','The Hunger Games: Sunrise on the Reaping','2026','Explora Panem 24 años antes de la saga de Katniss, comenzando en la mañana de la siega de los 50º Juegos del Hambre, donde participa un joven Haymitch Abernathy.','Acción, Aventura, Fantasía',NULL,'Francis Lawrence','Elle Fanning, Jesse Plemons, Ralph Fiennes',NULL)
,('60','https://m.media-amazon.com/images/M/MV5BOWMyMDk5MjAtNDM4Mi00Y2Y3LTg3YTktNzk3NjAxNDc2OTdmXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Los 4 Fantásticos: Primeros pasos','2025','La primera familia de Marvel se enfrenta a su mayor desafío hasta la fecha. Obligados a equilibrar su papel de héroes con la fuerza de su vínculo familiar, deben defender la Tierra de un voraz dios del espacio llamado Galactus.','Acción, Aventura, Ciencia ficción','2h 10m','Matt Shakman','Pedro Pascal, Vanessa Kirby, Joseph Quinn',NULL)
,('61','https://m.media-amazon.com/images/M/MV5BMWJkMzMyZmYtMjc1NC00ODBlLWJjMzUtZWJhMDc4NjVkYzU4XkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','La sustancia','2024','El terror corporal: La poderosa re-lectura feminista de Fargeat','Drama, Terror, Ciencia ficción','2h 21m','Coralie Fargeat','Demi Moore, Margaret Qualley, Dennis Quaid','7,2')
,('62','https://m.media-amazon.com/images/M/MV5BMTA1MjE0Nzk4MDleQTJeQWpwZ15BbWU4MDA0NjIxMjAx._V1_QL75_UY207_CR6,0,140,207_.jpg','Cadena perpetua','1994','Andy Dufresne es encarcelado por matar a su esposa y al amante de esta. Tras una dura adaptación, intenta mejorar las condiciones de la prisión y dar esperanza a sus compañeros.','Drama','2h 22m','Frank Darabont','Tim Robbins, Morgan Freeman, Bob Gunton','9,3')
,('63','https://m.media-amazon.com/images/M/MV5BYjVkMzI2MjAtYzA3NC00OGE1LWEyZDMtODc0YTc5NTZjYzFiXkEyXkFqcGc@._V1_QL75_UY207_CR13,0,140,207_.jpg','Exterritorial','2025','Cuando el hijo de un soldado desaparece en un consulado de los Estados Unidos, ella permanece ilegalmente en las instalaciones para buscarlo y, sin saberlo, se ve envuelta en una peligrosa conspiración.','Acción, Misterio, Suspense','1h 49m','Christian Zübert','Jeanne Goursaud, Dougray Scott, Lera Abova','5,7')
,('64','https://m.media-amazon.com/images/M/MV5BNGUzY2Y0ZmItZDE4Ny00OGE2LWI0MjQtNzY2YjRmNTRkMTZiXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Nosferatu','2024','Una historia gótica de obsesión entre una joven encantada en la Alemania del siglo XIX y el antiguo vampiro de Transilvania que la acecha y trae consigo un horror incalculable.','Fantasía, Terror, Misterio','2h 12m','Robert Eggers','Lily-Rose Depp, Nicholas Hoult, Bill Skarsgård','7,2')
,('65','https://m.media-amazon.com/images/M/MV5BNDRjY2E0ZmEtN2QwNi00NTEwLWI3MWItODNkMGYwYWFjNGE0XkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Capitán América: Brave New World','2025','La trama se mantiene en secreto. Cuarta película de la franquicia del Capitán América.','Acción, Aventura, Ciencia ficción','1h 58m','Julius Onah','Anthony Mackie, Harrison Ford, Danny Ramirez','5,7')
,('66','https://m.media-amazon.com/images/M/MV5BMTU0YjAxOTctMzY3MC00M2Q2LTlhMDItZDk0YjhjMzViYWU0XkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Babygirl','2024','A pesar del riesgo y los prejuicios, una directora ejecutiva muy exitosa comienza una aventura ilícita con su becario mucho más joven.','Drama, Romance, Suspense','1h 54m','Halina Reijn','Nicole Kidman, Harris Dickinson, Antonio Banderas','5,9')
,('67','https://m.media-amazon.com/images/M/MV5BOTQ5Y2QyYTktYmFmZi00NWJlLWE0MzgtYTA4M2I0ZjQwZjcxXkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','El abismo secreto','2025','Dos jóvenes muy peligrosos que, a pesar del mundo corrupto y letal en el que se mueven, encuentran un alma gemela el uno en el otro.','Acción, Aventura, Terror','2h 7m','Scott Derrickson','Miles Teller, Anya Taylor-Joy, Sigourney Weaver','6,7')
,('68','https://m.media-amazon.com/images/M/MV5BY2IzOWJlMzktYmUxMy00MmY2LWJiZTgtYTQ0MjQyOGRmNWNiXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Heretic (Hereje)','2024','Sigue a dos jóvenes religiosas que se involucran en un juego del gato y el ratón en la casa de un extraño.','Terror, Suspense','1h 51m','Scott Beck, Bryan Woods','Hugh Grant, Sophie Thatcher, Chloe East','7,0')
,('69','https://m.media-amazon.com/images/M/MV5BNmQxMTI1YmEtOGY3Yi00NzVlLWEzMjAtYTI1NWZkNDFiMDg1XkEyXkFqcGc@._V1_QL75_UX140_CR0,5,140,207_.jpg','Materialistas','2025','Una joven y ambiciosa casamentera de la ciudad de Nueva York se encuentra dividida entre su pareja perfecta y su ex imperfecto.','Comedia, Romance','1h 49m','Celine Song','Dakota Johnson, Chris Evans, Pedro Pascal',NULL)
,('70','https://m.media-amazon.com/images/M/MV5BMjRhOTgwOTEtZmNhOC00OTc1LTlhODYtZDdkYzJiMmZhYmYxXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','28 días después','2002','Cuatro semanas después de que un misterioso e incurable virus se extienda por todo el Reino Unido, un puñado de supervivientes intenta encontrar refugio.','Drama, Terror, Ciencia ficción','1h 53m','Danny Boyle','Cillian Murphy, Naomie Harris, Christopher Eccleston','7,5')
,('71','https://m.media-amazon.com/images/M/MV5BMDBkZDNjMWEtOTdmMi00NmExLTg5MmMtNTFlYTJlNWY5YTdmXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Top Gun: Maverick','2022','Después de más de treinta años de servicio como uno de los mejores aviadores de la Armada, Pete Mitchell está donde pertenece, forzando los límites como valiente piloto de pruebas y esquivando el avance de rango que lo dejaría en tierra.','Acción, Drama','2h 10m','Joseph Kosinski','Tom Cruise, Jennifer Connelly, Miles Teller','8,2')
,('72','https://m.media-amazon.com/images/M/MV5BNjUzMjhkZjktNTU5Mi00MzhmLWJhMTQtZjhkYjczOTEzM2M5XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Death of a Unicorn','2025','El dúo padre-hija, Riley y Elliot, atropellan a un unicornio con su coche y lo llevan al refugio natural de un director general farmacéutico mega-rico.','Comedia, Fantasía, Terror','1h 47m','Alex Scharfman','Paul Rudd, Jenna Ortega, Will Poulter','5,9')
,('73','https://m.media-amazon.com/images/M/MV5BOWNiMGQxYzAtNzc1Yy00NTNjLWIwNmEtNzcyZjk2ZDYyMzM1XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','El contable','2016','Cuando un experto en matemáticas blanquea los libros de un nuevo cliente, el Departamento del Tesoro se acerca a sus actividades, y el número de cadáveres empieza a aumentar.','Acción, Crimen, Drama','2h 8m','Gavin O''Connor','Ben Affleck, Anna Kendrick, J.K. Simmons','7,3')
,('74','https://m.media-amazon.com/images/M/MV5BN2UwZjg1ZjEtMDc5Ni00MTYyLTkzMmMtYjYxZmFhYzYyMGZmXkEyXkFqcGc@._V1_QL75_UY207_CR86,0,140,207_.jpg','Pillion','2025','Colin, un hombre reservado, se vincula inesperadamente con Ray, un carismático líder de moteros. Ray lo inicia en una dinámica sumisa, sacudiendo su rutina y fomentando su crecimiento personal.','Drama, Romance','1h 43m','Harry Lighton','Alexander Skarsgård, Harry Melling, Douglas Hodge','7,3')
,('75','https://m.media-amazon.com/images/M/MV5BNjQyOTRiYTQtNzU0MS00ZGM2LWE4MTktODI5ZjZiN2NkYjYyXkEyXkFqcGc@._V1_QL75_UY207_CR2,0,140,207_.jpg','Raid 2','2025','En Rajastán 1989, el oficial Patnaik efectúa una redada sin éxito. Tras solicitar un soborno, le trasladan a Bhoj, donde investiga a Dada Bhai, figura respetada. Suspendido tras otra redada, descubre secretos.','Crimen, Drama, Suspense','2h 25m','Raj Kumar Gupta','Ajay Devgn, Riteish Deshmukh, Vaani Kapoor','7,2')
,('76','https://m.media-amazon.com/images/M/MV5BZjlkZWQ2YjAtOTZjNi00MmY1LTlkMDMtYTUxODU5Y2Y0MDY4XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg','Agente secreto','2025','Bajo el espectro amenazador del Brasil de 1977, conocemos a Marcelo, un hombre de unos 40 años que se ha mudado recientemente a Recife, en la costa noreste de Brasil, para escapar de un pasado violento.','Crimen, Drama, Historia','2h 38m','Kleber Mendonça Filho','Wagner Moura, Maria Fernanda Cândido, Gabriel Leone','7,9')
,('77','https://m.media-amazon.com/images/M/MV5BODE1M2NhOTYtMmFmNi00NTUwLWI5YzEtN2ZhNDhjMWZmNWViXkEyXkFqcGc@._V1_QL75_UY207_CR13,0,140,207_.jpg','Zootrópolis 2','2025','La policía coneja Judy Hopps y su amigo el zorro Nick Wilde vuelven a unirse para resolver su caso más peligroso y complejo.','Animación, Acción, Aventura',NULL,'Jared Bush, Byron Howard','Jason Bateman, Quinta Brunson, Fortune Feimster',NULL)
,('78','https://m.media-amazon.com/images/M/MV5BMzQ3OTI0ZTUtMzkwMC00MzZhLWJiZmYtODFmZjZmMmJiMTc5XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Alpha','2025','Alpha, de 13 años, es una adolescente problemática que vive sola con su madre. Su mundo se derrumba el día que regresa de la escuela con un tatuaje en el brazo.','Drama','2h 8m','Julia Ducournau','Tahar Rahim, Golshifteh Farahani, Mélissa Boros','5,2')
,('79','https://m.media-amazon.com/images/M/MV5BODM2NTUxOGMtM2ZkYS00MjM3LTkzYzEtZjdkNmQ1ZTBhMWY3XkEyXkFqcGc@._V1_QL75_UY207_CR114,0,140,207_.jpg','Un simple accidente','2025','Un pequeño percance provocó una reacción en cadena de problemas cada vez mayores.','Acción, Aventura, Crimen','1h 41m','Jafar Panahi','Vahid Mobasseri, Mariam Afshari, Ebrahim Azizi','7,4')
,('80','https://m.media-amazon.com/images/M/MV5BYjgzMTgyNzYtZjMzZS00NGRmLWE2YTAtMDQ4NTA3N2FmNmNhXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Amateur','2025','Sigue a un criptógrafo de la CIA, que consigue chantajear a su agencia para que le entrenen y le dejen ir tras un grupo de terroristas que mataron a su mujer en Londres.','Acción, Suspense','2h 2m','James Hawes','Rami Malek, Rachel Brosnahan, Jon Bernthal','6,7')
,('81','https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Interstellar','2014','Un equipo de exploradores viaja a través de un agujero de gusano en el espacio en un intento de garantizar la supervivencia de la humanidad.','Aventura, Drama, Ciencia ficción','2h 49m','Christopher Nolan','Matthew McConaughey, Anne Hathaway, Jessica Chastain','8,7')
,('82','https://m.media-amazon.com/images/M/MV5BNjNhODY5OWEtZjMxNy00NzFhLWIzOTQtZTNmYjUwOGRiMzYwXkEyXkFqcGc@._V1_QL75_UY207_CR13,0,140,207_.jpg','The Diplomat','2025','Un diplomático indio que intenta repatriar a una niña india desde Pakistán, donde presumiblemente la obligaron y engañaron para que se casara contra su voluntad.','Drama, Suspense','2h 10m','Shivam Nair','John Abraham, Sadia Khateeb, Kumud Mishra','7,1')
,('83','https://m.media-amazon.com/images/M/MV5BNTljNjllNDAtMzc0MS00ZGExLThlOTktOTRlNzc3YjA3ZWFlXkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg','El padrino','1972','El envejecido patriarca de una dinastía del crimen organizado en la ciudad de Nueva York de la posguerra transfiere el control de su imperio clandestino a su reacio hijo menor.','Crimen, Drama','2h 55m','Francis Ford Coppola','Marlon Brando, Al Pacino, James Caan','9,2')
,('84','https://m.media-amazon.com/images/M/MV5BZmJhZjI4ODktNjI3MC00N2U2LTg0YzYtZTgzNTk4NDJkNmVhXkEyXkFqcGc@._V1_QL75_UY207_CR0,0,140,207_.jpg','The Surrender','2025','Cuando el patriarca de la familia muere, una madre y una hija afligidas arriesgan sus vidas para llevar a cabo un brutal ritual de resurrección y resucitarlo de entre los muertos.','Drama, Terror, Suspense','1h 36m','Julia Max','Colby Minifie, Kate Burton, Chelsea Alden','5,5')
,('85','https://m.media-amazon.com/images/M/MV5BNzUzYmUyZDYtYTM5My00MjhkLTk2NDEtZmRiODEzOWE1MzRmXkEyXkFqcGc@._V1_QL75_UY207_CR2,0,140,207_.jpg','Un pequeño favor','2018','Una mujer intenta descubrir la verdad tras la desaparición de su mejor amiga.','Comedia, Crimen, Misterio','1h 57m','Paul Feig','Anna Kendrick, Blake Lively, Henry Golding','6,8')
,('86','https://m.media-amazon.com/images/M/MV5BOGUwNzQwMzYtZTkyYi00OTM3LWJiOGEtNzVkN2UxOGZlMmE3XkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Clown in a Cornfield','2025','Frendo, un payaso que encarna la gloria desvanecida de un pueblo, regresa como una fuerza siniestra en una localidad del Medio Oeste en decadencia, sembrando terror.','Terror, Misterio, Suspense','1h 36m','Eli Craig','Katie Douglas, Aaron Abrams, Carson MacCormac','6,2')
,('87','https://m.media-amazon.com/images/M/MV5BNzZhMTc5MWUtOTE2MS00MjUwLTljYWEtYTk1ZmVjNzhmMzYzXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','The Monkey','2025','Cuando los gemelos Bill y Hal encuentran el viejo juguete del mono de su padre, comienzan una serie de muertes espantosas. Los hermanos deciden tirar el juguete y seguir adelante con sus vidas, distanciándose con el paso de los años.','Terror','1h 38m','Osgood Perkins','Theo James, Tatiana Maslany, Christian Convery','6,0')
,('88','https://m.media-amazon.com/images/M/MV5BZGRhNjU2NWEtNDNmYy00YmEwLWFiMTEtZDA5YmFmYmJkMThhXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Familia al instante','2018','Una pareja se siente desbordada tras decidir experimentar la paternidad convirtiéndose en padres de acogida de tres niños revoltosos.','Comedia, Drama','1h 58m','Sean Anders','Mark Wahlberg, Rose Byrne, Isabela Merced','7,3')
,('89','https://m.media-amazon.com/images/M/MV5BNTQwYjM2YjUtOWM0Ni00ODgyLTg4NjQtODU2NDI5YjM2ZWQzXkEyXkFqcGc@._V1_QL75_UY207_CR13,0,140,207_.jpg','Bitelchús Bitelchús','2024','Tras una tragedia familiar, tres generaciones de la familia Deetz regresan a Winter River. Todavía atormentada por Bitelchús, la vida de Lydia da un vuelco cuando su hija adolescente, Astrid, abre accidentalmente el portal al Más Allá.','Comedia, Fantasía, Terror','1h 45m','Tim Burton','Michael Keaton, Winona Ryder, Catherine O''Hara','6,6')
,('90','https://m.media-amazon.com/images/M/MV5BNzBiMTQ0YjMtZDRhMC00ZDU4LTk3MDMtNWQxOGMwMjQzYjc4XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Dune: Parte dos','2024','El duque Paul Atreides se une a los Fremen y comienza su entrenamiento para convertirse en Muad''Dib, mientras trata de evitar el terrible futuro que ha previsto: una guerra santa en su nombre, esparciéndose por todo el universo conocido.','Acción, Aventura, Drama','2h 46m','Denis Villeneuve','Timothée Chalamet, Zendaya, Rebecca Ferguson','8,5')
,('91','https://m.media-amazon.com/images/M/MV5BZDZlZjY4NGMtNWIwNC00OWVhLTkyMmUtODI5ZDY4MmFhODllXkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Gladiator (El gladiador)','2000','Un exgeneral romano se propone vengarse del emperador corrupto que asesinó a su familia y lo envió a la esclavitud.','Acción, Aventura, Drama','2h 35m','Ridley Scott','Russell Crowe, Joaquin Phoenix, Connie Nielsen','8,5')
,('92','https://m.media-amazon.com/images/M/MV5BMDVlMTQyYTgtNjUyZS00Y2E1LTlmMTktMDJkM2E1YzFiMzQxXkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Bala perdida','2025','El exjugador de béisbol Hank Thompson se ve envuelto en una peligrosa lucha por la supervivencia en medio del submundo criminal de la ciudad de Nueva York de los 90, obligado a navegar por un traicionero inframundo que nunca imaginó.','Comedia, Crimen, Suspense',NULL,'Darren Aronofsky','Austin Butler, Zoë Kravitz, Vincent D''Onofrio',NULL)
,('93','https://m.media-amazon.com/images/M/MV5BNTQxYmM1NzQtY2FiZS00MzRhLTljZDYtZjRmMGNiMWI3NTQxXkEyXkFqcGc@._V1_QL75_UY207_CR3,0,140,207_.jpg','Origen','2010','A un ladrón que roba secretos corporativos a través del uso de la tecnología de compartir sueños, se le da la tarea de implantar una idea en la mente de un jefe de una gran empresa.','Acción, Aventura, Ciencia ficción','2h 28m','Christopher Nolan','Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page','8,8')
,('94','https://m.media-amazon.com/images/M/MV5BZWFhZDJiODYtZTA5My00NWYyLTgzY2YtOTUwMGYxZTFkYzdjXkEyXkFqcGc@._V1_QL75_UY207_CR1,0,140,207_.jpg','Rosario','2025','Rosario pasa la noche con el cuerpo de su abuela mientras espera a que llegue la ambulancia, durante una fuerte nevada, Rosario es atacada por entidades de otro mundo que han tomado el control del cuerpo de su abuela.','Terror','1h 28m','Felipe Vargas','David Dastmalchian, Emeraude Toubia, José Zúñiga','4,4')
,('95','https://m.media-amazon.com/images/M/MV5BNmRmMjc5MWMtMzZmMy00NTYzLTgwZDQtNTAyMmNlYmIxOTg2XkEyXkFqcGc@._V1_QL75_UX140_CR0,1,140,207_.jpg','Las cuatro estaciones','1981','Tres parejas van de vacaciones juntas cada temporada. Tras el divorcio de una de ellas, surgen sentimientos de traición y más críticas hacia la otra, pero las cosas que las mantienen unidas son más fuertes que las que podrían separarlas.','Comedia, Drama','1h 47m','Alan Alda','Alan Alda, Carol Burnett, Len Cariou','6,8')
,('96','https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_QL75_UX140_CR0,0,140,207_.jpg','El caballero oscuro','2008','Cuando la amenaza conocida como el Joker causa estragos y el caos en Gotham City, Batman debe aceptar una de las mayores pruebas psicológicas y físicas para luchar contra la injusticia.','Acción, Crimen, Drama','2h 32m','Christopher Nolan','Christian Bale, Heath Ledger, Aaron Eckhart','9,0')
,('97','https://m.media-amazon.com/images/M/MV5BNTFlZDI1YWQtMTVjNy00YWU1LTg2YjktMTlhYmRiYzQ3NTVhXkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg','Oppenheimer','2023','La historia del científico J. Robert Oppenheimer y su rol en el desarrollo de la bomba atómica.','Biografía, Drama, Historia','3h','Christopher Nolan','Cillian Murphy, Emily Blunt, Matt Damon','8,3')
,('98','https://m.media-amazon.com/images/M/MV5BOWFjMGIwNDgtODE5MS00ZWVkLTlhNzgtMDI1ZDM1OWMyYzY4XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','La evaluación','2024','Después de una catástrofe climática, una sociedad aparentemente perfecta pone a prueba a una pareja durante una semana para ver si están aptos para la paternidad. Un evaluador analiza cada aspecto de sus vidas.','Drama, Ciencia ficción','1h 54m','Fleur Fortune','Alicia Vikander, Elizabeth Olsen, Himesh Patel','6,6')
,('99','https://m.media-amazon.com/images/M/MV5BNGU3YTdiM2EtY2Y3MC00NTIzLWEzYzYtM2IxZDNhZjkwNjU1XkEyXkFqcGc@._V1_QL75_UY207_CR5,0,140,207_.jpg','La guerra de las galaxias','1977','Luke Skywalker une sus fuerzas con un caballero jedi, un piloto fanfarrón, un wookiee y dos droides para salvar a la galaxia de la estación espacial del Imperio, a la vez que intenta rescatar a la princesa Leia del malvado Darth Vader.','Acción, Aventura, Fantasía','2h 1m','George Lucas','Mark Hamill, Harrison Ford, Carrie Fisher','8,6')
,('100','https://m.media-amazon.com/images/M/MV5BMGNiN2RlZTMtMTkyZC00YjkwLTgyY2QtMDg1ZDNhODQwNWM4XkEyXkFqcGc@._V1_QL75_UX140_CR0,0,140,207_.jpg','Avengers: Doomsday','2026','Trama en secreto.','Acción, Aventura, Ciencia ficción',NULL,'Anthony Russo, Joe Russo','Robert Downey Jr., Pedro Pascal, Chris Hemsworth',NULL);

SELECT setval('movies_id_seq', (SELECT MAX(id) FROM movies));

INSERT INTO users (id, name, lastname, email, password, phone, role_id)
VALUES
(1, 'Admin', 'Principal', 'admin@demo.com', '$2b$10$l6NCUpt60LE9temlqfXlHuOEc0WNoXbLsCkKVaVkmAvnJWRqGKTy6', '1234567890', 1),
(2, 'Pedro', 'Temerario', 'pedro@demo.com', '$2b$10$iOuClrsmUhELuN4LutaR.O72ClUW1DllmI7Ns3xDlc/pi8IXcbEhu', '0987654321', 2);

SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));

CREATE TABLE IF NOT EXISTS user_favorites (
  id_user INT REFERENCES users(id),
  id_movie INT REFERENCES movies(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_user, id_movie)
);
-- Audit log table
CREATE TABLE IF NOT EXISTS user_activity_log (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255),
    login_time TIMESTAMP,
    logout_time TIMESTAMP,
    browser VARCHAR(255),
    ip_address VARCHAR(50),
    machine_name VARCHAR(255),
    table_name VARCHAR(255),
    action_type VARCHAR(50),
    description TEXT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Function to insert into audit log
CREATE OR REPLACE FUNCTION log_table_action() RETURNS TRIGGER AS $$
DECLARE
    v_username VARCHAR(255);
    v_browser VARCHAR(255);
    v_ip VARCHAR(50);
    v_machine VARCHAR(255);
    v_desc TEXT;
    v_table VARCHAR(255);
BEGIN
    v_username := current_setting('app.username', true);
    v_browser := current_setting('app.browser', true);
    v_ip := current_setting('app.ip', true);
    v_machine := current_setting('app.machine', true);
    v_table := TG_TABLE_NAME;

    IF v_table = 'user_favorites' THEN
        IF TG_OP = 'INSERT' THEN
            v_desc := 'Inserted favorite: id_user=' || NEW.id_user || ', id_movie=' || NEW.id_movie;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'INSERT', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            v_desc := 'Deleted favorite: id_user=' || OLD.id_user || ', id_movie=' || OLD.id_movie;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'DELETE', v_desc);
            RETURN OLD;
        END IF;
    ELSIF v_table = 'movies' THEN
        IF TG_OP = 'INSERT' THEN
            v_desc := 'Inserted movie: id=' || NEW.id || ', title=' || NEW.title;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'INSERT', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            v_desc := 'Updated movie: id=' || NEW.id || ', title=' || NEW.title;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'UPDATE', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            v_desc := 'Deleted movie: id=' || OLD.id || ', title=' || OLD.title;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'DELETE', v_desc);
            RETURN OLD;
        END IF;
    ELSE
        IF TG_OP = 'INSERT' THEN
            v_desc := 'Inserted record with id=' || NEW.id;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'INSERT', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            v_desc := 'Updated record with id=' || NEW.id;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'UPDATE', v_desc);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            v_desc := 'Deleted record with id=' || OLD.id;
            INSERT INTO user_activity_log(username, browser, ip_address, machine_name, table_name, action_type, description)
            VALUES (v_username, v_browser, v_ip, v_machine, v_table, 'DELETE', v_desc);
            RETURN OLD;
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Attach triggers to all relevant tables
DROP TRIGGER IF EXISTS trg_log_user_favorites_action ON user_favorites;
CREATE TRIGGER trg_log_user_favorites_action
AFTER INSERT OR DELETE ON user_favorites
FOR EACH ROW EXECUTE FUNCTION log_table_action();

DROP TRIGGER IF EXISTS trg_log_movies_action ON movies;
CREATE TRIGGER trg_log_movies_action
AFTER INSERT OR UPDATE OR DELETE ON movies
FOR EACH ROW EXECUTE FUNCTION log_table_action();

DROP TRIGGER IF EXISTS trg_log_users_action ON users;
CREATE TRIGGER trg_log_users_action
AFTER INSERT OR UPDATE OR DELETE ON users
FOR EACH ROW EXECUTE FUNCTION log_table_action();
