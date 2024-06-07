create database SweetH_Clothes_Store
go
use SweetH_Clothes_Store
go
create table items(
                      id int identity(1,1),
    [name] nvarchar(50) not null unique,
    primary key (id)
    )
create table categories(
                           id int identity(1,1),
    [name] nvarchar(50) not null unique,
    item_id int not null,
    primary key (id),
    foreign key (item_id) references items(id)
    )
create table products(
                         id int identity(1,1),
                         thumbnail_image varchar(max) not null,
	name nvarchar(255) not null unique,
	price decimal(10,2) not null,
	quantity int  not null,
	brand nvarchar(255),
	made_in nvarchar(255),
	color nvarchar(255),
	material nvarchar(255),
	description nvarchar(max) not null,
	category_id int not null,
	primary key (id),
	foreign key (category_id) references categories(id)
)
create table product_sizes(
                              id int identity(1,1),
                              size varchar(10) not null,
                              product_id int,
                              primary key (id),
                              foreign key (product_id) references products(id)
)
create table product_images(
                               id int identity(1,1),
                               image_url varchar(max) not null,
	product_id int,
	primary key (id),
	foreign key (product_id) references products(id)
)
create table accounts(
                         id int identity(1,1),
                         username varchar(50) not null unique,
    [password] varchar(50) not null,
    email varchar(100) not null unique,
    full_name nvarchar(100),
    phone nvarchar(10) not null unique,
    [address] nvarchar(500),
    [role] varchar(20) not null
    primary key (id)
)
create table favorites(
                          id int identity(1,1),
                          account_id int,
                          product_id int,
                          primary key (id),
                          foreign key (account_id) references accounts(id),
                          foreign key (product_id) references products(id)
)
create table feedbacks(
                          id int identity(1,1),
                          rate int not null,
                          content nvarchar(300),
                          create_date datetime,
    [status] bit DEFAULT 0,
                          account_id int,
                          product_id int,
                          primary key (id),
                          foreign key (account_id) references accounts(id),
                          foreign key (product_id) references products(id)
)
create table vouchers(
                         id int identity(1,1),
                         code varchar(10) not null unique,
                         discount_amount decimal(10,2) not null,
                         condition decimal(10,2) not null,
                         valid_form datetime not null,
                         valid_to datetime not null,
                         create_date datetime not null,
                         primary key(id)
)
create table orders(
                       id int identity(1,1),
                       order_date datetime not null,
                       total_amount decimal(10,2) not null,
    [status] nvarchar(100) not null,
    [address] nvarchar(500) not null,
    phone nvarchar(10),
    voucher_id int,
    account_id int,
    primary key(id),
    foreign key (account_id) references accounts(id),
    foreign key (voucher_id) references vouchers(id)
    )
create table order_details(
                              id int identity(1,1),
                              quantity int not null,
                              price decimal(10,2) not null,
                              order_id int,
                              product_id int,
                              primary key(id),
                              foreign key (order_id) references orders(id),
                              foreign key (product_id) references products(id)
)

    go

-- Insert into items
INSERT INTO items ([name]) VALUES
('Women'), ('Men'), ('Kids'), ('Curve'), ('Beachwear'), ('Sports & Outdoor'),
('Underwear & Sleepwear'), ('Shoes'), ('Accessories & Jewelry'), ('Bags & Luggage');

