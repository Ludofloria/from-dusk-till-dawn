DROP DATABASE IF EXISTS fdtd;
CREATE DATABASE fdtd;
USE fdtd;

create table cities (
  id int not null,
  name varchar(100),
  height int,
  width int,
  left_max int,
  right_max int,
  top_max int,
  bottom_max int,
  hardcore bit default false,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table zones (
  id bigint not null auto_increment,
  x int not null,
  y int not null,
  zombies int,
  scout_sense int default -1,
  visited bit default false,
  zone_depleted bit default false,
  building_depleted bit default false,
  blue_print_retrieved bit default false,
  scout_peek varchar(100),
  camping_topology varchar(15) not null default 'UNKNOWN',
  city_id bigint,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
create index idx_zones_city_x_y on zones (city_id,x,y);

create table items (
  id bigint not null auto_increment,
  amount int,
  broken bit default false,
  d2n_item_id int,
  zone_id bigint,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table unique_items (
  id int not null,
  name varchar(100),
  image varchar(255),
  in_sprite bit default false,
  poisoned bit default false,
  preset_bp bit default false,
  breakable bit default false,
  category varchar(20),
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table users (
  id int not null auto_increment,
  city_id int not null,
  user_key varchar(50),
  name varchar(100),
  secure bit default false,
  shunned bit default false,
  banned bit default false,
  soul_points int default 0,
  game_id int default null,
  image varchar(255),
  description varchar(200),
  primary key(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
create index idx_users_user_key on users (user_key);
create index idx_users_name on users (name);
create index idx_users_game_id on users (game_id);

create table user_activity (
  id int not null auto_increment,
  action varchar(20) not null,
  updated datetime not null,
  zone_id bigint,
  user_id bigint not null,
  city_id bigint not null,
  day int not null,
  primary key(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
create index idx_user_activity_updated on user_activity(updated);
create index idx_user_activity_city_user_updated on user_activity (city_id, user_id, updated);

create table unique_outside_buildings (
  id int not null,
  name varchar(100) not null,
  flavor varchar(1024),
  url varchar(200),
  primary key(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table unique_inside_buildings (
  id int not null,
  name varchar(100) not null,
  temporary bit default false,
  parent int,
  image varchar(255),
  in_sprite bit default false,
  always_available bit default false,
  flavor varchar(1024),
  url varchar(200),
  primary key(id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table last_user_activity (
  zone_id bigint not null,
  user_activity_id int not null
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table inside_buildings (
  id int not null auto_increment,
  status varchar(20),
  unique_inside_building_id int not null,
  city_id int not null,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table unique_distinctions (
  id int not null auto_increment,
  name varchar(40) not null,
  rare bit default false,
  image varchar(255) not null,
  in_sprite bit default false,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table unique_titles (
  id int not null auto_increment,
  name varchar(80) not null,
  unique_distinction_id int not null,
  treshold int,
  twinoid_points double,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

create table distinctions (
  id int not null auto_increment,
  user_id int not null,
  unique_distinction_id int not null,
  amount int,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
create index idx_distinctions_amount on distinctions (amount);

create table rooms (
  id int not null auto_increment,
  zone_id bigint not null,
  x int not null,
  y int not null,
  door varchar(8) not null default 'NONE',
  door_key varchar(15) not null default 'UNKNOWN',
  zombies int not null,
  corridor_west bit default false,
  corridor_north bit default false,
  corridor_east bit default false,
  corridor_south bit default false,
  primary key (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
create index idx_rooms_zone_x_y on rooms(zone_id, x, y);
insert into unique_items (id, image, name, category) values (2,'pile','Battery','RESOURCES');
insert into unique_items (id, image, name, category) values (40,'courroie','Belt','RESOURCES');
insert into unique_items (id, image, name, category) values (165,'electro_box','Broken Electronic Device','RESOURCES');
insert into unique_items (id, image, name, category) values (132,'deto','Compact Detonator','RESOURCES');
insert into unique_items (id, image, name, category) values (84,'tube','Copper Pipe','RESOURCES');
insert into unique_items (id, image, name, category) values (81,'rustine','Duct Tape','RESOURCES');
insert into unique_items (id, image, name, category) values (101,'electro','Electronic component','RESOURCES');
insert into unique_items (id, image, name, category) values (41,'meca_parts','Handful of nuts and bolts','RESOURCES');
insert into unique_items (id, image, name, category) values (168,'mecanism','Mechanism','RESOURCES');
insert into unique_items (id, image, name, category) values (160,'metal_beam','Metal Support','RESOURCES');
insert into unique_items (id, image, name, category) values (159,'wood_beam','Patchwork Beam','RESOURCES');
insert into unique_items (id, image, name, category) values (162,'wood_bad','Rotting Log','RESOURCES');
insert into unique_items (id, image, name, category) values (161,'metal_bad','Scrap Metal','RESOURCES');
insert into unique_items (id, image, name, category) values (73,'explo','Semtex','RESOURCES');
insert into unique_items (id, image, name, category) values (59,'wood2','Twisted Plank','RESOURCES');
insert into unique_items (id, image, name, category) values (60,'metal','Wrought Iron','RESOURCES');
insert into unique_items (id, image, name, category) values (13,'wrench','Adjustable Spanner','ARMOURY');
insert into unique_items (id, image, name, category) values (114,'watergun_opt_1','Aqua-Splash (1 shot)','ARMOURY');
insert into unique_items (id, image, name, category) values (113,'watergun_opt_2','Aqua-Splash (2 shots)','ARMOURY');
insert into unique_items (id, image, name, category) values (112,'watergun_opt_3','Aqua-Splash (3 shots)','ARMOURY');
insert into unique_items (id, image, name, category) values (208,'watergun_opt_5','Aqua-Splash (5 shots)','ARMOURY');
insert into unique_items (id, image, name, category) values (8,'watergun_opt_empty','Aqua-Splash (empty)','ARMOURY');
insert into unique_items (id, image, name, category) values (117,'pilegun_empty','Battery Launcher 1-ITF (empty)','ARMOURY');
insert into unique_items (id, image, name, category) values (5,'pilegun','Battery Launcher 1-ITF (loaded)','ARMOURY');
insert into unique_items (id, image, name, category) values (212,'pilegun_up_empty','Battery Launcher Mk. II (empty)','ARMOURY');
insert into unique_items (id, image, name, category) values (213,'pilegun_up','Battery Launcher Mk. II (loaded)','ARMOURY');
insert into unique_items (id, image, name, category) values (20,'cutter','Box Cutter','ARMOURY');
insert into unique_items (id, image, name, category) values (158,'bone','Broken Human Bone','ARMOURY');
insert into unique_items (id, image, name, category) values (234,'torch_off','Burnt out Torch','ARMOURY');
insert into unique_items (id, image, name, category) values (23,'can_opener','Can Opener','ARMOURY');
insert into unique_items (id, image, name, category) values (116,'chainsaw_empty','Chainsaw (incomplete)','ARMOURY');
insert into unique_items (id, image, name, category) values (10,'chainsaw','Chainsaw (loaded)','ARMOURY');
insert into unique_items (id, image, name, category) values (122,'big_pgun_empty','Devastator (empty)','ARMOURY');
insert into unique_items (id, image, name, category) values (123,'big_pgun','Devastator (loaded)','ARMOURY');
insert into unique_items (id, image, name, category) values (9,'mixergun','Electric Whisk (charged)','ARMOURY');
insert into unique_items (id, image, name, category) values (115,'mixergun_empty','Electric Whisk (incomplete)','ARMOURY');
insert into unique_items (id, image, name, category) values (313,'boomfruit','Exploding Grapefruit','ARMOURY');
insert into unique_items (id, image, name, category) values (77,'bgrenade','Exploding Water Bomb','ARMOURY');
insert into unique_items (id, image, name, category) values (127,'jerrygun','Jerrycan Gun (ready)','ARMOURY');
insert into unique_items (id, image, name, category) values (70,'jerrygun_off','Jerrycan Pump (empty)','ARMOURY');
insert into unique_items (id, image, name, category) values (11,'lawn','Lawnmower','ARMOURY');
insert into unique_items (id, image, name, category) values (17,'cutcut','Machete','ARMOURY');
insert into unique_items (id, image, name, category) values (286,'iphone','Mobile Phone','ARMOURY');
insert into unique_items (id, image, name, category) values (18,'small_knife','Pathetic Penknife','ARMOURY');
insert into unique_items (id, image, name, category) values (76,'grenade_empty','Plastic Bag','ARMOURY');
insert into unique_items (id, image, name, category) values (78,'bgrenade_empty','Plastic Bag and Semtex','ARMOURY');
insert into unique_items (id, image, name, category) values (196,'chain','Rusty Chain','ARMOURY');
insert into unique_items (id, image, name, category) values (14,'screw','Screwdriver','ARMOURY');
insert into unique_items (id, image, name, category) values (16,'knife','Serrated Knife','ARMOURY');
insert into unique_items (id, image, name, category) values (15,'staff','Staff','ARMOURY');
insert into unique_items (id, image, name, category) values (19,'swiss_knife','Swiss Army Knife','ARMOURY');
insert into unique_items (id, image, name, category) values (7,'taser','Taser','ARMOURY');
insert into unique_items (id, image, name, category) values (118,'taser_empty','Taser (incomplete)','ARMOURY');
insert into unique_items (id, image, name, category) values (62,'grenade','Water Bomb','ARMOURY');
insert into unique_items (id, image, name, category) values (207,'watergun_1','Water Pistol (1 shot)','ARMOURY');
insert into unique_items (id, image, name, category) values (206,'watergun_2','Water Pistol (2 shots)','ARMOURY');
insert into unique_items (id, image, name, category) values (205,'watergun_3','Water Pistol (3 shots)','ARMOURY');
insert into unique_items (id, image, name, category) values (111,'watergun_empty','Water Pistol (empty)','ARMOURY');
insert into unique_items (id, image, name, category) values (309,'bplan_box','Architect\'s Chest','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (152,'game_box','Box of Games','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (90,'chest','Chest','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (102,'chest_citizen','Citizen\'s Welcome Pack','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (217,'rsc_pack_1','Construction Kit','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (216,'rsc_pack_2','Construction Kit','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (215,'rsc_pack_3','Construction Kit','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (202,'book_gen_letter','Envelope','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (227,'postal_box','Gift Parcel','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (91,'chest_xl','Large Chest','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (229,'food_armag','Lunch Box','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (25,'bag','Manbag','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (203,'book_gen_box','Parcel','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (243,'safe','Safe','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (310,'bplan_box_e','Sealed Architect\'s Chest','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (22,'cart','Shopping Trolley','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (92,'chest_tools','Toolbox','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (88,'pocket_belt','Utility belt','CONTAINERS_AND_BOXES');
insert into unique_items (id, image, name, category) values (218,'car_door','Car Door','DEFENSES');
insert into unique_items (id, image, name, category) values (45,'pet_dog','Guard Dog','DEFENSES');
insert into unique_items (id, image, name, category) values (170,'table','Järpen Table','DEFENSES');
insert into unique_items (id, image, name, category) values (31,'bed','Mattress','DEFENSES');
insert into unique_items (id, image, name, category) values (107,'door','Old Door','DEFENSES');
insert into unique_items (id, image, name, category) values (64,'plate','Sheet Metal','DEFENSES');
insert into unique_items (id, image, name, category) values (179,'wood_plate','Solid Wooden Board','DEFENSES');
insert into unique_items (id, image, name, category) values (233,'torch','Torch','DEFENSES');
insert into unique_items (id, image, name, category) values (169,'trestle','Trestle','DEFENSES');
insert into unique_items (id, image, name, category) values (134,'concrete_wall','Unshaped Concrete Blocks','DEFENSES');
insert into unique_items (id, image, name, category) values (98,'coffee','Bloody hot coffee','FOOD');
insert into unique_items (id, image, name, category) values (236,'chama_tasty','Burnt Marshmallows','FOOD');
insert into unique_items (id, image, name, category) values (3,'can','Can','FOOD');
insert into unique_items (id, image, name, category) values (148,'food_noodles','Chinese Noodles','FOOD');
insert into unique_items (id, image, name, category) values (197,'dish','Dodgy Homemade Dish','FOOD');
insert into unique_items (id, image, name, category) values (139,'food_bag','Doggy Bag','FOOD');
insert into unique_items (id, image, name, category) values (142,'food_bar3','Dried Chewing Gum','FOOD');
insert into unique_items (id, image, name, category) values (235,'chama','Dried Marshmallows','FOOD');
insert into unique_items (id, image, name, category) values (311,'egg','Egg','FOOD');
insert into unique_items (id, image, name, category) values (260,'fruit','Fleshroom Puree','FOOD');
insert into unique_items (id, image, name, category) values (138,'chest_food','Food Parcel','FOOD');
insert into unique_items (id, image, name, category) values (144,'food_chick','Half-eaten Chicken Wings','FOOD');
insert into unique_items (id, image, name, category) values (230,'food_candies','Handful of Sweets','FOOD');
insert into unique_items (id, image, name, category) values (74,'hmeat','Human Flesh','FOOD');
insert into unique_items (id, image, name, category) values (172,'vegetable_tasty','Intestine Melon','FOOD');
insert into unique_items (id, image, name, category) values (157,'bone_meat','Meaty Bone','FOOD');
insert into unique_items (id, image, name, category) values (147,'food_sandw','Mouldy Ham Sandwich','FOOD');
insert into unique_items (id, image, name, category) values (141,'food_bar2','Mouldy Neapolitan','FOOD');
insert into unique_items (id, image, name, category) values (224,'can_open','Open Can','FOOD');
insert into unique_items (id, image, name, category) values (4,'can_open','Open Can','FOOD');
insert into unique_items (id, image, name, category) values (145,'food_pims','Out-of-Date Biscuits','FOOD');
insert into unique_items (id, image, name, category) values (140,'food_bar1','Packet of Soft Crisps','FOOD');
insert into unique_items (id, image, name, category) values (264,'water_cup','Purified Stagnant Water','FOOD');
insert into unique_items (id, image, name, category) values (143,'food_biscuit','Rancid Jaffa Cakes','FOOD');
insert into unique_items (id, image, name, category) values (281,'woodsteak','SawdustSteak','FOOD');
insert into unique_items (id, image, name, category) values (150,'food_noodles_hot','Spicy Chinese Noodles','FOOD');
insert into unique_items (id, image, name, category) values (146,'food_tarte','Stale Tart','FOOD');
insert into unique_items (id, image, name, category) values (108,'vegetable','Suspicious-looking Vegetable','FOOD');
insert into unique_items (id, image, name, category) values (198,'dish_tasty','Tasty Homemade Dish','FOOD');
insert into unique_items (id, image, name, category) values (52,'meat','Tasty-looking Steak','FOOD');
insert into unique_items (id, image, name, category) values (53,'undef','Unspecified Meat','FOOD');
insert into unique_items (id, image, name, category) values (69,'vodka','Vodka Marinostov','FOOD');
insert into unique_items (id, image, name, category) values (97,'rhum','\'Wake The Dead\'','FOOD');
insert into unique_items (id, image, name, category) values (246,'water_can_1','Water Cooler Bottle (1 ration)','FOOD');
insert into unique_items (id, image, name, category) values (247,'water_can_2','Water Cooler Bottle (2 rations)','FOOD');
insert into unique_items (id, image, name, category) values (248,'water_can_3','Water Cooler Bottle (3 rations)','FOOD');
insert into unique_items (id, image, name, category) values (1,'water','Water Ration','FOOD');
insert into unique_items (id, image, name, category) values (222,'water','Water Ration','FOOD');
insert into unique_items (id, image, name, category) values (32,'lamp','Bedside Lamp (off)','FURNITURE');
insert into unique_items (id, image, name, category) values (93,'lamp_on','Bedside Lamp (on)','FURNITURE');
insert into unique_items (id, image, name, category) values (188,'machine_3','Beer Fridge','FURNITURE');
insert into unique_items (id, image, name, category) values (200,'home_box','Boxes','FURNITURE');
insert into unique_items (id, image, name, category) values (99,'coffee_machine','Cafetière','FURNITURE');
insert into unique_items (id, image, name, category) values (187,'machine_2','Carcinogenic Oven','FURNITURE');
insert into unique_items (id, image, name, category) values (36,'door_carpet','Doormat','FURNITURE');
insert into unique_items (id, image, name, category) values (128,'chair_basic','Ektorp-Gluten Chair','FURNITURE');
insert into unique_items (id, image, name, category) values (46,'pet_cat','Fat Cat','FURNITURE');
insert into unique_items (id, image, name, category) values (199,'home_box_xl','Iron Chest','FURNITURE');
insert into unique_items (id, image, name, category) values (130,'machine_gun','Machine Gun (empty)','FURNITURE');
insert into unique_items (id, image, name, category) values (201,'home_def','Makeshift Barricade','FURNITURE');
insert into unique_items (id, image, name, category) values (34,'music_part','Mini HI-Fi (Broken)','FURNITURE');
insert into unique_items (id, image, name, category) values (94,'music','Mini HiFi (on)','FURNITURE');
insert into unique_items (id, image, name, category) values (186,'machine_1','Old Washing Machine','FURNITURE');
insert into unique_items (id, image, name, category) values (35,'lock','Padlock and Chain','FURNITURE');
insert into unique_items (id, image, name, category) values (242,'pc','PC Base Unit','FURNITURE');
insert into unique_items (id, image, name, category) values (33,'carpet','Persian Rug','FURNITURE');
insert into unique_items (id, image, name, category) values (164,'wood_log','Quality Log','FURNITURE');
insert into unique_items (id, image, name, category) values (105,'radio_on','Radio Cassette Player ','FURNITURE');
insert into unique_items (id, image, name, category) values (129,'gun','Revolver (empty)','FURNITURE');
insert into unique_items (id, image, name, category) values (29,'chair','Rocking Chair','FURNITURE');
insert into unique_items (id, image, name, category) values (180,'money','Wad of Cash','FURNITURE');
insert into unique_items (id, image, name, category) values (204,'fence','Wire Mesh','FURNITURE');
insert into unique_items (id, image, name, category) values (51,'drug','Anabolic Steroids','PHARMACY');
insert into unique_items (id, image, name, category) values (223,'drug','Anabolic Steroids','PHARMACY');
insert into unique_items (id, image, name, category) values (66,'bandage','Bandage','PHARMACY');
insert into unique_items (id, image, name, category) values (250,'beta_drug_bad','Betapropine 5mg (expired)','PHARMACY');
insert into unique_items (id, image, name, category) values (106,'cyanure','Cyanide','PHARMACY');
insert into unique_items (id, image, name, category) values (103,'drug_water','Hydratone 100mg','PHARMACY');
insert into unique_items (id, image, name, category) values (136,'disinfect','Paracetoid 7g','PHARMACY');
insert into unique_items (id, image, name, category) values (95,'pharma','Pharmaceutical Products','PHARMACY');
insert into unique_items (id, image, name, category) values (259,'pharma_part','Thick Solution','PHARMACY');
insert into unique_items (id, image, name, category) values (89,'drug_hero','Twinoid 500mg','PHARMACY');
insert into unique_items (id, image, name, category) values (135,'drug_random','Unlabelled Drug','PHARMACY');
insert into unique_items (id, image, name, category) values (28,'xanax','Valium Shot','PHARMACY');
insert into unique_items (id, image, name, category) values (171,'water_cleaner','Water Purifying Tablets','PHARMACY');
insert into unique_items (id, image, name, category) values (153,'watergun_opt_part','Aqua-Splash (incomplete)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (133,'concrete','Bag of Cement','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (48,'vibr','Big Rubber D*** (charged)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (154,'vibr_empty','Big Rubber D*** (incomplete)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (26,'lights','Box of Matches','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (167,'saw_tool_part','Broken Hacksaw','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (219,'car_door_part','Car Door (incomplete)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (42,'pet_chick','Chicken','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (305,'bplan_c','Construction Blueprint (common)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (307,'bplan_r','Construction Blueprint (rare)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (306,'bplan_u','Construction Blueprint (uncommon)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (221,'poison_part','Corrosive Liquid','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (178,'wood_plate_part','Crate Lid','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (214,'pile_broken','Crushed Battery','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (124,'big_pgun_part','Devastator (incomplete)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (38,'dice','Dice','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (82,'lawn_part','Dismantled Mower','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (120,'sport_elec','EMS System (charged)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (119,'sport_elec_empty','EMS System (incomplete)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (39,'engine','Engine','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (185,'engine_part','Engine (incomplete)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (287,'smelly_meat','Festering Flesh','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (174,'flash','Flash Grenade','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (173,'powder','Flash Powder','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (166,'deco_box','Flatpacked Furniture','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (252,'fruit_sub_part','Fleshrooms','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (58,'jerrycan','Full Jerrycan','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (44,'pet_rat','Giant Rat','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (258,'flesh','Grisly Bomb','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (54,'sheet','Groundsheet','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (163,'saw_tool','Hacksaw','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (47,'pet_snake','Huge Snake (Ophiophagus trouser)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (100,'coffee_machine_part','Incomplete Cafetière','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (79,'chainsaw_part','Incomplete Chainsaw','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (151,'cards','Incomplete Deck of Cards','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (80,'mixergun_part','Incomplete Whisk','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (191,'rp_manual','Instruction Manual','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (65,'jerrygun_part','Jerrycan Pump (unattached)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (184,'repair_one','Kwik-Fix','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (192,'rp_scroll','Label','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (137,'digger','Ness-Quick Weedkiller','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (210,'cigs','Opened packet of Cigarettes','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (299,'smoke_bomb','« Pine Fresh » Smoke Bomb','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (257,'flesh_part','Pound of Flesh','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (211,'pilegun_upkit','PUTA Mark II Calibrator','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (104,'radio_off','Radio Cassette Player (no battery)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (183,'radius_mk2','Radius Mark II','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (182,'radius_mk2_part','Radius Mark II (incomplete)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (125,'tagger','Radius Radar Beacon','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (110,'repair_kit','Repair Kit','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (109,'repair_kit_part','Repair Kit (damaged)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (96,'plate_raw','Sheet Metal (parts)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (231,'out_def','Sheet of Plywood','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (263,'water_cup_part','Stagnant Water Can','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (253,'fruit_part','Sticky Pastry Ball','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (43,'pet_pig','Stinking Pig','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (149,'spices','Strong Spices','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (181,'repair_kit_part_raw','Tool Bag','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (220,'poison','Vial of Poison','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (245,'water_can_empty','Water Cooler Bottle (empty)','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (85,'cart_part','Wonky Shopping Trolley','MISCELLANEOUS');
insert into unique_items (id, image, name, category) values (314,'bplan_drop','Worn Leather Bag','MISCELLANEOUS');
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Abandoned_Construction_Site" where name="Abandoned Construction Site";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Abandoned_Park" where name="Abandoned Park";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Abandoned_Supermarket" where name="Abandoned Supermarket";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Abandoned_Well" where name="Abandonned Well";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Army_Outpost" where name="Army Outpost";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Ambulance" where name="Ambulance";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Blocked_Road" where name="Blocked Road";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Broken-down_Tank" where name="Broken-down Tank";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Burnt_School" where name="Burnt School";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Cave" where name="Cave";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Citizen.27s_Home" where name="Citizen's Home";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Citizen.27s_Tent" where name="Citizen's Tent";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Collapsed_Mineshaft" where name="Collapsed Mineshaft";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Collapsed_Quarry" where name="Collapsed Quarry";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Construction_Site_Shelter" where name="Construction Site Shelter";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Cosmetics_Lab" where name="Cosmetics Lab";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Dark_Woods" where name="Dark Woods";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Derelict_Villa" where name="Derelict Villa";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Deserted_Freight_Yard" where name="Deserted Freight Yard";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Destroyed_Pharmacy" where name="Destroyed Pharmacy";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Dilapidated_Building" where name="Dilapidated Building";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Disused_Car_Park" where name="Disused Car Park";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Disused_Silos" where name="Disused Silos";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Disused_Warehouse" where name="Disused Warehouse";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Duke.27s_Villa" where name="Duke's Villa";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Equipped_Trench" where name="Equipped Trench";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Fairground_Stall" where name="Fairground Stall";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Family_Tomb" where name="Family Tomb";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Fast_Food_Restaurant" where name="Fast Food Restaurant";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Fraser_D.27s_Kebab-ish" where name="Fraser D's Kebab-ish";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Garden_Shed" where name="Garden Shed";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Guns_.27n.27_Zombies_Armoury" where name="Guns 'n' Zombies Armoury";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Home_Depot" where name="Home Depot";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Indian_Burial_Ground" where name="Indian Burial Ground";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Looted_Supermarket" where name="Looted Supermarket";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Mac.27s_Atomic_Cafe" where name="Mac's Atomic Cafe";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#The_.27Mayor_Mobile.27" where name=" The 'Mayor-Mobile'";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Mini-Market" where name="Mini-Market";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Motel_666.EF.BF.BD_Dusk" where id=51;
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Motorway_Services" where name="Motorway Services";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Nuclear_Bunker" where name="Nuclear Bunker";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Old_Aerodome" where id=48;
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Old_Bicycle_Hire_Shop" where name="Old Bicycle Hire Shop";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Old_Field_Hospital" where name="Old Field Hospital";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Old_Hydraulic_Pump" where name="Old Hydraulic Pump";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Old_Police_Station" where name="Old Police Station";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Old_Water_Processing_Plant" where name="Old Water Processing Plant";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Once-Inhabited_Cave" where name="Once-Inhabited Cave";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#PI-KEYA_Furniture" where name="PI-KEYA Furniture";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Plane_Crash_Site" where name="Plane Crash Site";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Post_Office" where name="Post Office";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Scottish_Smith.27s_Superstore" where name="Scottish Smith's Superstore";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Shady_Bar" where name="Shady Bar";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Small_House" where name="Small House";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Smugglers.27_Cache" where name="Smugglers' Cache";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Town_Library" where name="Town Library";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Warehouse" where name="Warehouse";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Water_Processing_Plant" where name="Water Processing Plant";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Wrecked_Cars" where name="Wrecked Cars";
update unique_outside_buildings set url="http://die2nitewiki.com/wiki/Ruins#Wrecked_Transporter" where name="Wrecked Transporter";
update unique_outside_buildings set url='http://die2nitewiki.com/wiki/Abandoned_Bunker' where id=100;
update unique_outside_buildings set url='http://die2nitewiki.com/wiki/Abandoned_Hotel' where id=101;
update unique_outside_buildings set url='http://die2nitewiki.com/wiki/Abandoned_Hospital' where id=102;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Wall_Upgrade_v1' where id=1010;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Great_Pit' where id=1023;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Spiked_Pit' where id=1027;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Great_Moat' where id=1041;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Grater' where id=1024;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Barbed_Wire' where id=1028;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Bait' where id=1066;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Wall_Upgrade_v2' where id=1031;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Reinforcing_Beams' where id=1036;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Spiked_Wall' where id=1037;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/%C3%9Cber_Wall' where id=1056;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Interior_Wall' where id=1070;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Evolutive_Wall' where id=1071;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Concrete_Reinforcement' where id=1158;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Zombie_Grater' where id=1054;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Old-school_traps' where id=1055;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Wooden_Fencing' where id=1058;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Small_Fence' where id=1156;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Slip_%27N%27_Slide' where id=1159;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Vaporiser' where id=1160;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Armour_Plating' where id=1163;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Armour_Plating_v2' where id=1164;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Armour_Plating_v3' where id=1165;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Plywood' where id=1166;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Extra_Wall' where id=1167;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Pump' where id=1011;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Water_Purifier' where id=1020;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Mines' where id=1032;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Water_Filter' where id=1143;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Vegetable_Plot' where id=1026;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Grapeboom' where id=1144;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Drilling_Rig' where id=1029;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Eden_Project' where id=1030;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Workshop_(Hydraulic_Network)' where id=1060;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Pressure_Washer' where id=1039;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Saniflo_Macerator' where id=1040;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Automatic_Sprinklers' where id=1059;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Shower' where id=1149;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Water_Turrets' where id=1073;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Water_Catcher' where id=1141;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Mist_Spray' where id=1142;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Sluice' where id=1150;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Decon_Shower' where id=1151;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Divining_Rocket' where id=1152;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Divining_Rods' where id=1153;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Workshop' where id=1033;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Butcher' where id=1021;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Cremato-Cue' where id=1045;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Defensive_Focus' where id=1025;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Cannon_Mounds' where id=1046;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Rock_Cannon' where id=1043;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Railgun' where id=1047;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Plate_Gun' where id=1048;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/War_Mill' where id=1049;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Brutal_Cannon' where id=1100;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Small_Factory' where id=1065;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Screaming_Saws' where id=1067;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Building_Registry' where id=1075;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Architect%27s_Study' where id=1101;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Gallows' where id=1076;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Abbatoir' where id=1102;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Small_Caf%C3%A9' where id=1104;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Small_Cemetary' where id=1105;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Henhouse' where id=1109;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Community_Involvement' where id=1112;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Watchtower' where id=1050;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Upgraded_Map' where id=1042;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Catapult' where id=1015;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Calibrated_Catapult' where id=1077;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Search_Tower' where id=1072;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Scanner' where id=1035;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Predictor' where id=1064;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Emergency_Supplies' where id=1074;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Spikes' where id=1013;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Guerilla_Traps' where id=1014;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Wood_Plating' where id=1012;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Garbage_Heap' where id=1019;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Mount_Killaman-jaro' where id=1022;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Bomb_Factory' where id=1068;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Pits' where id=1044;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Abject_Panic' where id=1168;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Frat_House' where id=1169;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Guerilla_Tactics' where id=1014;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Baited_Trap' where id=1044;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Spike_Trap' where id=1013;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Guard_Tower' where id=1170;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Crows%27_Nest' where id=1171;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Foundations' where id=1051;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Mechanical_Pump' where id=1053;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Faucet' where id=1061;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Scarecrows' where id=1113;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Garbage_Dump' where id=1114;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Wood_Dump' where id=1119;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Metal_Dump' where id=1120;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Free_Dump' where id=1172;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Animal_Dump' where id=1123;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Lighthouse' where id=1124;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Bonfire' where id=1126;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/False_Town' where id=1057;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Labyrinth' where id=1132;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/The_Big_Rebuild' where id=1052;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Meat_Locker' where id=1122;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Fortifications' where id=1125;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Reactor' where id=1173;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Giant_Sandcastle' where id=1140;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/All_or_Nothing' where id=1133;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Ministry_of_Slavery' where id=1128;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Giant_BRD' where id=1137;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Altar' where id=1136;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Portal_Lock' where id=1062;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Automatic_Piston_Lock' where id=1034;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Reinforced_Gates' where id=1069;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Ventilation_System' where id=1155;
update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Wall_Upgrade_v1' where id=1010;

#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Pump' where id=1011;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Butcher' where id=1021;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Great_Pit' where id=1023;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Workshop' where id=1033;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Watchtower' where id=1050;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Foundations' where id=1051;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Searchtower' where id=1072;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Building_Registry' where id=1075;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Architect%27s_Study' where id=1101;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Small_Cemetary' where id=1105;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Fertilizer' where id=1145;
#update unique_inside_buildings set url='http://die2nitewiki.com/wiki/Armour_Plating' where id=1163;
