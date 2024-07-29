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
    quantity int  not null,
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
    [password] varchar(255) not null,
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
    size varchar(10) not null,
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

--1
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/05/24/50/1716520581c6e49abcc8f061f96bff6f00d51d242f_thumbnail_900x.webp', 'Solid Color Off',330000 , 50, 'Gumac', 'Made In VietNam', 'Blue', 'Cotton', 'MOD Womens Fashionable Solid Color Off-Shoulder Ruffle Sleeve Dress', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/16/1b/17158257961db624e042f79d6b205261c19348a902_thumbnail_900x.webp', 'Pleated Pocket',212000 , 50, 'Canifa', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Essnce Women Solid Color Pleated Pocket Design Casual Summer Dress', 1),
    ('https://img.ltwebstatic.com/images3_pi/2022/09/01/1661996761c131255723b52480e42d4da500a98ad2_thumbnail_900x.webp', 'Block Tank',75000 , 50, 'Yody', 'Made In China', 'Multicolor', 'Cotton', 'EZwear Color Block Tank Top', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/13/db/1715564713e28027143c04cc79e46a7b011c078cb1_thumbnail_900x.webp', 'Vacation Casual Solid',279000 , 50, 'OWen', 'Made In Indonesia', 'Redwood', 'Cotton', 'Frenchy Plus Size Vacation Casual Solid Color Bandeau Top And Shorts Two-Piece Set', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/20/a6/17161706439a09b0a1f0b5b7337a1a9de281035540_thumbnail_900x.webp', 'Ladies Ribbed',150000 , 50, 'Gumac', 'Made In VietNam', 'Purple', 'Cotton', 'Qutie Ladies Ribbed Patchwork One-Piece Dress', 1),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/10/cc/1715325794e32ded29ab5dd3acec827f56aa0790c2_thumbnail_900x.webp', 'Fit Backless',210000 , 50, 'Gucci', 'Made In USA', 'Beige-colored', 'Cotton', 'EZwear Casual Fit Backless Drawstring Waist Batwing Sleeve One Piece Jumpsuit For Summer', 1);

INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/05/10/e9/171531295154d594d8aad0b797e57704147911df0f_thumbnail_900x.webp', 'Long Cami Dress',260000 , 50, 'Gumac', 'Made In VietNam', 'Beige-colored', 'Cotton', 'Aloruh Women Summer Elegant Khaki Long Cami Dress', 2),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/07/61/1712457606a5013f80c6cb9dacb92f266e1db76429_thumbnail_900x.webp', 'Square Neckline',218000 , 50, 'Canifa', 'Made In VietNam', 'Black', 'Cotton', 'EZwear Women Solid Color Square Neckline Athletic Casual Summer Bodycon Dress', 2),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/28/c9/1714271344f567fa4a8c8f3143b643a43754d0538e_thumbnail_900x.webp', 'White Dress Cross',321000 , 50, 'Yody', 'Made In China', 'White', 'Cotton', 'Priv� Women French Graduation White Dress Cross Halter Sleeveless Beach Wedding Dress In White Mini Short Dress Summer Clothes Elegant Wedding Dress Sexy Dress Long Women Dresses', 2),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/24/86/1706083142d5f67dcce7623c5d8fce5607c1cf7651_thumbnail_900x.webp', 'Strap Cami',253000 , 50, 'OWen', 'Made In Indonesia', 'Baby Blue', 'Cotton', 'MOD Women Solid Color Criss-Cross Strap Cami Dress', 2),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/11/13/17049405644345f21c23f854200a761a2b9478eda2_thumbnail_900x.webp', 'Sleeveless Dress',186000 , 50, 'Gumac', 'Made In VietNam', 'Dark Grey', 'Cotton', 'ROMWE PUNK Women Sleeveless Dress With Rivet Decoration', 2),
    ('https://img.ltwebstatic.com/images3_pi/2023/08/15/e2/1692064319338c82b5bb056f04e4cfa4d746a61936_thumbnail_900x.webp', 'Cut Out',143000 , 50, 'Tingoan', 'Made In VietNam', 'Mint Green', 'Cotton', 'EZwear Cut Out Waist Ruched Side Dress', 2),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/25/8b/1711375698601b903bd334a2b6f254e22c11fec110_thumbnail_900x.webp', 'Striped Casual',108000 , 50, 'Gumac', 'Made In VietNam', 'Brown', 'Cotton', 'LUNE Summer Women Striped Casual & Holiday Tank Dress Split Hem Twist Front Sleeveless Dress', 2);

INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/01/29/03/17064954500cda97b0005e132be8d6a452275b6968_thumbnail_900x.webp', 'Waistband Skirt',142000 , 50, 'Gumac', 'Made In VietNam', 'Black', 'Cotton', 'EZwear Solid Color Elastic Waistband Skirt With Phone Pocket', 3),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/22/83/1705903148fce8f829fb5a8023193b6fb644da5ce8_thumbnail_900x.webp', 'Drawstring Shorts',87500 , 50, 'Canifa', 'Made In VietNam', 'Dark Grey', 'Cotton', 'EZwear Ladies Drawstring Shorts', 3),
    ('https://img.ltwebstatic.com/images3_pi/2023/07/12/1689151526892f784241228e8ec71a116ca33bbe85_thumbnail_900x.webp', 'Leg Shorts',69000 , 50, 'Yody', 'Made In China', 'Black', 'Cotton', 'VCAY Paperbag Waist Belted Wide Leg Shorts', 3),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/10/ca/17048650028634cf5e00ecafe7e73cd438760a551c_thumbnail_900x.webp', 'Casual Shorts',214000 , 50, 'OWen', 'Made In Indonesia', 'Multicolor', 'Cotton', 'VCAY Women Solid Color Casual Shorts', 3),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/26/d2/1714121909902fdecaab46007228668b4fe2ea465c_thumbnail_900x.webp', 'Elegant Solid',181000 , 50, 'Tingoan', 'Made In VietNam', 'Apricot', 'Cotton', 'DAZY Women Elegant Solid Color Side Slit Skort For Summer', 3),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/07/6d/1712475007d729c9eeaa18a00cd4d8c30fce67c1a3_thumbnail_900x.webp', 'Casual Short Leggings',109000 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'EZwear Solid Color Wide-Waist Casual Short Leggings', 3),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/08/c6/17151407498a0d26a1381f4ebf4279751f35c366bf_thumbnail_900x.webp', 'Casual Brown',144000 , 50, 'Gucci', 'Made In USA', 'Dark Grey', 'Cotton', 'EZwear Summer Loose And Casual Brown Elastic Waist Patched Detail Sports Shorts', 3);


INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/04/16/4f/17132604488b3ca68381d2ddf27764b7abb72a8852_thumbnail_900x.webp', 'Sexy Strapless',500000 , 50, 'Gumac', 'Made In VietNam', 'White', 'Cotton', 'Belle Elegant And Gorgeous Sexy Strapless Dress With Colorblock Contrast Lace Detailing And A Classic French Style Sheer Lace Bodice, Boning And Scalloped Hemline, Fishnet Tulle Mermaid Skirt With Long Train Wedding Dress', 4),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/06/97/17123760841d2546bf21309296c4bf78d066bee740_thumbnail_900x.webp', 'Plunging Neck',405000 , 50, 'Canifa', 'Made In VietNam', 'Champagne', 'Cotton', 'Faeriesty Solid Plunging Neck Sleeveless Cami Dress', 4),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/12/d1/170506449950fbcb35cd4faf3b30ce9ebd9df6db8a_thumbnail_900x.webp', 'Shoulder High Slit',268000 , 50, 'Yody', 'Made In China', 'Green', 'Cotton', 'Belle Single Shoulder High Slit Bridesmaid Gown With Gathered Waist', 4),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/05/55/170711612782339f8c2ed8b51a74dd26ed676570c0_thumbnail_900x.webp', 'Sparkly Patchwork',216000 , 50, 'OWen', 'Made In Indonesia', 'Beige-colored', 'Cotton', 'Belle Women One-Shoulder Sparkly Patchwork Slit Elegant Bridesmaid Dress', 4),
    ('https://img.ltwebstatic.com/images3_pi/2022/11/18/16687421302898ca28bab626d24d5c7d7ecbf8410a_thumbnail_900x.webp', 'Crisscross Backless',405000 , 50, 'Gumac', 'Made In VietNam', 'Army Red', 'Cotton', 'Belle Crisscross Backless Ruffle Trim Bridesmaid Dress', 4),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/28/ce/171423386649bc5cedb1047a4dad706da7f4129708_thumbnail_900x.webp', 'Waist Belted Floor',450000 , 50, 'Tingoan', 'Made In VietNam', 'Coral Orange', 'Cotton', 'Summer Solid Color Halter Neck Waist Belted Floor Length Bridesmaid Dress', 4),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/16/41/17027067427edf7172ce37059b8a0e554697a25420_thumbnail_900x.webp', 'Adult Criss-Cross',514000 , 50, 'Gumac', 'Made In VietNam', 'Purple', 'Cotton', 'Belle Adult Criss-Cross Back Fish-Tail Bridesmaid Dress With Small Detachable Train', 4),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/04/44/1709547561a586c41ebb0298c3eef080355a49120c_thumbnail_900x.webp', 'Wrap Bridesmaid',167000 , 50, 'Gucci', 'Made In USA', 'Pink', 'Cotton', 'Belle Solid Color Off Shoulder Slit Wrap Bridesmaid Dress', 4);

INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2021/07/16/16264032069131788fe1fec9bb22af1383c4cb57a3_thumbnail_900x.webp', 'Essnce Solid',87000 , 50, 'Gumac', 'Made In VietNam', 'Khaki', 'Cotton', 'Essnce Solid Drawstring Side Tank Top', 5),
    ('https://img.ltwebstatic.com/images3_pi/2023/10/09/78/1696837490c5fa99a84d1f4a5f1a73a62c0bf9cc5f_thumbnail_900x.webp', 'Ruched Summer',76000 , 50, 'Canifa', 'Made In VietNam', 'Navy Blue', 'Cotton', 'MOD Square Neck Ruched Summer Bodycon Crop Tank Top', 5),
    ('https://img.ltwebstatic.com/images3_pi/2021/06/15/1623726710f21ac8a867bceff361d335f5802199b9_thumbnail_900x.webp', 'Essnce Notch',59000 , 50, 'Yody', 'Made In China', 'Dusty Blue', 'Cotton', 'Essnce Notch Neck Rib-knit Tank Top', 5),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/30/c9/171444645546f1fca5eb67874a569bc32c39415db1_thumbnail_900x.webp', 'Tight-Fitting Tank',218000 , 50, 'OWen', 'Made In Indonesia', 'Black', 'Cotton', 'EZwear 2pscBlack & White Knitted Women Tight-Fitting Tank Top, Going Out Top', 5),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/03/9a/1704249522898db604578dd352491458b5b7a48bae_thumbnail_900x.webp', 'Flap Pocket Drop',145000 , 50, 'Gumac', 'Made In VietNam', 'White', 'Cotton', 'EZwear Summer Going Out Tweaking In The Front Flap Pocket Drop Shoulder Crop White Shirt', 5),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/19/c6/17160868830ad8ecfd48203b3269e7e6f354486331_thumbnail_900x.webp', 'Textured Ruffle Hem',145000 , 50, 'Tingoan', 'Made In VietNam', 'Khaki', 'Cotton', 'MOD Women Summer Casual Solid Color Textured Ruffle Hem Backless Camisole', 5),
    ('https://img.ltwebstatic.com/images3_pi/2023/03/13/1678691683153db3f238cbf05eacf647369f77e344_thumbnail_900x.webp', 'Square Neck Ribbed',54000 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'EZwear Square Neck Ribbed Knit Black Crop Tee', 5),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/13/77/17103074302d7e1b1a187e861ffab2fa649d678741_thumbnail_900x.webp', 'Neck Rib',159000 , 50, 'Gucci', 'Made In USA', 'Apricot', 'Cotton', 'Essnce Solid Color Knot Design Tube Top With Ruffle Hem', 5);

INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/05/16/ba/171583719666b8fdadfbc0f86e0bc6cfab7682ef3f_thumbnail_900x.webp', 'Printed Holiday',178000 , 50, 'Gumac', 'Made In VietNam', 'Blue White', 'Cotton', 'WYWH Women Blue And White Printed Holiday Spaghetti Strap Bodysuit', 6),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/15/99/17157381111b9c3eae412a4b86cec29d2c32dade0b_thumbnail_900x.webp', 'Pleated Short',154000 , 50, 'Canifa', 'Made In VietNam', 'Khaki', 'Cotton', 'Priv� Women Khaki Pleated Short Wide Leg Jumpsuit,Belt Not Included,Suitable For Daily, Commuting, Holiday, Dating,Wide-Legged One-Piece Shorts', 6),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/11/ac/1715419601d9e06fdec18f85b4dc043c24295d58bc_thumbnail_900x.webp', 'Ladies 3pcs ',180000 , 50, 'Yody', 'Made In China', 'Multicolor', 'Cotton', 'EZwear Ladies 3pcs Tight-Fitting Casual Sleeveless Bodysuit For Summer', 6),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/11/4a/17154062623980849b36556ee665a2f6d3c891fe4d_thumbnail_900x.webp', 'Strapless Bodysuit',219000 , 50, 'OWen', 'Made In Indonesia', 'Blue', 'Cotton', 'WYWH Blue Strapless Bodysuit, Suitable For Vacation, Beach', 6),
    ('https://img.ltwebstatic.com/images3_pi/2020/05/13/1589356399a48feaf2a5a5019d8e682b772e0d8eb7_thumbnail_900x.webp', 'Front Wide Leg',128000 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'LUNE Button Front Wide Leg Belted Cami Romper', 6),
    ('https://img.ltwebstatic.com/images3_pi/2023/05/23/1684842043ab80667050b766ceb7d49604614e91d1_thumbnail_900x.webp', 'Tropical Print',105000 , 50, 'Tingoan', 'Made In VietNam', 'Black', 'Cotton', 'LUNE Tropical Print Tie Backless Halter Neck Romper', 6),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/18/9a/17082470129b5cdba2d24e27c07dd415751e160bc7_thumbnail_900x.webp', 'Asymmetrical Strap',173000 , 50, 'Gumac', 'Made In VietNam', 'Apricot', 'Cotton', 'VCAY Asymmetrical Strap Pleated Romper For Vacation', 6),
    ('https://img.ltwebstatic.com/images3_pi/2023/06/01/16855978389ecc60d1f4d6f1a904aa4d38477b55b0_thumbnail_900x.webp', 'Shoulder Bodysuit',129000 , 50, 'Gucci', 'Made In USA', 'Green', 'Cotton', 'EZwear Colorblock One Shoulder Bodysuit', 6);


    INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/03/20/ff/17109233369716a8809ea8bda62637a866765f8655_thumbnail_900x.webp', 'Vintage Hooded',190000 , 50, 'Gumac', 'Made In VietNam', 'Army Green', 'Cotton', 'ROMWE Fairycore Women Vintage Hooded Cape Coat, Forest Elf Queen Style', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/06/22/1687436317775dbfa9b7eff0a12b713ba7113999eb_thumbnail_900x.webp', 'Colorblock Letter',176000 , 50, 'Canifa', 'Made In VietNam', 'Multicolor', 'Cotton', 'EZwear Colorblock Letter Patched Detail Drop Shoulder Jacket Without Cami Top', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/08/24/50/16928464676419e40fa9219d36a7243da1aef14b5c_thumbnail_900x.webp', 'Raglan Sleeve',215000 , 50, 'Yody', 'Made In China', 'Navy Blue', 'Cotton', 'EZwear Spring Colorblock Raglan Sleeve Drawstring Hem Zip Up Windbreaker Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/06/23/1687486642805ae2bce70f357f5bdf29b9126a9cb7_thumbnail_900x.webp', 'Clasi Raglan',325000 , 50, 'OWen', 'Made In Indonesia', 'Khaki', 'Cotton', 'Clasi Raglan Sleeve Double Breasted Belted Trench Coat', 7),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/18/90/17107279204c551770f00f7f54cc8c422bfb5f24fe_thumbnail_900x.webp', 'Virginia & ZeFelipe',116000 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'X Virginia & ZeFelipe Letter Graphic Colorblock Drop Shoulder Crop Bomber Y2k Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/09/18/a3/16950074816f245a736815085c5256af83cbcc1bae_thumbnail_900x.webp', 'EZwear Zip',252000 , 50, 'Tingoan', 'Made In VietNam', 'Grey', 'Cotton', 'EZwear Zip Up Drawstring Hooded Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2020/08/24/1598237364ed4668984d102efa9a8fdc392ca35f8a_thumbnail_900x.webp', 'Trucker Jacket',179000 , 50, 'Gumac', 'Made In VietNam', 'Colorblock', 'Cotton', 'LUNE Colorblock Button-Front Cropped Trucker Jacket', 7),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/28/82/1701144115ca60da02eac2fbe66f3c91d56684e2bb_thumbnail_900x.webp', 'Drop Shoulder Drawstring',260000 , 50, 'Gucci', 'Made In USA', 'Grey', 'Cotton', 'EZwear Zip Up Drop Shoulder Drawstring Hooded Thermal Lined Zip Up Jacket', 7);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/05/11/ae/171539253701021f6805b9c4d51d3fa0f8960c738b_thumbnail_900x.webp', 'Vintage Hooded1',259000 , 50, 'Gumac', 'Made In VietNam', 'White', 'Cotton', 'ROMWE Fairycore Women Vintage Hooded Cape Coat, Forest Elf Queen Style', 8),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/29/d7/1716949978ba6dadd3a64f84be8e5bb1b67d905359_thumbnail_900x.webp', 'Colorblock Letter1',179000 , 50, 'Canifa', 'Made In VietNam', 'Grey', 'Cotton', 'EZwear Colorblock Letter Patched Detail Drop Shoulder Jacket Without Cami Top', 8),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/14/54/171565878452f698c8c90822d5bda95b6b4e51eba4_thumbnail_900x.webp', 'Raglan Sleeve1',260000 , 50, 'Yody', 'Made In China', 'White', 'Cotton', 'EZwear Spring Colorblock Raglan Sleeve Drawstring Hem Zip Up Windbreaker Jacket', 8),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/30/36/17170417963e7c70b515d48f7aa2ee792a3e783d4b_thumbnail_900x.webp', 'Virginia & ZeFelipe1',109000 , 50, 'Gumac', 'Made In VietNam', 'Black', 'Cotton', 'X Virginia & ZeFelipe Letter Graphic Colorblock Drop Shoulder Crop Bomber Y2k Jacket', 8),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/23/9c/171643705381ae31239edd435ec27b82e27c485f8c_thumbnail_900x.webp', 'EZwear Zip1',218000 , 50, 'Tingoan', 'Made In VietNam', 'Multicolor', 'Cotton', 'EZwear Zip Up Drawstring Hooded Jacket', 8),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/22/26/1705889372576a0a5eab5dfc0a9cb42ec85237c04a_thumbnail_900x.webp', 'Trucker Jacket1',189000 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'LUNE Colorblock Button-Front Cropped Trucker Jacket', 8),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/22/26/1705889372576a0a5eab5dfc0a9cb42ec85237c04a_thumbnail_900x.webp', 'Drop Shoulder Drawstring1',298000 , 50, 'Gucci', 'Made In USA', 'Khaki', 'Cotton', 'EZwear Zip Up Drop Shoulder Drawstring Hooded Thermal Lined Zip Up Jacket', 8);


	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2023/06/05/1685955393f0e710719eae6180d2f7a3dbface933b_thumbnail_900x.webp', 'Manfinity Homme',219000 , 50, 'Gumac', 'Made In VietNam', ' Navy Blue', 'Cotton', 'Manfinity Homme Men Plus Solid Notched Neck Tee', 9),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/12/72/16997184565887a2d672a6f6e818fe7783ee669e93_thumbnail_900x.webp', 'Solid Color Round',152000 , 50, 'Tingoan', 'Made In VietNam', 'Grey', 'Cotton', 'Mens Plus Size Ombre Short Sleeve T-shirt And Shorts', 9);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/03/15/46/17104885504d190d91e02e7f5ededb7157a57a3b56_thumbnail_900x.webp', 'Block Round',210000 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Manfinity Homme Mens Color Block Round Neck Short Sleeve Casual T-Shirt', 10),
    ('https://img.ltwebstatic.com/images3_pi/2022/08/26/16614798656bd0c20d513c2b761aa3c60fe8a70689_thumbnail_900x.webp', 'Contrast Trim Polo',180000 , 50, 'Canifa', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Manfinity Homme Men Contrast Trim Polo Shirt', 10),
    ('https://img.ltwebstatic.com/images3_pi/2023/07/08/168882121683217386df2341e67f52ece7325dc922_thumbnail_900x.webp', 'Loose Fit',276000 , 50, 'Yody', 'Made In China', 'Dark Grey', 'Cotton', 'Manfinity Homme Loose Fit Mens Drawstring Cargo Shorts', 10),
    ('https://img.ltwebstatic.com/images3_pi/2022/12/06/1670307438183d1f7a17ff20334e77ee3d4d16ff86_thumbnail_900x.webp', 'Flap Pocket Shirt',198000 , 50, 'OWen', 'Made In Indonesia', 'Navy Khaki', 'Cotton', 'Manfinity Homme Men 1pc Flap Pocket Shirt & 1pc Drawstring Waist Shorts', 10),
    ('https://img.ltwebstatic.com/images3_pi/2022/12/06/1670307438183d1f7a17ff20334e77ee3d4d16ff86_thumbnail_900x.webp', 'Tropical Print Shirt',165000 , 50, 'Gumac', 'Made In VietNam', 'Black and White', 'Cotton', 'Manfinity RSRT Men Tropical Print Shirt & Drawstring Waist Shorts Without Tee', 10),
    ('https://img.ltwebstatic.com/images3_pi/2022/12/06/1670307438183d1f7a17ff20334e77ee3d4d16ff86_thumbnail_900x.webp', 'Gingham Trim',176000 , 50, 'Tingoan', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Manfinity Homme Men Gingham Trim Polo Shirt', 10),
    ('https://img.ltwebstatic.com/images3_pi/2023/08/25/c6/16929262605803e932d686e8a7e696ef988020c3a7_thumbnail_900x.webp', 'Waist Cargo Shorts',125000 , 50, 'Gumac', 'Made In VietNam', 'Grey', 'Cotton', 'Manfinity Homme Men Flap Pocket Side Drawstring Waist Cargo Shorts', 10),
    ('https://img.ltwebstatic.com/images3_pi/2023/08/25/c6/16929262605803e932d686e8a7e696ef988020c3a7_thumbnail_900x.webp', 'Cartoon Graphic Tee',79000 , 50, 'Gucci', 'Made In USA', 'Light Grey', 'Cotton', 'Manfinity Homme Men Cartoon Graphic Tee', 10);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/04/11/19/171280729763899c853183cbf3f525bdca06aab656_thumbnail_900x.webp', 'Hawaiian Shirt Plant',269000 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'Manfinity RSRT Men Plus Size Vacation Casual Hawaiian Shirt Plant & Ape Print Short Sleeve Shirt', 11),
    ('https://img.ltwebstatic.com/images3_pi/2024/06/04/8c/1717471422a672d3c2620ae8a90ebd646179537b4f_thumbnail_900x.webp', 'Casual Polo Shirt',178500 , 50, 'Canifa', 'Made In VietNam', 'Black', 'Cotton', 'Mens Summer Solid Short Sleeve Casual Polo Shirt For Commute', 11),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/29/bb/17169868840bdefa916ee13a206569c6184e1378f1_thumbnail_900x.webp', 'Breasted Printed Holiday',265000 , 50, 'Yody', 'Made In China', 'Multicolor', 'Cotton', 'Manfinity AFTRDRK Mens Single-Breasted Printed Holiday Short Sleeve Shirt And Shorts Set', 11),
    ('https://img.ltwebstatic.com/images3_pi/2023/05/05/16832499810f91ff5db9304c00d6e0b24c08498584_thumbnail_900x.webp', 'Shirt & Shorts Set',350000 , 50, 'OWen', 'Made In Indonesia', 'White', 'Cotton', 'Manfinity Homme Men Solid Button Up Shirt & Shorts Set', 11),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/22/d1/17163566521afa11fd72a4c6ea2fb0616e1505f7bf_thumbnail_900x.webp', 'Sleeve Polo Shirt',213000 , 50, 'Gumac', 'Made In VietNam', 'Baby Blue', 'Cotton', 'Mens Solid Color Short Sleeve Polo Shirt And Drawstring Shorts Summer Casual Outfit', 11),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/20/d0/1716191859d32e533812c187b9bf8c6746c0ebd50f_thumbnail_900x.webp', 'Casual Denim Shorts',415000 , 50, 'Tingoan', 'Made In VietNam', 'Dark Grey', 'Cotton', 'Manfinity EMRG Mens Drawstring Waist Workwear Style Pocketed Casual Denim Shorts', 11),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/09/c4/1699459355f74b39b57f6cb62a8c35ae4ae68c6c52_thumbnail_900x.webp', 'Solid Color Hoodie',490000 , 50, 'Gumac', 'Made In VietNam', 'Dark Grey', 'Cotton', 'Men Fashionable Solid Color Hoodie Flap Pocket Side Drawstring Waist Cargo Shorts', 11),
    ('https://img.ltwebstatic.com/images3_spmp/2024/06/06/e0/17176349222bf230a74933312cdc400159b6c5b421_thumbnail_900x.webp', 'Polyester Sweatshirt',576000 , 50, 'Gucci', 'Made In USA', 'Dark Blue', 'Cotton', 'Manfinity Homme Men Polyester Sweatshirt (N/A)', 11);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_spmp/2024/03/28/ae/171163106650f319faba68cc3fac2cd2c5fabf6ed6_thumbnail_900x.webp', 'Classy Lapel Collar',618000 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Men Four Seasons Classy Lapel Collar Long Sleeve Suit Jacket And Trousers Business Suit', 12),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/25/5c/1711349736f0b92ac89f585b032f95a5c050bf2555_thumbnail_900x.webp', 'Breasted Suit Jacket',345000 , 50, 'Canifa', 'Made In VietNam', 'Black', 'Cotton', 'Manfinity Mode 2pcs/Set Mens Plus Size Solid Color Single-Breasted Suit Jacket And Tapered Pants Set', 12),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/17/ca/17133457632e4160099586560e5df1ef1ca4db7f91_thumbnail_900x.webp', 'Casual Single Breasted',789000 , 50, 'Yody', 'Made In China', 'Purple', 'Cotton', 'Manfinity Mode Men Solid Color Casual Single Breasted Suit Jacket And Suit Pants Set', 12),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/25/f6/1711330959fc038548fb5716edb1f61bbc2084027f_thumbnail_900x.webp', 'Slant Pocket Pants Suit',600000 , 50, 'OWen', 'Made In Indonesia', 'Ash Gray', 'Cotton', 'Manfinity Bizformal Mens Solid Casual Lapel Neck Blazer & Slant Pocket Pants Suit Set', 12),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/21/a8/1716275846d132f11042e2ce080a0bfe4a28d2bb3b_thumbnail_900x.webp', 'Size Single-Breasted',980000 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Manfinity Mode Mens Plus Size Single-Breasted Suit Jacket And Suit Pants Set', 12),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/06/1e/17124086802e9c67db7c76fad162d31bdc9012c9be_thumbnail_900x.webp', 'Shawl Collar Long',720000 , 50, 'Tingoan', 'Made In VietNam', 'Black', 'Cotton', 'Manfinity Mode MenS Shawl Collar Long Sleeve Blazer Suit', 12),
    ('https://img.ltwebstatic.com/images3_pi/2024/06/07/e7/1717738691ad1db7aedb252dbc184aadc37f2113e6_thumbnail_900x.webp', 'Breasted Suit Coat',490000 , 50, 'Gucci', 'Made In USA', 'Ash Gray', 'Cotton', 'Manfinity Mode Mens Suit Jacket & Pants Set, Classic Work Wear Single-Breasted Suit Coat With Notch Lape', 12);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2023/11/06/09/1699238984944bb523451def62bb9d88817149eb73_thumbnail_900x.webp', 'Pullover Sweater',189000 , 50, 'Gumac', 'Made In VietNam', 'White Green', 'Cotton', 'ROMWE Street Life Mens Color-block Pullover Sweater', 13),
    ('https://img.ltwebstatic.com/images3_pi/2022/12/12/1670815624407ec21de7332021018eabf8dde8549c_thumbnail_900x.webp', 'Graffiti Print Jumper',265000 , 50, 'Canifa', 'Made In VietNam', 'Multicolor', 'Cotton', 'Manfinity Homme Men Manfinity EMRG Men Graffiti Print Jumper', 13),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/13/22/16998399812a1e4707c7e83f5649bcb76f7bfd8465_thumbnail_900x.webp', 'Round Neck Sweater',112000 , 50, 'Yody', 'Made In China', 'Multicolor', 'Cotton', 'Manfinity Homme Mens Color Block Round Neck Sweater', 13),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/28/4e/1714270533771148daa90acbd16389803dfebf9a06_thumbnail_900x.webp', 'Graphic Pattern Sweater',320000 , 50, 'OWen', 'Made In Indonesia', 'Multicolor', 'Cotton', 'ROMWE Street Life Men Graphic Pattern Sweater & 1pc Drawstring Waist Shorts', 13),
    ('https://img.ltwebstatic.com/images3_pi/2023/08/29/bb/1693274493d0f395650583b4525bc3a9699391d142_thumbnail_900x.webp', 'Shoulder Sweater Without',390000 , 50, 'Gumac', 'Made In VietNam', 'Light Grey', 'Cotton', 'DAZY Men Two Tone Drop Shoulder Sweater Without Tee', 13),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/26/a5/1706252939105c7a606b96ae7f1e853c28fedee3f5_thumbnail_900x.webp', 'Polo Collar Sweater',420000 , 50, 'Tingoan', 'Made In VietNam', 'Multicolor', 'Cotton', 'DAZY Mens Striped Polo Collar Sweater Polo Shirt', 13),
    ('https://img.ltwebstatic.com/images3_pi/2023/08/29/42/1693274288c9423bfcbcfaa8b5ad57e331fa58a426_thumbnail_900x.webp', 'Button Up Cardigan',500000 , 50, 'Gumac', 'Made In VietNam', 'Grey', 'Cotton', 'DAZY Men Ribbed Knit Drop Shoulder Button Up Cardigan', 13),
    ('https://img.ltwebstatic.com/images3_pi/2021/08/27/16300421444fc432366bd3efab5c8ca2571eb36fc2_thumbnail_900x.webp', 'Painting Pattern Jumper',560000 , 50, 'Gucci', 'Made In USA', 'Grey', 'Cotton', 'Manfinity Homme Men Ink Painting Pattern Jumper Cartoon Graphic Tee', 13);
	
	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/04/26/b0/17141215798cde6c613e338bd74822ba732881ffe9_thumbnail_900x.webp', 'Baseball Jacket',360000 , 50, 'Canifa', 'Made In VietNam', ' Black', 'Cotton', 'Manfinity Homme Men Plus Size Casual Solid Color Baseball Jacket', 14),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/01/bb/17014235990688c226d76edf2c76505a8560628183_thumbnail_900x.webp', 'Striped Baseball Jacket',279000 , 50, 'Yody', 'Made In China', 'Black', 'Cotton', 'Manfinity Homme Letter Printed Striped Baseball Jacket', 14),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/27/e1/17036678037dd8a676c130303b8295cfccca77eb87_thumbnail_900x.webp', 'Letter Patchwork Detail',400000 , 50, 'OWen', 'Made In Indonesia', 'Khaki', 'Cotton', 'Manfinity Homme Men Loose Fit Corduroy Jacket With Letter Patchwork Detail And Teddy Lining', 14),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/18/11/170554759311c5712947a666fb95a90d3abe7fbe9d_thumbnail_900x.webp', 'Hooded Jacket',510000 , 50, 'Gumac', 'Made In VietNam', 'Black', 'Cotton', 'Manfinity RSRT Men Letter Graphic Drawstring Hem Hooded Jacket', 14),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/01/bf/169883790163c2d14539594f5e4b6498c1a3068b6d_thumbnail_900x.webp', 'Printed Athletic Jacket',500000 , 50, 'Tingoan', 'Made In VietNam', 'Khaki', 'Cotton', 'Manfinity Homme Men Extended Sizes Men Plus Letter Printed Athletic Jacket', 14),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/16/2c/171578935557f9f81edd5f07e8981f91a5b5450f16_thumbnail_900x.webp', 'Simple Hooded Jacket',670000 , 50, 'Gumac', 'Made In VietNam', 'Black', 'Cotton', 'Manfinity Homme Men Solid Color Simple Hooded Jacket & Coat For Daily Wear', 14),
    ('https://img.ltwebstatic.com/images3_pi/2023/05/23/1684806668a4d826d7c1fcee2957044e0990f58645_thumbnail_900x.webp', 'Flap Pocket Vest',260000, 50, 'Gucci', 'Made In USA', 'Apricot', 'Cotton', 'Manfinity Hypemode Men Flap Pocket Vest Without Tee', 14);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2023/05/08/1683527853ff3c79511ef8c5cdc40f47efc3ab36d4_thumbnail_900x.webp', 'Waist Swim Trunks',180000 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'Manfinity Swimmode Men Tropical Print Drawstring Waist Swim Trunks Sleeve Casual T-Shirt', 15),
    ('https://img.ltwebstatic.com/images3_pi/2022/07/28/165899615135bff9e719162fd06127bb1482816791_thumbnail_900x.webp', 'Contrast Trim',100000 , 50, 'Canifa', 'Made In VietNam', 'Navy Blue', 'Cotton', 'Manfinity Swimmode Men Contrast Trim Drawstring Waist Swim Trunks', 15),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/05/72/17071074224a7f9fc867e278a0cb3a7b7abb312785_thumbnail_900x.webp', 'Waist Beach Shorts',89000 , 50, 'Yody', 'Made In China', 'Multicolor', 'Cotton', 'Manfinity Homme Loose Plus Size Gradient Color Drawstring Waist Beach Shorts', 15),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/20/ec/171617242530d5ce2514d8a5c914981768fbf35703_thumbnail_900x.webp', 'Vacation Leopard Print',150000 , 50, 'OWen', 'Made In Indonesia', 'Multicolor', 'Cotton', 'Manfinity Mens Vacation Leopard Print Drawstring Elastic Waist Loose Fit Beach Shorts', 15),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/27/9c/1716810190b445b078c9feaacc397b69a90bc06529_thumbnail_900x.webp', 'Casual Beach Shorts',169000 , 50, 'Gumac', 'Made In VietNam', 'Black and White', 'Cotton', 'Mens Plus Size Cow Print Drawstring Waist Holiday Casual Beach Shorts', 15),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/17/1f/17159305548c55c739e844e280a47a3dbe785e3530_thumbnail_900x.webp', 'Eagle Printed Drawstring',130000 , 50, 'Tingoan', 'Made In VietNam', 'Dark Grey', 'Cotton', 'Manfinity Homme Men Summer Holiday 3D Eagle Printed Drawstring Waist Beach Shorts', 15),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/19/54/1716048104e98edc215317a2c58419a0051a4ffa0d_thumbnail_900x.webp', ' Summer Vacation',140000 , 50, 'Gumac', 'Made In VietNam', 'Dark Orange', 'Cotton', 'Manfinity Homme Men Summer Vacation 3D Palm Tree Printed Drawstring Waist Beach Shorts', 15),
    ('https://img.ltwebstatic.com/images3_pi/2023/05/30/1685440660a7222733708806a08b15ca9ace241e39_thumbnail_900x.webp', 'Compression Liner',210000 , 50, 'Gucci', 'Made In USA', 'Blue and White', 'Cotton', 'Manfinity Swimmode Men Striped Drawstring Waist Swim Trunks & Compression Liner', 15);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/04/24/89/17139362099cb08deb626aea7d6d7c526d8b311ee7_thumbnail_900x.webp', 'Straight Overalls Trousers',145000 , 50, 'Gumac', 'Made In VietNam', 'Navy Green', 'Cotton', 'Manfinity Homme Men Fashionable Loose Straight Overalls Trousers, Casual', 16),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/02/53/1698911463c1e8c386998159dfc391a3cf91a29eb2_thumbnail_900x.webp', 'Dungarees Jumpsuit',230000 , 50, 'Canifa', 'Made In VietNam', 'Khaki', 'Cotton', 'Manfinity Homme Men Loose Fit Plus Size Solid Color Straight Leg Dungarees Jumpsuit', 16),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/02/e1/1712059178ebf847db18ba7ea1765b4b7c2b87bd97_thumbnail_900x.webp', 'Drawstring Waist Romper',119000 , 50, 'Yody', 'Made In China', 'Grey', 'Cotton', 'Manfinity Homme Loose Plus Size Stand Collar Drawstring Waist Romper', 16),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/14/da/1715656065e48cafbf4565e7371699b8352d06cb41_thumbnail_900x.webp', 'Short-Sleeved Jumpsuit',430000 , 50, 'OWen', 'Made In Indonesia', 'Navy Khaki', 'Cotton', 'Manfinity Homme Men Spring/Summer Casual Solid Color Short-Sleeved Jumpsuit', 16),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/22/ba/17006418091a733434280f9ede607945cf79606bf1_thumbnail_900x.webp', 'Lined Denim Overalls',280000 , 50, 'Gumac', 'Made In VietNam', 'Blue', 'Cotton', 'Manfinity Hypemode Plus Size Mens Flap Pocket Workwear Thermal Lined Denim Overalls', 16),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/19/47/17135188235291dad03a5c8965fd494873198f4325_thumbnail_900x.webp', 'Jumpsuit With Pockets',219000 , 50, 'Tingoan', 'Made In VietNam', 'Black', 'Cotton', 'Manfinity CasualCool Men Casual Solid Color Drawstring Waist Jumpsuit With Pockets, Spring/Summer Cargo Men Shorts', 16),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/04/17/1707034322a014be39a12933822db24f1b45e79de4_thumbnail_900x.webp', 'Overalls With Braces',179000 , 50, 'Gumac', 'Made In VietNam', 'Navy Grey', 'Cotton', 'Manfinity Homme Men Plus Size Casual Overalls With Braces', 16),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/27/42/17090117908bf576f384dc6ce78648a50c1f1a939e_thumbnail_900x.webp', 'Casual Shirt Romper',263000 , 50, 'Gucci', 'Made In USA', 'Moss Brown', 'Cotton', 'Manfinity Homme Men Short Sleeve Woven Casual Shirt Romper', 16);
	
	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_spmp/2023/11/14/f7/1699969454a78fd6c4384747e4d700a685bcb7e1b4_thumbnail_900x.webp', '5pairs/pack Kids Socks',66000 , 50, 'Gumac', 'Made In VietNam', 'Mixture', 'Cotton', '5pairs/pack Kids Socks, College Style Two-bar Striped Sport Socks, Unisex Baby Socks, White Mid-calf Socks For Students', 17),
    ('https://img.ltwebstatic.com/images3_spmp/2023/12/23/c8/1703291404713a19b36eac546b50d2ee12ab2c2315_thumbnail_900x.webp', '5 Pairs Unisex Kids',50000 , 50, 'Canifa', 'Made In VietNam', 'Mixture', 'Cotton', '5 Pairs Unisex Kids Mesh Thin Korean Style Athletic Socks, Spring/Summer', 17),
    ('https://img.ltwebstatic.com/images3_spmp/2023/12/24/bb/170338967360f9fbb313193d6058dc593bd44b6ff6_thumbnail_900x.webp', '5pairs Kids Cartoon',55000 , 50, 'Yody', 'Made In China', 'Mixture', 'Cotton', '5pairs Kids Cartoon Floral And Candy Pattern Mid-Calf Socks For Girls, Breathable And Comfortable, Suitable For Four Seasons', 17),
    ('https://img.ltwebstatic.com/images3_spmp/2023/08/19/3c/169241515488941dba1cb6a3bda317cefac972d8a8_thumbnail_900x.webp', '1pc Girls Red Basic Leggings',39000 , 50, 'OWen', 'Made In Indonesia', 'Red', 'Cotton', '1pc Girls Red Basic Leggings With Bowknot Decoration, All Seasons Shorts', 17),
    ('https://img.ltwebstatic.com/images3_spmp/2023/10/29/45/169856985892b4be89f91565307c8cf55139ca3b66_thumbnail_900x.webp', '5pairs Kids Trendy',50000 , 50, 'Gumac', 'Made In VietNam', 'Mixture', 'Cotton', '5pairs Kids Trendy Spring/autumn Casual Medium-tube Socks, Breathable And Durable For Daily Wear', 17),
    ('https://img.ltwebstatic.com/images3_spmp/2024/04/12/c0/17128928811ce2dfbaebe1d7b47d171ae6bb6799c8_thumbnail_900x.webp', '5pairs Girls Cute Strawberry',59000 , 50, 'Tingoan', 'Made In VietNam', 'Pink', 'Cotton', '5pairs Girls Cute Strawberry Bubble Mouth & Lace Trim Short Socks, Suitable For Spring And Summer', 17),
    ('https://img.ltwebstatic.com/images3_spmp/2023/12/12/af/17023650087d93986800d5166905fd0eb705e4ea6b_thumbnail_900x.webp', '5 Pairs Of Cute Dinosaur',61000 , 50, 'Gumac', 'Made In VietNam', 'Mixture', 'Cotton', '5 Pairs Of Cute Dinosaur Crocodile Fashionable And Versatile Daily Mid-Calf Socks For Men And Women', 17),
    ('https://img.ltwebstatic.com/images3_spmp/2024/03/27/6b/171151981435e611b296be35b7f6d81840b0d91778_thumbnail_900x.webp', '3 Pairs Of White Princess',89000 , 50, 'Gucci', 'Made In USA', 'White', 'Cotton', '3 Pairs Of White Princess Style Lace Mesh Breathable Lace Socks For Girls, Suitable For Daily Wear', 17);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/03/27/ca/17115098622516b62fb5e2351ba559cad2342f9a99_thumbnail_900x.webp', 'Newborn Baby Girl',120000 , 50, 'Gumac', 'Made In VietNam', 'Mixture', 'Cotton', 'SHEIN Newborn Baby Girl Leopard Print Sleeveless Jumpsuit, Casual And Lovely, Matching Mother And Me Outfits', 18),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/27/10/17167907479309fd0236980e057275314f6992e900_thumbnail_900x.webp', 'Corduroy Solid Color',139000 , 50, 'Canifa', 'Made In VietNam', 'White & Brown', 'Cotton', 'SHEIN Newborn Baby Girl Casual Corduroy Solid Color Overalls Shorts, Elastic Waist Strap', 18),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/12/71/17050405508df5dc1b6e089d74e67e2293fbdff527_thumbnail_900x.webp', 'Short Sleeve T-Shirt',32000 , 50, 'Yody', 'Made In China', 'Yellow', 'Cotton', 'SHEIN Young Girls Cartoon Printed Short Sleeve T-Shirt', 18),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/02/3a/171202762551200971b743c2163215cdfd96a124d4_thumbnail_900x.webp', 'Romper With Cross Neck',109000 , 50, 'OWen', 'Made In Indonesia', 'Green', 'Cotton', 'Baby Girl Solid Color Romper With Cross Neck & Textured Fabric Design, Perfect For Summer Vacation', 18),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/06/98/171239035873454dd431a662283aa9d2a2c8be760a_thumbnail_900x.webp', 'Letter Slogan Print',76000 , 50, 'Gumac', 'Made In VietNam', 'White', 'Cotton', 'Young Boy Casual Short Sleeve Round Neck T-Shirt With Letter Slogan Print', 18),
    ('https://img.ltwebstatic.com/images3_pi/2024/03/29/c1/1711688331bb27a23983e5658c26ea438710ddc567_thumbnail_900x.webp', 'Teen Girl Sweet',209000 , 50, 'Tingoan', 'Made In VietNam', 'Pink', 'Cotton', 'Teen Girl Sweet And Comfortable Blouse Collar Mesh Ruffle Sleeve Top And Nine Points Long Pants Home Wedding Flower Girl Party Two-Piece Set Sibling Outfits Mathing Outfits (2 Sets Are Sold Separately)', 18),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/21/98/1703152125905bda9010851dbeebbddc2d81a43907_thumbnail_900x.webp', 'Tween Girl Knitted',98000 , 50, 'Gumac', 'Made In VietNam', 'Pink', 'Cotton', 'Tween Girl Knitted Solid Color Vest Romper With Decorative Buttons, Removable Belt And Suit Collar, Matching Mommy And Me Outfits (2 Pieces Sold Separately)', 18),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/12/01/17023591381f3514e555dc264677e6ee17ff8d7900_thumbnail_900x.webp', 'Sweatpants Two-Piece',150000 , 50, 'Gucci', 'Made In USA', 'Brown', 'Cotton', 'Baby Boy Hooded Sweatshirt And Sweatpants Two-Piece Set Dad And Me (2 Sets Sold Separately)', 18);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2023/06/30/1688109089626eac631cd1fb779a8a1d158b05eec3_thumbnail_900x.webp', 'Pattern Pink Jacket',67000 , 50, 'Gumac', 'Made In VietNam', 'Pink', 'Cotton', 'Young Girl Rainbow Unicorn Fun Pattern Pink Jacket', 19),
    ('https://img.ltwebstatic.com/images3_pi/2022/10/19/1666165316bdcace2c5e4c9fcc89ba5a65d4796d4c_thumbnail_900x.webp', 'Young Girl Cherry',125000 , 50, 'Canifa', 'Made In VietNam', 'White', 'Cotton', 'Young Girl Cherry Embroidery Drop Shoulder Duster Cardigan', 19),
    ('https://img.ltwebstatic.com/images3_spmp/2024/02/01/8f/17067545811368a5d8ac5f4ab1a6ca8099d8c1f684_thumbnail_900x.webp', 'Including Breathable Ruffle',99000 , 50, 'Yody', 'Made In China', 'Pink', 'Cotton', '2pcs Young Girls Casual And Adorable Outfit, Including Breathable Ruffle Top And Flower Printed Cinching Waist Sundress For Spring And Summer', 19),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/16/47/1702707992178fddb88e13173f61dcdf641193cffb_thumbnail_900x.webp', 'Heart Pattern Short ',32000 , 50, 'OWen', 'Made In Indonesia', 'Pink', 'Cotton', 'Young Girls Casual Heart Pattern Short Sleeve T-Shirt, Suitable For Summer', 19),
    ('https://img.ltwebstatic.com/images3_pi/2023/03/23/167954329526928ead23b554824b3c58fb98552faa_thumbnail_900x.webp', 'Toddler Girls Tropical',76000 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'Young Girl Toddler Girls Tropical Print Belted Romper', 19),
    ('https://img.ltwebstatic.com/images3_pi/2022/12/29/16722851688012d568acf698fa6e09d2723fa545c5_thumbnail_900x.webp', 'Girl Cartoon Graphic',98000 , 50, 'Tingoan', 'Made In VietNam', 'White', 'Cotton', 'Young Girl Cartoon Graphic Ruffle Trim Tee & Belted Shorts', 19),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/15/32/1700017692f97a43018635512803fdd95681e68d35_thumbnail_900x.webp', 'Hand Gesture Print',70000 , 50, 'Gumac', 'Made In VietNam', 'Coral Pink', 'Cotton', 'Young Girl Short Sleeve T-Shirt With Lettering And Hand Gesture Print, Perfect For Summer', 19),
    ('https://img.ltwebstatic.com/images3_spmp/2023/09/01/53/1693561117ad5a05ec8aaf8d5a80c728393e01e5a3_thumbnail_900x.webp', 'Lovely Ruffled Lace',123000 , 50, 'Gucci', 'Made In USA', 'Red and White', 'Cotton', 'Girls Lovely Ruffled Lace Decorated Tank Top & Shorts Set', 19);

	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/03/29/d8/1711697018cd5d4b3549e8b8c3d35b0620eabb09bd_thumbnail_900x.webp', 'Elegant Spaghetti',119000 , 50, 'Gumac', 'Made In VietNam', 'Navy Blue', 'Cotton', 'SHEIN Teen Girl Elegant Spaghetti Strap Dress With Floral Print And Mesh Overlay For Summer', 21),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/25/d1/1714031625cb6b8dd7cbdfe10f5582449f48999765_thumbnail_900x.webp', 'Ditsy Floral Print Ruffle',209000 , 50, 'Canifa', 'Made In VietNam', 'Multicolor', 'Cotton', 'Teen Girls Ditsy Floral Print Ruffle Trim Ruched Bust Two Layer Hem Dress', 21),
    ('https://img.ltwebstatic.com/images3_pi/2023/11/27/77/1701051971be298c0343bafa4a9eb8ac8d46e865ed_thumbnail_900x.webp', 'Hooded Casual Sweatshirt',170000 , 50, 'Yody', 'Made In China', 'Black', 'Cotton', 'Manfinity Homme Teen Girls Hooded Casual Sweatshirt With Text Print', 21),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/22/97/17163456996301662783cb1504d04828300be74525_thumbnail_900x.webp', 'Woven Blue Ditsy',240000 , 50, 'OWen', 'Made In Indonesia', 'Blue', 'Cotton', 'Teen Girls Woven Blue Ditsy Floral Print Spaghetti Strap Dress With Bowknot And Tiered Ruffle Hem', 21),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/01/f1/17067824625c797afbb5314cfe1c1e7912082328a0_thumbnail_900x.webp', 'Leopard Heart',170000 , 50, 'Gumac', 'Made In VietNam', 'White', 'Cotton', 'Teen Girl Leopard Heart Print Tee', 21),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/23/23/170329742834e554e09864cbe1398f2167cc62f019_thumbnail_900x.webp', 'Sports Skirt',142000 , 50, 'Tingoan', 'Made In VietNam', 'Pink', 'Cotton', 'Teenage Girls Knit Solid Color Sports Skirt With Built-In Shorts And Pockets', 21),
    ('https://img.ltwebstatic.com/images3_pi/2021/05/13/1620876219536fbcbab3bc447a7ac502f67d0f22ba_thumbnail_900x.webp', 'Waist Halter Romper',168000 , 50, 'Gumac', 'Made In VietNam', 'Multicolor', 'Cotton', 'Teen Girls Floral Print Knot Waist Halter Romper Drawstring Waist Cargo Shorts', 21),
    ('https://img.ltwebstatic.com/images3_spmp/2024/05/16/80/171585005153706aaad6538f4e13800b248e580894_thumbnail_900x.webp', 'Flared Long Pants',205000 , 50, 'Gucci', 'Made In USA', 'Pink', 'Cotton', 'Teen Girl Summer Fashion Solid Color Open Shoulder Tank Top & Flared Long Pants Two Piece Set', 21);

	
	INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://img.ltwebstatic.com/images3_pi/2024/04/07/ec/17124569896c3953c939e00940ae1d8f1c07e43b9d_thumbnail_900x.webp', 'Vest Gentleman Suit',89000 , 50, 'Gumac', 'Made In VietNam', 'White Blue', 'Cotton', 'Teen Boy 2-Piece Elegant Business Style Blue Vest Gentleman Suit Set Including 1 Vest And 1 Pant', 24),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/04/39/17043554341e486098d52d363994f8ac93446a0651_thumbnail_900x.webp', 'Sleeved T-Shirt',99000 , 50, 'Canifa', 'Made In VietNam', 'Black', 'Cotton', 'Teen Boys Print Short-Sleeved T-Shirt Graffiti Print Jumper', 24),
    ('https://img.ltwebstatic.com/images3_pi/2024/01/02/af/17041768538da68141904725972f0d8545396f3e05_thumbnail_900x.webp', 'Smiling Face Printed',112000 , 50, 'Yody', 'Made In China', 'Grey', 'Cotton', 'Teen Boys Smiling Face Printed T-shirt And Shorts Set Round Neck Sweater', 24),
    ('https://img.ltwebstatic.com/images3_pi/2024/05/29/25/17169811899069d738d6ff06b0df28d0f80f2ece1f_thumbnail_900x.webp', 'Collar Jacket',129000 , 50, 'OWen', 'Made In Indonesia', 'Blue', 'Cotton', 'Teenage Boys Solid Color Casual Collar Jacket With Single-Breasted Button', 24),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/04/ca/170702177798e25b1b0d88b55ec3ef07813e6dcb81_thumbnail_900x.webp', 'Shark Print Beach Shorts',79000 , 50, 'Gumac', 'Made In VietNam', 'Black', 'Cotton', 'Teen Boy Vacation Style Shark Print Beach Shorts & Daddy And Me Matching Outfits (2 Pieces Sold Separately)', 24),
    ('https://img.ltwebstatic.com/images3_pi/2024/02/27/9c/1709022384578e64abbacd9727b3c5e851b65371e3_thumbnail_900x.webp', 'Tropical Plant Leaf',187000 , 50, 'Tingoan', 'Made In VietNam', 'White', 'Cotton', 'SHEIN Teen Boys Casual Tropical Plant Leaf Print Short Sleeve Shirt And Drawstring Shorts 2pcs Outfit, Summer', 24),
    ('https://img.ltwebstatic.com/images3_pi/2024/04/03/3d/171213602346e1ff60e5825eada24ae8c4488ba656_thumbnail_900x.webp', 'Sports Crown',135000 , 50, 'Gumac', 'Made In VietNam', 'Army Green', 'Cotton', 'Two-Piece Set Teen Boy Casual Sports Crown & Letter Printed Short-Sleeved T-Shirt And Shorts For Summer', 24),
    ('https://img.ltwebstatic.com/images3_pi/2023/12/18/85/1702878093095479142ab60fc7ac81e7cf86d6e962_thumbnail_900x.webp', 'Card Printed Short',100000 , 50, 'Gucci', 'Made In USA', 'White', 'Cotton', 'Teen Boys Casual Skull & Playing Card Printed Short Sleeve T-Shirt, Suitable For Summer', 24);