-- Insert into categories
INSERT INTO categories ([name], item_id) VALUES
                                             ('Maternity clothing', 1), ('Dresses', 1), ('Bottoms', 1), ('Wedding wear', 1), ('Co-ords', 1), ('Jumpsuits & bodysuits', 1), ('Jacket & coats', 1), ('Sweatshirts', 1),
                                             ('Plus size clothing', 2), ('Collection', 2), ('Hoodies & sweatshirts', 2), ('Suits & separates', 2), ('Sweaters', 2), ('Outerwear', 2), ('Swimwear', 2), ('Jumpsuites & overalls', 2),
                                             ('Socks & tights', 3), ('Family outfits', 3), ('Young girls (3-7 yrs)', 3), ('Tween girls (8-12 yrs)', 3), ('Teen girls (13-16 yrs)', 3), ('Young boys (3-7 yrs)', 3), ('Tween boys (8-12 yrs)', 3), ('Teen boys (13-16 yrs)', 3),
                                             ('Activewear', 4), ('T-shirt', 4), ('Blouses', 4), ('Tank tops & camis', 4), ('Leggings', 4), ('Suits', 4), ('Pants', 4), ('Party wear', 4),
                                             ('Top rated', 5), ('Women', 5), ('Curve', 5), ('Maternities', 5),
                                             ('Brands', 6), ('Women activewear', 6), ('Curve activewear', 6), ('Men activewear', 6), ('Women out - door apparel', 6), ('Men outdoor apparel', 6),
                                             ('Women curve', 7), ('Men', 7), ('Maternity', 7), ('Couple', 7), ('Spring & Summer', 7),
                                             ('Work & Safety shoes', 8), ('Sandal', 8), ('Pumps', 8), ('Slipper', 8), ('Flats', 8), ('Sneaker', 8), ('Ion boots', 8), ('Shoe accessories', 8),
                                             ('Gender neu - tral', 9), ('Fine jewelry', 9), ('Watches & accs', 9), ('Wedding & event', 9), ('Body jewelry & othes', 9), ('Women hats & gloves', 9), ('Women hair accessories', 9), ('Women earrings', 9),
                                             ('Bag accessories', 10), ('Women bags', 10), ('Men bags', 10), ('Luggage & travek gear', 10), ('Wallets & cardholders', 10), ('Functional bags', 10), ('Premium brands', 10), ('Makeup bags', 10);

select * from categories
-- Insert sample data into products

