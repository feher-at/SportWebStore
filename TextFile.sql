DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS type_item_tag;
DROP TABLE IF EXISTS brand_item_tag;
DROP TABLE IF EXISTS item_main_tag;
DROP TABLE IF EXISTS opinion;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS type_tag;
DROP TABLE IF EXISTS brand_tag;
DROP TABLE IF EXISTS main_tag;
DROP FUNCTION update_item_rating(integer,Decimal);

CREATE TABLE users(
userID SERIAL PRIMARY KEY,
username TEXT NOT NULL,
user_password TEXT NOT NULL,
email TEXT NOT NULL,
user_role TEXT NOT NULL
);

Create TABLE main_tag(
main_tagID SERIAL PRIMARY KEY,
main_tag_name TEXT
);




CREATE TABLE items(
itemID SERIAL PRIMARY KEY,
item_source TEXT, 
item_price INT,
item_description TEXT,
item_type TEXT,
item_colour TEXT,
rating DECIMAL(3,1)
);

CREATE TABLE opinion(
opinionID SERIAL PRIMARY KEY,
userID INT REFERENCES users(userID) ON DELETE CASCADE,
opinion TEXT NOT NULL,
the_user_rating INT,
post_time TIMESTAMP NOT NULL,
itemID INT REFERENCES items(itemID) ON DELETE CASCADE
);

CREATE TABLE cart(
cartID SERIAL PRIMARY KEY,
userID INT REFERENCES users(userID) ON DELETE CASCADE,
itemID INT REFERENCES items(itemID) ON DELETE CASCADE
);

CREATE TABLE brand_tag(
brand_tagID SERIAL PRIMARY KEY,
brand_name TEXT
);

CREATE TABLE type_tag(
type_tagID SERIAL PRIMARY KEY,
types_name TEXT
);

CREATE TABLE brand_item_tag(
brand_item_tag_id SERIAL PRIMARY KEY,
itemID INT REFERENCES items(itemID) ON DELETE CASCADE,
brand_tagID INT REFERENCES brand_tag(brand_tagID) ON DELETE CASCADE
);


CREATE TABLE type_item_tag(
type_item_tag_id SERIAL PRIMARY KEY,
itemID INT REFERENCES items(itemID) ON DELETE CASCADE,
type_tagID INT REFERENCES type_tag(type_tagID) ON DELETE CASCADE
);

CREATE TABLE item_main_tag(
	item_main_tag_id SERIAL PRIMARY KEY,
	itemID INT REFERENCES items(itemID) ON DELETE CASCADE,
	main_tagID INT REFERENCES main_tag(main_tagID) ON DELETE CASCADE
);