select * from products join product_sizes on products.id = product_sizes.product_id

select * from product_sizes
-- Insert sample data into product_sizes
INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,1), ('M', 50, 1), ('L', 50,1), ('XL', 50,1);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,2), ('M', 50, 2), ('L', 50,2), ('XL', 50,2);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,3), ('M', 50, 3), ('L', 50,3), ('XL', 50,3);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,4), ('M', 50, 4), ('L', 50,4), ('XL', 50,4);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,5), ('M', 50, 5), ('L', 50,5), ('XL', 50,5);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,6), ('M', 50, 6), ('L', 50,6), ('XL', 50,6);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,7), ('M', 50, 7), ('L', 50,7), ('XL', 50,7);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,8), ('M', 50, 8), ('L', 50,8), ('XL', 50,8);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,9), ('M', 50, 9), ('L', 50,9), ('XL', 50,9);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,10), ('M', 50, 10), ('L', 50,10), ('XL', 50,10);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,11), ('M', 50, 11), ('L', 50,11), ('XL', 50,11);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,12), ('M', 50, 12), ('L', 50,12), ('XL', 50,12);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,13), ('M', 50, 13), ('L', 50,13), ('XL', 50,13);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,14), ('M', 50, 14), ('L', 50,14), ('XL', 50,14);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,15), ('M', 50, 15), ('L', 50,15), ('XL', 50,15);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,16), ('M', 50, 16), ('L', 50,16), ('XL', 50,16);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,17), ('M', 50, 17), ('L', 50,17), ('XL', 50,17);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,18), ('M', 50, 18), ('L', 50,18), ('XL', 50,18);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,19), ('M', 50, 19), ('L', 50,19), ('XL', 50,19);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,20), ('M', 50, 20), ('L', 50,20), ('XL', 50,20);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,21), ('M', 50, 21), ('L', 50,21), ('XL', 50,21);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,22), ('M', 50, 22), ('L', 50,22), ('XL', 50,22);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,23), ('M', 50, 23), ('L', 50,23), ('XL', 50,23);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,24), ('M', 50, 24), ('L', 50,24), ('XL', 50,24);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,25), ('M', 50, 25), ('L', 50,25), ('XL', 50,25);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,26), ('M', 50, 26), ('L', 50,26), ('XL', 50,26);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,27), ('M', 50, 27), ('L', 50,27), ('XL', 50,27);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,28), ('M', 50, 28), ('L', 50,28), ('XL', 50,28);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,29), ('M', 50, 29), ('L', 50,29), ('XL', 50,29);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,30), ('M', 50, 30), ('L', 50,30), ('XL', 50,30);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,31), ('M', 50, 31), ('L', 50,31), ('XL', 50,31);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,32), ('M', 50, 32), ('L', 50,32), ('XL', 50,32);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,33), ('M', 50, 33), ('L', 50,33), ('XL', 50,33);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,34), ('M', 50, 34), ('L', 50,34), ('XL', 50,34);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,35), ('M', 50, 35), ('L', 50,35), ('XL', 50,35);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,36), ('M', 50, 36), ('L', 50,36), ('XL', 50,36);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,37), ('M', 50, 37), ('L', 50,37), ('XL', 50,37);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,38), ('M', 50, 38), ('L', 50,38), ('XL', 50,38);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,39), ('M', 50, 39), ('L', 50,39), ('XL', 50,39);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,40), ('M', 50, 40), ('L', 50,40), ('XL', 50,40);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,41), ('M', 50, 41), ('L', 50,41), ('XL', 50,41);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,42), ('M', 50, 42), ('L', 50,42), ('XL', 50,42);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,43), ('M', 50, 43), ('L', 50,43), ('XL', 50,43);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,44), ('M', 50, 44), ('L', 50,44), ('XL', 50,44);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,45), ('M', 50, 45), ('L', 50,45), ('XL', 50,45);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,46), ('M', 50, 46), ('L', 50,46), ('XL', 50,46);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,47), ('M', 50, 47), ('L', 50,47), ('XL', 50,47);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,48), ('M', 50, 48), ('L', 50,48), ('XL', 50,48);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,49), ('M', 50, 49), ('L', 50,49), ('XL', 50,49);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,50), ('M', 50, 50), ('L', 50,50), ('XL', 50,50);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,51), ('M', 50, 51), ('L', 50,51), ('XL', 50,51);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,52), ('M', 50, 52), ('L', 50,52), ('XL', 50,52);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,53), ('M', 50, 53), ('L', 50,53), ('XL', 50,53);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,54), ('M', 50, 54), ('L', 50,54), ('XL', 50,54);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,55), ('M', 50, 55), ('L', 50,55), ('XL', 50,55);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,56), ('M', 50, 56), ('L', 50,56), ('XL', 50,56);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,58), ('M', 50, 58), ('L', 50,58), ('XL', 50,58);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,59), ('M', 50, 59), ('L', 50,59), ('XL', 50,59);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,60), ('M', 50, 60), ('L', 50,60), ('XL', 50,60);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,61), ('M', 50, 61), ('L', 50,61), ('XL', 50,61);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,62), ('M', 50, 62), ('L', 50,62), ('XL', 50,62);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,63), ('M', 50, 63), ('L', 50,63), ('XL', 50,63);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,64), ('M', 50, 64), ('L', 50,64), ('XL', 50,64);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,65), ('M', 50, 65), ('L', 50,65), ('XL', 50,65);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,66), ('M', 50, 66), ('L', 50,66), ('XL', 50,66);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,67), ('M', 50, 67), ('L', 50,67), ('XL', 50,67);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,68), ('M', 50, 68), ('L', 50,68), ('XL', 50,68);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,69), ('M', 50, 69), ('L', 50,69), ('XL', 50,69);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,70), ('M', 50, 70), ('L', 50,70), ('XL', 50,70);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,71), ('M', 50, 71), ('L', 50,71), ('XL', 50,71);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,72), ('M', 50, 72), ('L', 50,72), ('XL', 50,72);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,73), ('M', 50, 73), ('L', 50,73), ('XL', 50,73);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,74), ('M', 50, 74), ('L', 50,74), ('XL', 50,74);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,75), ('M', 50, 75), ('L', 50,75), ('XL', 50,75);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,76), ('M', 50, 76), ('L', 50,76), ('XL', 50,76);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,77), ('M', 50, 77), ('L', 50,77), ('XL', 50,77);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,78), ('M', 50, 78), ('L', 50,78), ('XL', 50,78);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,79), ('M', 50, 79), ('L', 50,79), ('XL', 50,79);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,80), ('M', 50, 80), ('L', 50,80), ('XL', 50,80);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,81), ('M', 50, 81), ('L', 50,81), ('XL', 50,81);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,82), ('M', 50, 82), ('L', 50,82), ('XL', 50,82);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,83), ('M', 50, 83), ('L', 50,83), ('XL', 50,83);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,84), ('M', 50, 84), ('L', 50,84), ('XL', 50,84);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,85), ('M', 50, 85), ('L', 50,85), ('XL', 50,85);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,86), ('M', 50, 86), ('L', 50,86), ('XL', 50,86);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,87), ('M', 50, 87), ('L', 50,87), ('XL', 50,87);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,88), ('M', 50, 88), ('L', 50,88), ('XL', 50,88);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,89), ('M', 50, 89), ('L', 50,89), ('XL', 50,89);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,90), ('M', 50, 90), ('L', 50,90), ('XL', 50,90);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,91), ('M', 50, 91), ('L', 50,91), ('XL', 50,91);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,92), ('M', 50, 92), ('L', 50,92), ('XL', 50,92);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,93), ('M', 50, 93), ('L', 50,93), ('XL', 50,93);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,94), ('M', 50, 94), ('L', 50,94), ('XL', 50,94);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,95), ('M', 50, 95), ('L', 50,95), ('XL', 50,95);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,96), ('M', 50, 96), ('L', 50,96), ('XL', 50,96);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,97), ('M', 50, 97), ('L', 50,97), ('XL', 50,97);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,98), ('M', 50, 98), ('L', 50,98), ('XL', 50,98);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,99), ('M', 50, 99), ('L', 50,99), ('XL', 50,99);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,100), ('M', 50, 100), ('L', 50,100), ('XL', 50,100);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,101), ('M', 50, 101), ('L', 50,101), ('XL', 50,101);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,102), ('M', 50, 102), ('L', 50,102), ('XL', 50,102);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,103), ('M', 50, 103), ('L', 50,103), ('XL', 50,103);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,104), ('M', 50, 104), ('L', 50,104), ('XL', 50,104);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,105), ('M', 50, 105), ('L', 50,105), ('XL', 50,105);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,106), ('M', 50, 106), ('L', 50,106), ('XL', 50,106);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,107), ('M', 50, 107), ('L', 50,107), ('XL', 50,107);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,108), ('M', 50, 108), ('L', 50,108), ('XL', 50,108);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,109), ('M', 50, 109), ('L', 50,109), ('XL', 50,109);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,110), ('M', 50, 110), ('L', 50,110), ('XL', 50,110);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,111), ('M', 50, 111), ('L', 50,111), ('XL', 50,111);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,112), ('M', 50, 112), ('L', 50,112), ('XL', 50,112);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,113), ('M', 50, 113), ('L', 50,113), ('XL', 50,113);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,114), ('M', 50, 114), ('L', 50,114), ('XL', 50,114);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,115), ('M', 50, 115), ('L', 50,115), ('XL', 50,115);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,116), ('M', 50, 116), ('L', 50,116), ('XL', 50,116);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,117), ('M', 50, 117), ('L', 50,117), ('XL', 50,117);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,118), ('M', 50, 118), ('L', 50,118), ('XL', 50,118);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,119), ('M', 50, 119), ('L', 50,119), ('XL', 50,119);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,120), ('M', 50, 120), ('L', 50,120), ('XL', 50,120);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,121), ('M', 50, 121), ('L', 50,121), ('XL', 50,121);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,122), ('M', 50, 122), ('L', 50,122), ('XL', 50,122);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,123), ('M', 50, 123), ('L', 50,123), ('XL', 50,123);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,124), ('M', 50, 124), ('L', 50,124), ('XL', 50,124);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,125), ('M', 50, 125), ('L', 50,125), ('XL', 50,125);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,126), ('M', 50, 126), ('L', 50,126), ('XL', 50,126);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,127), ('M', 50, 127), ('L', 50,127), ('XL', 50,127);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,128), ('M', 50, 128), ('L', 50,128), ('XL', 50,128);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,129), ('M', 50, 129), ('L', 50,129), ('XL', 50,129);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,130), ('M', 50, 130), ('L', 50,130), ('XL', 50,130);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,131), ('M', 50, 131), ('L', 50,131), ('XL', 50,131);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,132), ('M', 50, 132), ('L', 50,132), ('XL', 50,132);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,133), ('M', 50, 133), ('L', 50,133), ('XL', 50,133);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,134), ('M', 50, 134), ('L', 50,134), ('XL', 50,134);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,135), ('M', 50, 135), ('L', 50,135), ('XL', 50,135);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,136), ('M', 50, 136), ('L', 50,136), ('XL', 50,136);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,137), ('M', 50, 137), ('L', 50,137), ('XL', 50,137);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,138), ('M', 50, 138), ('L', 50,138), ('XL', 50,138);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,139), ('M', 50, 139), ('L', 50,139), ('XL', 50,139);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,140), ('M', 50, 140), ('L', 50,140), ('XL', 50,140);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,141), ('M', 50, 141), ('L', 50,141), ('XL', 50,141);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,142), ('M', 50, 142), ('L', 50,142), ('XL', 50,142);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,143), ('M', 50, 143), ('L', 50,143), ('XL', 50,143);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,144), ('M', 50, 144), ('L', 50,144), ('XL', 50,144);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,145), ('M', 50, 145), ('L', 50,145), ('XL', 50,145);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,146), ('M', 50, 146), ('L', 50,146), ('XL', 50,146);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,147), ('M', 50, 147), ('L', 50,147), ('XL', 50,147);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,148), ('M', 50, 148), ('L', 50,148), ('XL', 50,148);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,149), ('M', 50, 149), ('L', 50,149), ('XL', 50,149);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,150), ('M', 50, 150), ('L', 50,150), ('XL', 50,150);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,151), ('M', 50, 151), ('L', 50,151), ('XL', 50,151);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,152), ('M', 50, 152), ('L', 50,152), ('XL', 50,152);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,153), ('M', 50, 153), ('L', 50,153), ('XL', 50,153);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,154), ('M', 50, 154), ('L', 50,154), ('XL', 50,154);
  INSERT INTO product_sizes (size, quantity, product_id) VALUES ('S', 50,155), ('M', 50, 155), ('L', 50,155), ('XL', 50,155);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('http://example.com/product1_img1.jpg', 1),