--151
    INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/05/24/50/1716520581c6e49abcc8f061f96bff6f00d51d242f_thumbnail_900x.webp', 'Solid Color Off',16.93 , 50, 'Gumac', 'Made In VietNam', 'Blue', 'Cotton', 'MOD Womens Fashionable Solid Color Off-Shoulder Ruffle Sleeve Dress', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/16/1b/17158257961db624e042f79d6b205261c19348a902_thumbnail_900x.webp', 'Pleated Pocket',11.33 , 50, 'Canifa', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Essnce Women Solid Color Pleated Pocket Design Casual Summer Dress', 1),
    ('https://img.ltwebstatic.com/images3_pi/2022/09/01/1661996761c131255723b52480e42d4da500a98ad2_thumbnail_900x.webp', 'Block Tank',3.59 , 50, 'Yody', 'Made In China', 'Multicolor', 'Cotton', 'EZwear Color Block Tank Top', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/13/db/1715564713e28027143c04cc79e46a7b011c078cb1_thumbnail_900x.webp', 'Vacation Casual Solid',12.94 , 50, 'OWen', 'Made In Indonesia', 'Redwood', 'Cotton', 'Frenchy Plus Size Vacation Casual Solid Color Bandeau Top And Shorts Two-Piece Set', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/20/a6/17161706439a09b0a1f0b5b7337a1a9de281035540_thumbnail_900x.webp', 'Ladies Ribbed',7.13 , 50, 'Gumac', 'Made In VietNam', 'Purple', 'Cotton', 'Qutie Ladies Ribbed Patchwork One-Piece Dress', 1),
    ('https://img.ltwebstatic.com/images3_pi/2022/04/12/164975212574c93c659411b8d7a0404617f71feec3.png', 'Layered Cake Skirt',14.13 , 50, 'Tingoan', 'Made In VietNam', 'White', 'Cotton', 'MOD White Layered Cake Skirt Cute Square Neck Summer Dress Dresses Graduation Formal Dresses Wedding Brides Maid Dresses Bridgerton Style Dress', 1),
    ('https://img.ltwebstatic.com/images3_pi/2022/11/16/166859174215d9bc0064f7cd2454529c83bdfd9b15.png', 'Padded Square Neck',12.24 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'EZwear 3pcs/Pack Padded Square Neck Bra-Free Slim-Fit Women Tank Top', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/10/cc/1715325794e32ded29ab5dd3acec827f56aa0790c2_thumbnail_900x.webp', 'Fit Backless',10.77 , 50, 'Gucci', 'Made In USA', 'Beige-colored', 'Cotton', 'EZwear Casual Fit Backless Drawstring Waist Batwing Sleeve One Piece Jumpsuit For Summer', 1);

--152
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/05/10/e9/171531295154d594d8aad0b797e57704147911df0f_thumbnail_900x.webp', 'Long Cami Dress',13.93 , 50, 'Gumac', 'Made In VietNam', 'Beige-colored', 'Cotton', 'Aloruh Women Summer Elegant Khaki Long Cami Dress', 2),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/07/61/1712457606a5013f80c6cb9dacb92f266e1db76429_thumbnail_900x.webp', 'Square Neckline',10.07 , 50, 'Canifa', 'Made In VietNam', 'Black', 'Cotton', 'EZwear Women Solid Color Square Neckline Athletic Casual Summer Bodycon Dress', 2),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/28/c9/1714271344f567fa4a8c8f3143b643a43754d0538e_thumbnail_900x.webp', 'White Dress Cross',11.61 , 50, 'Yody', 'Made In China', 'White', 'Cotton', 'Privé Women French Graduation White Dress Cross Halter Sleeveless Beach Wedding Dress In White Mini Short Dress Summer Clothes Elegant Wedding Dress Sexy Dress Long Women Dresses', 2),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/01/24/86/1706083142d5f67dcce7623c5d8fce5607c1cf7651_thumbnail_900x.webp', 'Strap Cami',10.58 , 50, 'OWen', 'Made In Indonesia', 'Baby Blue', 'Cotton', 'MOD Women Solid Color Criss-Cross Strap Cami Dress', 2),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/01/11/13/17049405644345f21c23f854200a761a2b9478eda2_thumbnail_900x.webp', 'Sleeveless Dress',9.34 , 50, 'Gumac', 'Made In VietNam', 'Dark Grey', 'Cotton', 'ROMWE PUNK Women Sleeveless Dress With Rivet Decoration', 2),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/08/15/e2/1692064319338c82b5bb056f04e4cfa4d746a61936_thumbnail_900x.webp', 'Cut Out',14.13 , 50, 'Tingoan', 'Made In VietNam', 'Mint Green', 'Cotton', 'EZwear Cut Out Waist Ruched Side Dress', 2),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/03/25/8b/1711375698601b903bd334a2b6f254e22c11fec110_thumbnail_900x.webp', 'Striped Casual',5.88 , 50, 'Gumac', 'Made In VietNam', 'Brown', 'Cotton', 'LUNE Summer Women Striped Casual & Holiday Tank Dress Split Hem Twist Front Sleeveless Dress', 2),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/07/06/16886492682caf35e703fbb1cdc8270f17b6083676.png', 'Rib-knit',7.02 , 50, 'Gucci', 'Made In USA', 'Black', 'Cotton', 'Essnce Rib-knit Solid Bodycon Dress', 2);