CREATE TABLE activities(
    userid INT REFERENCES users(userid) ON DELETE CASCADE,
    activity TEXT NOT NULL,
    activity_time TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION update_item_rating(p_itemID INTEGER, p_rating real)	RETURNS VOID AS $$
DECLARE
	v_itemID INTEGER;
BEGIN
	 SELECT i.itemID FROM items AS i WHERE i.itemID = p_itemID INTO  v_itemID;
	 IF v_itemID <> p_itemID THEN
			RAISE EXCEPTION 'Not authorized' USING ERRCODE = 45000;
	END IF;
	UPDATE
		items
	SET
		rating = p_rating
	WHERE
		itemID = p_itemID;

END;
$$ LANGUAGE plpgsql;


INSERT INTO brand_tag(brand_name)
VALUES('Everleast');

INSERT INTO brand_tag(brand_name)
VALUES('Lonsdale');

INSERT INTO brand_tag(brand_name)
VALUES('Adidas');

INSERT INTO brand_tag(brand_name)
VALUES('Nike');

INSERT INTO brand_tag(brand_name)
VALUES('Puma');

INSERT INTO brand_tag(brand_name)
VALUES('Mizuno');

INSERT INTO brand_tag(brand_name)
VALUES('Asics');

INSERT INTO brand_tag(brand_name)
VALUES('Sondico');

INSERT INTO brand_tag(brand_name)
VALUES('Firetrap');

INSERT INTO brand_tag(brand_name)
VALUES('Hot_Tuna');

INSERT INTO brand_tag(brand_name)
VALUES('Gul');

INSERT INTO brand_tag(brand_name)
VALUES('Columbia');

INSERT INTO brand_tag(brand_name)
VALUES('Slazenger');

INSERT INTO brand_tag(brand_name)
VALUES('Karrimor');

INSERT INTO brand_tag(brand_name)
VALUES('Kappa');

INSERT INTO brand_tag(brand_name)
VALUES('La_Gear');

INSERT INTO brand_tag(brand_name)
VALUES('Lee_Cooper');

INSERT INTO brand_tag(brand_name)
VALUES('Pierre_cardin');

INSERT INTO brand_tag(brand_name)
VALUES('Gelert');

INSERT INTO brand_tag(brand_name)
VALUES('Spartan');

INSERT INTO type_tag(types_name) 
VALUES('Box');

INSERT INTO type_tag(types_name) 
VALUES('Footbal');

INSERT INTO type_tag(types_name) 
VALUES('Running');

INSERT INTO type_tag(types_name) 
VALUES('Tennis');

INSERT INTO type_tag(types_name) 
VALUES('Short');

INSERT INTO type_tag(types_name) 
VALUES('Swim');

INSERT INTO type_tag(types_name) 
VALUES('Longshort');

INSERT INTO type_tag(types_name) 
VALUES('Training');

INSERT INTO type_tag(types_name) 
VALUES('Shirts');

INSERT INTO type_tag(types_name) 
VALUES('Sweaters');

INSERT INTO type_tag(types_name) 
VALUES('Grapling');



INSERT INTO main_tag(main_tag_name) VALUES('Gloves');
INSERT INTO main_tag(main_tag_name) VALUES('Shoes');
INSERT INTO main_tag(main_tag_name) VALUES('Tops');
INSERT INTO main_tag(main_tag_name) VALUES('Trousers');

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Everleast_box_gloves.jpg',9202,'the world best gloves','box gloves','blue',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Everleast_marble_box_gloves.jpg',10232,'the world best gloves','box gloves','black/red',5);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Spartan_box_gloves.jpg',9255,'the world best gloves','box gloves','black/red',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Spartan_full_contact_box_gloves.jpg',8976,'the world best gloves','box gloves','black/red',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Everleast_training_gloves.jpg',9670,'the world best gloves','training gloves','blue',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Everleast_woman_training_gloves.jpg',9690,'the world best gloves','training gloves','pink',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Everleast_pro_sytle_gloves.jpg',9630,'the world best gloves','training gloves','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Spartan_training_gloves.jpg',6230,'the world best gloves','training gloves','red',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Gloves/Everleast_grapling_gloves.jpg',6230,'the world best gloves','grapling gloves','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Kappa_black_shirt.jpg',1570,'the world best shirt','man shirt','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Hot_Tuna_black_shirt.jpg',2380,'the world best shirt','man shirt','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Adidas_blue_shirt.jpg',5910,'the world best shirt','man shirt','navy/white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Nike_black_shirt.jpg',5515,'the world best shirt','man shirt','black/white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/La_Gear_woman_shirt.jpg',1718,'the world best shirt','woman shirt','grey',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Adidas_woman_shirt.jpg',7198,'the world best shirt','woman shirt','black/white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Lee_Cooper_sweater.jpg',3545,'the world best sweater','man sweater','black/white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Pierre_cardin_sweater.jpg',2798,'the world best sweater','man sweater','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Slazenger_blue_sweater.jpg',2738,'the world best sweater','man sweater','blue',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Karrimor_sweater.jpg',4111,'the world best sweater','man sweater','charcoal',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Gelert_woman_sweater.jpg',3121,'the world best sweater','man sweater','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Tops/Karrimor_purple_woman_sweater.jpg',3925,'the world best sweater','woman sweater','purple',4.9);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Sondico_black_shorts.jpg',2725,'the world best shorts','man shorts','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Adidas_black_short.jpg',5129,'the world best shorts','man shorts','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Adidas_jersey_shorts.jpg',9459,'the world best shorts','man shorts',' Navy/White',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Puma_woman_shorts.jpg',5555,'the world best shorts','woman shorts',' black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Nike_woman_black_shorts.jpg',7955,'the world best shorts','woman shorts',' black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Firetrap_swim_shorts.jpg',4398,'the world best swimming trunks','man swimming trunks','White/black',4.7);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Firetrap_blue_swim_shorts.jpg',4398,'the world best swimming trunks','man swimming trunks','darkblue',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Nike_swim_shorts.jpg',6919,'the world best swimming trunks','man swimming trunks','Brown',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Hot_Tuna_Woman_Swim_Shorts.jpg',2199,'the world best swimming trunks','woman swimming trunks','electric blue',4.5);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Gul_bikini.jpg',1965,'the world best bikini','bikini','white/black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Lonsdale_Longshort.jpg',4312,'the world best long shorts','man long shorts','Grey',4);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Columbia_longshort.jpg',10623,'the world best long shorts','man long shorts','carbon',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Adidas_training_pants.jpg',11005,'the world best training pants','man training pants','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Lonsdale_training_pants.jpg',4315,'the world best training pants','man training pants','grey',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Slazenger_training_pants.jpg',4375,'the world best training pants','man training pants','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Adidas_Woman_training_pants.jpg',13899,'the world best training pants','woman training pants','black/white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Karrimor_woman_training_pants.jpg',7899,'the world best training pants','woman training pants','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Trousers/Karrimor_brown_woman_training_pants.jpg',7949,'the world best training pants','woman training pants','brown',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Lonsdale_box_shoes.jpg',13454,'the world best box shoes','box shoes','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Lonsdale_box_boots.jpg',15639,'the world best box boots','box boots','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Lonsdale_white_box_shoes.jpg',11239,'the world best box shoes','box shoes','white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Adidas_box_boots.jpg',18000,'the world best box boots','box boots','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Adidas_footbal_shoes.jpg',11200,'the world best footbal shoes','footbal shoes','Grey/SolYellow',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Adidas_predator_footbal_shoes.jpg',15834,'the world best footbal shoes','footbal shoes','black',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Adidas_predatorex_footbal_shoes.jpg',57367,'the world best footbal shoes','footbal shoes','black/white/red',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Nike_indoor_footbal_shoes.jpg',37210,'the world best indoor footbal shoes','indoor footbal shoes','black/orange',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Nike_Vision_footbal_shoes.jpg',77100,'the world best indoor footbal shoes','indoor footbal shoes','white/black-laser crimson',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Puma_footbal_shoes.jpg',25555,'the world best footbal shoes','footbal shoes','Navy/Silver',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Puma_future_footbal_shoes.jpg',25055,'the world best footbal shoes','footbal shoes','RedBlast/Blue',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Adidas_brown_running_shoes.jpg',15465,'the world best running shoes','running shoes','Sand',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Nike_woman_running_shoes.jpg',34795,'the world best running shoes','woman running shoes','Black/Pink',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Puma_woman_running_shoes.jpg',17735,'the world best running shoes','woman running shoes','Blue/purple',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Mizuno_woman_running_shoes.jpg',41421,'the world best running shoes','woman running shoes','Grey/white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Mizuno_running_shoes.jpg',37495,'the world best running shoes','running shoes','Black/silver',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Adidas_white_tennis_shoes.jpg',26600,'the world best tennis shoes','tennis shoes','white/green',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Asics_tennis_shoes.jpg',35991,'the world best tennis shoes','tennis shoes','Koi/white',0);