('http://example.com/product2_img1.jpg', 2),
('http://example.com/product3_img1.jpg', 3),
('http://example.com/product4_img1.jpg', 4),
('http://example.com/product5_img1.jpg', 5),
('http://example.com/product6_img1.jpg', 6),
('http://example.com/product7_img1.jpg', 7),
('http://example.com/product8_img1.jpg', 8),
('http://example.com/product9_img1.jpg', 9),
('http://example.com/product10_img1.jpg', 10);

-- Insert data into accounts
INSERT INTO accounts (username, [password], email, full_name, phone, [address], [role]) VALUES
('user1', 'pass1', 'user1@example.com', 'User One', '1234567890', '123 Example St, City', 'customer'),
('user2', 'pass2', 'user2@example.com', 'User Two', '1234567891', '124 Example St, City', 'customer'),
('user3', 'pass3', 'user3@example.com', 'User Three', '1234567892', '125 Example St, City', 'customer'),
('user4', 'pass4', 'user4@example.com', 'User Four', '1234567893', '126 Example St, City', 'customer'),
('user5', 'pass5', 'user5@example.com', 'User Five', '1234567894', '127 Example St, City', 'customer'),
('user6', 'pass6', 'user6@example.com', 'User Six', '1234567895', '128 Example St, City', 'customer'),
('user7', 'pass7', 'user7@example.com', 'User Seven', '1234567896', '129 Example St, City', 'customer'),
('user8', 'pass8', 'user8@example.com', 'User Eight', '1234567897', '130 Example St, City', 'customer'),
('user9', 'pass9', 'user9@example.com', 'User Nine', '1234567898', '131 Example St, City', 'customer'),
('user10', 'pass10', 'user10@example.com', 'User Ten', '1234567899', '132 Example St, City', 'customer');