--153
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/01/29/03/17064954500cda97b0005e132be8d6a452275b6968_thumbnail_900x.webp', 'Waistband Skirt',7.02 , 50, 'Gumac', 'Made In VietNam', 'Black', 'Cotton', 'EZwear Solid Color Elastic Waistband Skirt With Phone Pocket', 3),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/01/22/83/1705903148fce8f829fb5a8023193b6fb644da5ce8_thumbnail_900x.webp', 'Drawstring Shorts',4.75 , 50, 'Canifa', 'Made In VietNam', 'Dark Grey', 'Cotton', 'EZwear Ladies Drawstring Shorts', 3),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/07/12/1689151526892f784241228e8ec71a116ca33bbe85_thumbnail_900x.webp', 'Leg Shorts',3.59 , 50, 'Yody', 'Made In China', 'Black', 'Cotton', 'VCAY Paperbag Waist Belted Wide Leg Shorts', 3),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/01/10/ca/17048650028634cf5e00ecafe7e73cd438760a551c_thumbnail_900x.webp', 'Casual Shorts',12.94 , 50, 'OWen', 'Made In Indonesia', 'Multicolor', 'Cotton', 'VCAY Women Solid Color Casual Shorts', 3),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/07/06/16886492682caf35e703fbb1cdc8270f17b6083676.png', 'Waist Side Tie',6.65 , 50, 'Gumac', 'Made In VietNam', 'Army Green', 'Cotton', 'Essnce Casual Green Elastic Waist Side Tie Fashionable Summer Skort', 3),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/26/d2/1714121909902fdecaab46007228668b4fe2ea465c_thumbnail_900x.webp', 'Elegant Solid',9.09 , 50, 'Tingoan', 'Made In VietNam', 'Apricot', 'Cotton', 'DAZY Women Elegant Solid Color Side Slit Skort For Summer', 3),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/07/6d/1712475007d729c9eeaa18a00cd4d8c30fce67c1a3_thumbnail_900x.webp', 'Casual Short Leggings',3.76 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'EZwear Solid Color Wide-Waist Casual Short Leggings', 3),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/05/08/c6/17151407498a0d26a1381f4ebf4279751f35c366bf_thumbnail_900x.webp', 'Casual Brown',7.47 , 50, 'Gucci', 'Made In USA', 'Dark Grey', 'Cotton', 'EZwear Summer Loose And Casual Brown Elastic Waist Patched Detail Sports Shorts', 3);


--154
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/16/4f/17132604488b3ca68381d2ddf27764b7abb72a8852_thumbnail_900x.webp', 'Sexy Strapless',53.69 , 50, 'Gumac', 'Made In VietNam', 'White', 'Cotton', 'Belle Elegant And Gorgeous Sexy Strapless Dress With Colorblock Contrast Lace Detailing And A Classic French Style Sheer Lace Bodice, Boning And Scalloped Hemline, Fishnet Tulle Mermaid Skirt With Long Train Wedding Dress', 4),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/06/97/17123760841d2546bf21309296c4bf78d066bee740_thumbnail_900x.webp', 'Plunging Neck',30.89 , 50, 'Canifa', 'Made In VietNam', 'Champagne', 'Cotton', 'Faeriesty Solid Plunging Neck Sleeveless Cami Dress', 4),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/01/12/d1/170506449950fbcb35cd4faf3b30ce9ebd9df6db8a_thumbnail_900x.webp', 'Shoulder High Slit',13.69 , 50, 'Yody', 'Made In China', 'Green', 'Cotton', 'Belle Single Shoulder High Slit Bridesmaid Gown With Gathered Waist', 4),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/02/05/55/170711612782339f8c2ed8b51a74dd26ed676570c0_thumbnail_900x.webp', 'Sparkly Patchwork',10.46 , 50, 'OWen', 'Made In Indonesia', 'Beige-colored', 'Cotton', 'Belle Women One-Shoulder Sparkly Patchwork Slit Elegant Bridesmaid Dress', 4),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2022/11/18/16687421302898ca28bab626d24d5c7d7ecbf8410a_thumbnail_900x.webp', 'Crisscross Backless',19.66 , 50, 'Gumac', 'Made In VietNam', 'Army Red', 'Cotton', 'Belle Crisscross Backless Ruffle Trim Bridesmaid Dress', 4),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/28/ce/171423386649bc5cedb1047a4dad706da7f4129708_thumbnail_900x.webp', 'Waist Belted Floor',27.29 , 50, 'Tingoan', 'Made In VietNam', 'Coral Orange', 'Cotton', 'Summer Solid Color Halter Neck Waist Belted Floor Length Bridesmaid Dress', 4),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/12/16/41/17027067427edf7172ce37059b8a0e554697a25420_thumbnail_900x.webp', 'Adult Criss-Cross',22.78 , 50, 'Gumac', 'Made In VietNam', 'Purple', 'Cotton', 'Belle Adult Criss-Cross Back Fish-Tail Bridesmaid Dress With Small Detachable Train', 4),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/03/04/44/1709547561a586c41ebb0298c3eef080355a49120c_thumbnail_900x.webp', 'Wrap Bridesmaid',14.62 , 50, 'Gucci', 'Made In USA', 'Pink', 'Cotton', 'Belle Solid Color Off Shoulder Slit Wrap Bridesmaid Dress', 4);