INSERT INTO items(item_source,item_price,item_description,item_type,item_colour,rating)
VALUES('/Pictures/Shoes/Asics_women_tennis_shoes.jpg',27650,'the world best tennis shoes','woman tennis shoes','white/Pink',0);


INSERT INTO item_main_tag(itemID,main_tagID) VALUES(1,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(2,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(3,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(4,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(5,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(6,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(7,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(8,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(9,1);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(10,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(11,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(12,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(13,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(14,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(15,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(16,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(17,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(18,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(19,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(20,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(21,3);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(22,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(23,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(25,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(26,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(27,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(28,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(29,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(30,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(31,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(32,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(33,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(34,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(35,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(36,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(37,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(38,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(39,4);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(40,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(41,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(42,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(43,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(44,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(45,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(46,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(47,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(48,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(49,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(50,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(51,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(52,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(53,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(54,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(55,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(56,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(57,2);
INSERT INTO item_main_tag(itemID,main_tagID) VALUES(58,2);



INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(1,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(2,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(3,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(4,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(5,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(6,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(7,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(8,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(9,11);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(10,9);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(11,9);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(12,9);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(13,9);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(14,9);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(15,9);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(16,10);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(17,10);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(18,10);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(19,10);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(20,10);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(21,10);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(22,5);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(23,5);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(24,5);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(25,5);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(26,5);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(27,6);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(28,6);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(29,6);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(30,6);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(31,6);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(32,7);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(33,7);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(34,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(35,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(36,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(37,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(38,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(39,8);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(40,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(41,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(42,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(43,1);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(44,2);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(45,2);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(46,2);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(47,2);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(48,2);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(49,2);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(50,2);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(51,3);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(52,3);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(53,3);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(54,3);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(55,3);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(56,4);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(57,4);

INSERT INTO type_item_tag(itemID,type_tagID)
VALUES(58,4);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(1,1);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(2,1);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(3,20);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(4,20);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(5,1);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(6,1);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(7,1);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(8,20);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(9,1);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(10,15);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(11,10);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(12,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(13,4);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(14,16);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(15,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(16,17);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(17,18);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(18,13);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(19,14);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(20,19);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(21,14);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(22,8);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(23,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(24,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(25,5);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(26,4);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(27,9);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(28,9);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(29,4);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(30,10);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(31,11);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(32,2);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(33,12);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(34,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(35,2);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(36,13);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(37,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(38,14);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(39,14);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(40,2);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(41,2);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(42,2);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(43,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(44,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(45,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(46,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(47,4);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(48,4);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(49,5);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(50,5);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(51,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(52,4);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(53,5);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(54,6);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(55,6);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(56,3);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(57,7);

INSERT INTO brand_item_tag(itemID,brand_tagID)
Values(58,7);

INSERT INTO users(username,user_password,email,user_role)
VALUES('Lakatos Bendzsó','616104ebd93e67ae20bac90c86483da3cae1ee5b1c1483f739372a88ff1e79f9','lockpicker@gmail.com','user');

INSERT INTO users(username,user_password,email,user_role)
VALUES('Admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','admin@gmail.com','admin');

INSERT INTO users(username,user_password,email,user_role)
VALUES('Pistike1234','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','pstike12@gmail.com','user');

INSERT INTO users(username,user_password,email,user_role)
VALUES('Tyron','645b23925ac42ce27b1a74d0592a46116caec133e7ee7f28006694d2507aec7f','Beast@gmail.com','user');

INSERT INTO users(username,user_password,email,user_role)
VALUES('Lajos','e77a630ab53310feb159c8d4e6597cec40e086bc1f178fedb10128d6435cc0d1','lajos@freemail.com','user');

INSERT INTO opinion(userID,opinion,the_user_rating,post_time,itemID)
VALUES(1,'This gloves is the best i can beat with it my brothers,and those who do not give me cigarettas to bus ticket,but it is hard to steal steel in it',4,'2018-4-15 16:10:10',1);

INSERT INTO opinion(userID,opinion,the_user_rating,post_time,itemID)
VALUES(5,'I hate this gloves,this is the worst,when i bought it,it said size L but my hand is also size L but when i put on my hands i feel like it is wobbling',2,'2018-4-15 16:10:10',1);

INSERT INTO opinion(userID,opinion,the_user_rating,post_time,itemID)
VALUES(4,'Whats up niggas?! I bought this bitch as nike shoes to flexing to my niggas,but that nigga Jerome stole it from me,so i here to tell you Jerome,GIVE BACK MY SHOES YO NIGGA',2,'2018-4-15 16:10:10',48);