-- Insert data into favorites
INSERT INTO favorites (account_id, product_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert data into feedbacks
INSERT INTO feedbacks (rate, content, create_date, [status], account_id, product_id) VALUES
(5, 'Great product!', '2023-01-01 10:00:00', 1, 1, 1),
(4, 'Good value for money.', '2023-02-01 11:00:00', 1, 2, 2),
(3, 'Average quality.', '2023-03-01 12:00:00', 1, 3, 3),
(5, 'Excellent!', '2023-04-01 13:00:00', 1, 4, 4),
(2, 'Not as expected.', '2023-05-01 14:00:00', 0, 5, 5),
(4, 'Satisfied.', '2023-06-01 15:00:00', 1, 6, 6),
(5, 'Will buy again.', '2023-07-01 16:00:00', 1, 7, 7),
(3, 'Okay.', '2023-08-01 17:00:00', 1, 8, 8),
(4, 'Pretty good.', '2023-09-01 18:00:00', 1, 9, 9),
(2, 'Could be better.', '2023-10-01 19:00:00', 0, 10, 10);

-- Insert data into vouchers
INSERT INTO vouchers (code, discount_amount, condition, valid_form, valid_to, create_date) VALUES
('DISCOUNT10', 10.00, 50.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('SAVE20', 20.00, 100.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('OFFER15', 15.00, 75.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('PROMO5', 5.00, 25.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('SALE30', 30.00, 150.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('DEAL25', 25.00, 125.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('DISCOUNT50', 50.00, 200.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('SAVE10', 10.00, 50.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('OFFER20', 20.00, 100.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00'),
('PROMO15', 15.00, 75.00, '2023-01-01 00:00:00', '2023-12-31 23:59:59', '2023-01-01 00:00:00');

-- Insert data into orders
INSERT INTO orders (order_date, total_amount, [status], [address], phone, voucher_id, account_id) VALUES
('2023-01-01 10:00:00', 100.00, 'Shipped', '123 Example St, City', '1234567890', 1, 1),
('2023-02-01 11:00:00', 200.00, 'Delivered', '124 Example St, City', '1234567891', 2, 2),
('2023-03-01 12:00:00', 300.00, 'Processing', '125 Example St, City', '1234567892', 3, 3),
('2023-04-01 13:00:00', 400.00, 'Cancelled', '126 Example St, City', '1234567893', 4, 4),
('2023-05-01 14:00:00', 500.00, 'Shipped', '127 Example St, City', '1234567894', 5, 5),
('2023-06-01 15:00:00', 600.00, 'Delivered', '128 Example St, City', '1234567895', 6, 6),
('2023-07-01 16:00:00', 700.00, 'Processing', '129 Example St, City', '1234567896', 7, 7),
('2023-08-01 17:00:00', 800.00, 'Cancelled', '130 Example St, City', '1234567897', 8, 8),
('2023-09-01 18:00:00', 900.00, 'Shipped', '131 Example St, City', '1234567898', 9, 9),
('2023-10-01 19:00:00', 1000.00, 'Delivered', '132 Example St, City', '1234567899', 10, 10);

-- Insert data into order_details
INSERT INTO order_details (quantity, price, size, order_id, product_id) VALUES
(1, 10.00, 'M', 1, 1),
(2, 20.00, 'L', 2, 2),
(3, 30.00, 'XL', 3, 3),
(4, 40.00, 'S', 4, 4),
(5, 50.00, 'M', 5, 5),
(6, 60.00, 'L', 6, 6),
(7, 70.00, 'XL', 7, 7),
(8, 80.00, 'S', 8, 8),
(9, 90.00, 'M', 9, 9),
(10, 100.00, 'L', 10, 10);


--  drop database SweetH_Clothes_Store