--155
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2021/07/16/16264032069131788fe1fec9bb22af1383c4cb57a3_thumbnail_900x.webp', 'Essnce Solid',4.95 , 50, 'Gumac', 'Made In VietNam', 'Khaki', 'Cotton', 'Essnce Solid Drawstring Side Tank Top', 5),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/10/09/78/1696837490c5fa99a84d1f4a5f1a73a62c0bf9cc5f_thumbnail_900x.webp', 'Ruched Summer',3.90 , 50, 'Canifa', 'Made In VietNam', 'Navy Blue', 'Cotton', 'MOD Square Neck Ruched Summer Bodycon Crop Tank Top', 5),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2021/06/15/1623726710f21ac8a867bceff361d335f5802199b9_thumbnail_900x.webp', 'Essnce Notch',2.49 , 50, 'Yody', 'Made In China', 'Dusty Blue', 'Cotton', 'Essnce Notch Neck Rib-knit Tank Top', 5),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/04/30/c9/171444645546f1fca5eb67874a569bc32c39415db1_thumbnail_900x.webp', 'Tight-Fitting Tank',10.28 , 50, 'OWen', 'Made In Indonesia', 'Black', 'Cotton', 'EZwear 2pscBlack & White Knitted Women Tight-Fitting Tank Top, Going Out Top', 5),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/01/03/9a/1704249522898db604578dd352491458b5b7a48bae_thumbnail_900x.webp', 'Flap Pocket Drop',7.75 , 50, 'Gumac', 'Made In VietNam', 'White', 'Cotton', 'EZwear Summer Going Out Tweaking In The Front Flap Pocket Drop Shoulder Crop White Shirt', 5),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/05/19/c6/17160868830ad8ecfd48203b3269e7e6f354486331_thumbnail_900x.webp', 'Textured Ruffle Hem',4.15 , 50, 'Tingoan', 'Made In VietNam', 'Khaki', 'Cotton', 'MOD Women Summer Casual Solid Color Textured Ruffle Hem Backless Camisole', 5),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/03/13/1678691683153db3f238cbf05eacf647369f77e344_thumbnail_900x.webp', 'Square Neck Ribbed',2.94 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'EZwear Square Neck Ribbed Knit Black Crop Tee', 5),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/03/13/77/17103074302d7e1b1a187e861ffab2fa649d678741_thumbnail_900x.webp', 'Neck Rib',7.75 , 50, 'Gucci', 'Made In USA', 'Apricot', 'Cotton', 'Essnce Solid Color Knot Design Tube Top With Ruffle Hem', 5);

--156
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/05/16/ba/171583719666b8fdadfbc0f86e0bc6cfab7682ef3f_thumbnail_900x.webp', 'Printed Holiday',7.34 , 50, 'Gumac', 'Made In VietNam', 'Blue White', 'Cotton', 'WYWH Women Blue And White Printed Holiday Spaghetti Strap Bodysuit', 6),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/05/15/99/17157381111b9c3eae412a4b86cec29d2c32dade0b_thumbnail_900x.webp', 'Pleated Short',11.61 , 50, 'Canifa', 'Made In VietNam', 'Khaki', 'Cotton', 'Privé Women Khaki Pleated Short Wide Leg Jumpsuit,Belt Not Included,Suitable For Daily, Commuting, Holiday, Dating,Wide-Legged One-Piece Shorts', 6),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/05/11/ac/1715419601d9e06fdec18f85b4dc043c24295d58bc_thumbnail_900x.webp', 'Ladies 3pcs ',9.79 , 50, 'Yody', 'Made In China', 'Multicolor', 'Cotton', 'EZwear Ladies 3pcs Tight-Fitting Casual Sleeveless Bodysuit For Summer', 6),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/05/11/4a/17154062623980849b36556ee665a2f6d3c891fe4d_thumbnail_900x.webp', 'Strapless Bodysuit',7.11 , 50, 'OWen', 'Made In Indonesia', 'Blue', 'Cotton', 'WYWH Blue Strapless Bodysuit, Suitable For Vacation, Beach', 6),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2020/05/13/1589356399a48feaf2a5a5019d8e682b772e0d8eb7_thumbnail_900x.webp', 'Front Wide Leg',7.35 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'LUNE Button Front Wide Leg Belted Cami Romper', 6),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/05/23/1684842043ab80667050b766ceb7d49604614e91d1_thumbnail_900x.webp', 'Tropical Print',5.05 , 50, 'Tingoan', 'Made In VietNam', 'Black', 'Cotton', 'LUNE Tropical Print Tie Backless Halter Neck Romper', 6),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2024/02/18/9a/17082470129b5cdba2d24e27c07dd415751e160bc7_thumbnail_900x.webp', 'Asymmetrical Strap',8.53 , 50, 'Gumac', 'Made In VietNam', 'Apricot', 'Cotton', 'VCAY Asymmetrical Strap Pleated Romper For Vacation', 6),
                                                                                                                               ('https://img.ltwebstatic.com/images3_pi/2023/06/01/16855978389ecc60d1f4d6f1a904aa4d38477b55b0_thumbnail_900x.webp', 'Shoulder Bodysuit',6.39 , 50, 'Gucci', 'Made In USA', 'Green', 'Cotton', 'EZwear Colorblock One Shoulder Bodysuit', 6);

select * from categories
select * from products

--157
    INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/03/20/ff/17109233369716a8809ea8bda62637a866765f8655_thumbnail_900x.webp', 'Vintage Hooded',10.95 , 50, 'Gumac', 'Made In VietNam', 'Army Green', 'Cotton', 'ROMWE Fairycore Women Vintage Hooded Cape Coat, Forest Elf Queen Style', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/06/22/1687436317775dbfa9b7eff0a12b713ba7113999eb_thumbnail_900x.webp', 'Colorblock Letter',9.51 , 50, 'Canifa', 'Made In VietNam', 'Multicolor', 'Cotton', 'EZwear Colorblock Letter Patched Detail Drop Shoulder Jacket Without Cami Top', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/08/24/50/16928464676419e40fa9219d36a7243da1aef14b5c_thumbnail_900x.webp', 'Raglan Sleeve',10.24 , 50, 'Yody', 'Made In China', 'Navy Blue', 'Cotton', 'EZwear Spring Colorblock Raglan Sleeve Drawstring Hem Zip Up Windbreaker Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/06/23/1687486642805ae2bce70f357f5bdf29b9126a9cb7_thumbnail_900x.webp', 'Clasi Raglan',18.20 , 50, 'OWen', 'Made In Indonesia', 'Khaki', 'Cotton', 'Clasi Raglan Sleeve Double Breasted Belted Trench Coat', 7),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/18/90/17107279204c551770f00f7f54cc8c422bfb5f24fe_thumbnail_900x.webp', 'Virginia & ZeFelipe',8.60 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'X Virginia & ZeFelipe Letter Graphic Colorblock Drop Shoulder Crop Bomber Y2k Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/09/18/a3/16950074816f245a736815085c5256af83cbcc1bae_thumbnail_900x.webp', 'EZwear Zip',10.42 , 50, 'Tingoan', 'Made In VietNam', 'Grey', 'Cotton', 'EZwear Zip Up Drawstring Hooded Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2020/08/24/1598237364ed4668984d102efa9a8fdc392ca35f8a_thumbnail_900x.webp', 'Trucker Jacket',8.06 , 50, 'Gumac', 'Made In VietNam', 'Colorblock', 'Cotton', 'LUNE Colorblock Button-Front Cropped Trucker Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/28/82/1701144115ca60da02eac2fbe66f3c91d56684e2bb_thumbnail_900x.webp', 'Drop Shoulder Drawstring',13.57 , 50, 'Gucci', 'Made In USA', 'Grey', 'Cotton', 'EZwear Zip Up Drop Shoulder Drawstring Hooded Thermal Lined Zip Up Jacket', 7);

select * from products
-- Insert sample data into product_sizes
    INSERT INTO product_sizes (size, product_id) VALUES
    ('S', 1), ('M', 1), ('L', 1), ('XL', 1),
    ('S', 2), ('M', 2), ('L', 2), ('XL', 2),
    ('S', 3), ('M', 3), ('L', 3), ('XL', 3),
    ('S', 4), ('M', 4), ('L', 4), ('XL', 4),
    ('S', 5), ('M', 5), ('L', 5), ('XL', 5),
    ('S', 6), ('M', 6), ('L', 6), ('XL', 6),
    ('S', 7), ('M', 7), ('L', 7), ('XL', 7),
    ('S', 8), ('M', 8), ('L', 8), ('XL', 8),
    ('S', 9), ('M', 9), ('L', 9), ('XL', 9),
    ('S', 10), ('M', 10), ('L', 10), ('XL', 10),
    ('S', 11), ('M', 11), ('L', 11), ('XL', 11),
    ('S', 12), ('M', 12), ('L', 12), ('XL', 12),
    ('S', 13), ('M', 13), ('L', 13), ('XL', 13),
    ('S', 14), ('M', 14), ('L', 14), ('XL', 14),
    ('S', 15), ('M', 15), ('L', 15), ('XL', 15),
    ('S', 16), ('M', 16), ('L', 16), ('XL', 16),
    ('S', 17), ('M', 17), ('L', 17), ('XL', 17),
    ('S', 18), ('M', 18), ('L', 18), ('XL', 18),
    ('S', 19), ('M', 19), ('L', 19), ('XL', 19),
    ('S', 20), ('M', 20), ('L', 20), ('XL', 20),
    ('S', 21), ('M', 21), ('L', 21), ('XL', 21),
    ('S', 22), ('M', 22), ('L', 22), ('XL', 22),
    ('S', 23), ('M', 23), ('L', 23), ('XL', 23),
    ('S', 24), ('M', 24), ('L', 24), ('XL', 24),
    ('S', 25), ('M', 25), ('L', 25), ('XL', 25),
    ('S', 26), ('M', 26), ('L', 26), ('XL', 26),
    ('S', 27), ('M', 27), ('L', 27), ('XL', 27),
    ('S', 28), ('M', 28), ('L', 28), ('XL', 28),
    ('S', 29), ('M', 29), ('L', 29), ('XL', 29),
    ('S', 30), ('M', 30), ('L', 30), ('XL', 30),
    ('S', 31), ('M', 31), ('L', 31), ('XL', 31),
    ('S', 32), ('M', 32), ('L', 32), ('XL', 32),
    ('S', 33), ('M', 33), ('L', 33), ('XL', 33),
    ('S', 34), ('M', 34), ('L', 34), ('XL', 34),
    ('S', 35), ('M', 35), ('L', 35), ('XL', 35),
    ('S', 36), ('M', 36), ('L', 36), ('XL', 36),
    ('S', 37), ('M', 37), ('L', 37), ('XL', 37),
    ('S', 38), ('M', 38), ('L', 38), ('XL', 38),
    ('S', 39), ('M', 39), ('L', 39), ('XL', 39),
    ('S', 40), ('M', 40), ('L', 40), ('XL', 40),
    ('S', 41), ('M', 41), ('L', 41), ('XL', 41),
    ('S', 42), ('M', 42), ('L', 42), ('XL', 42),
    ('S', 43), ('M', 43), ('L', 43), ('XL', 43),
    ('S', 44), ('M', 44), ('L', 44), ('XL', 44),
    ('S', 45), ('M', 45), ('L', 45), ('XL', 45),
    ('S', 46), ('M', 46), ('L', 46), ('XL', 46),
    ('S', 47), ('M', 47), ('L', 47), ('XL', 47),
    ('S', 48), ('M', 48), ('L', 48), ('XL', 48),
    ('S', 49), ('M', 49), ('L', 49), ('XL', 49),
    ('S', 50), ('M', 50), ('L', 50), ('XL', 50),
    ('S', 51), ('M', 51), ('L', 51), ('XL', 51),
    ('S', 52), ('M', 52), ('L', 52), ('XL', 52),
    ('S', 53), ('M', 53), ('L', 53), ('XL', 53),
    ('S', 54), ('M', 54), ('L', 54), ('XL', 54),
    ('S', 55), ('M', 55), ('L', 55), ('XL', 55),
    ('S', 56), ('M', 56), ('L', 56), ('XL', 56);


select * from products;

select * from product_sizes
-- Insert sample data into product_images
    INSERT INTO product_images (image_url, product_id) VALUES
    ('product1_image1.jpg', 1),
    ('product1_image2.jpg', 1);

-- Insert sample data into accounts
INSERT INTO accounts (username, [password], email, full_name, phone, [address], [role]) VALUES
                                                                                            ('john_doe', 'password123', 'john@example.com', 'John Doe', '1234567890', '123 Elm Street', 'Customer'),
                                                                                            ('jane_doe', 'password456', 'jane@example.com', 'Jane Doe', '0987654321', '456 Oak Street', 'Customer');

-- Insert sample data into favorites
INSERT INTO favorites (account_id, product_id) VALUES
                                                   (1, 1),
                                                   (2, 2);

-- Insert sample data into feedbacks
INSERT INTO feedbacks (rate, content, create_date, [status], account_id, product_id) VALUES
                                                                                         (5, 'Great product!', GETDATE(), 1, 1, 1),
                                                                                         (4, 'Good value for money.', GETDATE(), 1, 2,1);

-- Insert sample data into vouchers
INSERT INTO vouchers (code, discount_amount, [condition], valid_form, valid_to, create_date) VALUES
                                                                                                 ('DISCOUNT10', 10.00, 50.00, '2024-01-01', '2024-12-31', GETDATE()),
                                                                                                 ('DISCOUNT20', 20.00, 100.00, '2024-01-01', '2024-12-31', GETDATE());

-- Insert sample data into orders
INSERT INTO orders (order_date, total_amount, [status], [address], phone, voucher_id, account_id) VALUES
                                                                                                      (GETDATE(), 989.99, 'Processing', '123 Elm Street', '1234567890', 1, 1),
                                                                                                      (GETDATE(), 29.99, 'Shipped', '456 Oak Street', '0987654321', 2, 2);

-- Insert sample data into order_details
INSERT INTO order_details (quantity, price, order_id, product_id) VALUES
                                                                      (1, 999.99, 1, 1),
                                                                      (2, 19.99, 2, 2);
