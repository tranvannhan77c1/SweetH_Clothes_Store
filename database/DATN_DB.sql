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
	name nvarchar(255) not null,
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
(N'QUẦN ÁO'), (N'PHỤ KIỆN'), (N'TÚI'), (N'GIÀY'), (N'BỘ SƯU TẬP');

-- Insert into categories
INSERT INTO categories ([name], item_id) VALUES 
(N'Đầm & Jumpsuit', 1), (N'Áo thun nữ', 1), (N'Áo sơ mi nữ', 1), (N'Denim nữ', 1), (N'Quần', 1), (N'Váy', 1), (N'Khoác', 1),
(N'Mắt kính', 2), (N'Vớ', 2),
(N'Túi cỡ nhỏ', 3), (N'Túi cỡ trung', 3), (N'Túi cỡ lớn', 3), (N'Balo', 3), (N'Ví - Clutch', 3),
(N'Giày sandal', 4), (N'Giày cao gót', 4), (N'Giày Sneakers', 4), (N'Giày búp bê', 4), (N'Dép guốc', 4),
(N'Parisian Chic', 5), (N'Summer Ombre', 5), (N'Summer Play', 5), (N'Sunshine Retreat', 5), (N'The Raw MySelf', 5), (N'Love Is In The Air', 5), (N'X-mas', 5), (N'Magic Snow', 5), (N'Panorama Diamond', 5), (N'Panorama City', 5), (N'Lady Moon', 5), (N'Feelin Fall', 5);

-- Insert sample data into products
--1 Đầm & Jumpsuit
go
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/den_jndng023_1_20240719142822_409f5df19ca341f8893f7beca2ced221_master.jpeg', N'Đầm Bí Hạ Vai',499000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm Bí Hạ Vai nữ tính, nổi bật và thu hút. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 1),
	('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_8_20240528181636_048f4c63ac9640b8a6d19e1cf186718a_master.jpeg', N'Đầm Mini Tay Ngắn Nút J',549000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh đen', N'Cotton', N'Trang phục được thiết kế đơn giản tập trung vào chất liệu vải denim cao cấp tạo sự thoải mái tối đa cho người mặc', 1),
	('https://product.hstatic.net/1000003969/product/kem_jndng014_1_20230313202310_d4b02a4bd8244a58846da1987f35b5ef_master.jpeg', N'Đầm Ngắn 2 Dây Cup Ngực',299000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Đầm ngắn 2 dây cup ngực sang trọng, gợi cảm. Trang phục phù hợp dạo phố, thường ngày, đi tiệc', 1),
	('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_2_20230526141427_bd4757e76a2e425b9cea2a7a084446c9_master.jpeg', N'Đầm Sơmi Dáng Dài',499000 , 50, N'Sweet H', N'Made In VietNam', N'Sọc trắng đỏ', N'Cotton', N'Đầm sơmi thun lưng dáng dài thanh lịch, hiện đại. Trang phục phù hợp dạo phố, thường ngày, đi làm...', 1),
	('https://product.hstatic.net/1000003969/product/nau_jndlu063_1_20231011103409_72e78c6330e64dec874da64f74994858_master.jpeg', N'Đầm Thun Ôm Midi',449000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm thun ôm midi thời trang, nữ tính.  Trang phục phù hợp dạo phố, thường ngày,...', 1),
	('https://product.hstatic.net/1000003969/product/nau_jndlu038_13_20221115121450_ef820acb61de4ac99e1d_568bfd0761e34888a490c0631055d7d6_master.jpeg', N'Đầm Ngắn Tay Dài Xếp Ly',349000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm ngắn tay dài xếp ly nữ tính, xinh xắn. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 1),
	('https://product.hstatic.net/1000003969/product/den_jndng016_10_20230918201415_d6dc09c2a0e04cfa8f8755aa4666aa0b_master.jpeg', N'Đầm Caro 2 Dây Smocking',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm caro 2 dây smocking thời trang, nữ tính. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 1),
	('https://product.hstatic.net/1000003969/product/xanh_jndlu046_1_20221019115727_e67e362c9170482788e8_04e0eb75905240558163ed3d977f5e3e_master.jpeg', N'Đầm Mini Cổ Sơ Mi Vai Chờm',399000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Cotton', N'Đầm mini cổ sơ mi vai chờm năng động, thời trang. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 1),
	('https://product.hstatic.net/1000003969/product/den_jndlu054_2_20221205114455_4795f8420b7c43ebbad6687d8e5a0b65_master.jpeg', N'Đầm Mini Phối Ren Cúp Ngực Tay Dài',199000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm mini phối ren cúp ngực tay dài thời trang, gợi cảm. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 1),
	('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_4_20240528180832_31130efa5bcf4ceb8253fd5a9ac1b479_master.jpeg', N'Đầm Maxi 2 Dây Phối Ren',399000 , 50, N'Sweet H', N'Made In VietNam', N'Sọc Xanh', N'Cotton', N'Đầm maxi 2 dây phối ren thời trang, năng động. Đầm 2 dây sọc dọc tạo cảm giác thon thả cho nàng. Phối màu hiện đại', 1);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/den_jndng023_2_20240719142822_181a8ccc2a4d4f409a7d1be6aa8c257c_master.jpeg', 1), ('https://product.hstatic.net/1000003969/product/den_jndng023_3_20240719142822_f1558836467446ac8458a314185b7fd5_master.jpeg', 1), ('https://product.hstatic.net/1000003969/product/den_jndng023_4_20240719142822_44de24a3c5b245e9b17510d6e52eb925_master.jpeg', 1), 
('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_7_20240528181636_43daf4bec7b445bea1586a08d9e9924d_master.jpeg', 2), ('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_12_20240528181636_14f6ebc1ebe94b5a8d48d279975bd94e_master.jpeg', 2), ('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_10_20240528181636_20d2ff0500bb467485476a7d511581ea_master.jpeg', 2), 
('https://product.hstatic.net/1000003969/product/kem_jndng014_2_20230313202310_d579ca759ae5466bb67f44fac12052ef_master.jpeg', 3), ('https://product.hstatic.net/1000003969/product/kem_jndng014_3_20230313202310_861163831b1b466b904647f89e385fbb_master.jpeg', 3), ('https://product.hstatic.net/1000003969/product/kem_jndng014_5_20230313202310_3a87647173314761be24f9f90f2677b4_master.jpeg', 3), 
('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_1_20230526141427_a0bc44383a4e475cb9da7245bd53fff7_master.jpeg', 4), ('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_6_20230526141428_dae0a82ef12044cea8fde933990fa4d6_master.jpeg', 4), ('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_5_20230526141428_97290daa2865497cb34b1b51b88b1bc2_master.jpeg', 4), 
('https://product.hstatic.net/1000003969/product/nau_jndlu063_2_20231011103409_c9b9a5e028454f08b34d9b049745bbbf_master.jpeg', 5), ('https://product.hstatic.net/1000003969/product/nau_jndlu063_3_20231011103410_60a4a998414f4abb8d4537eb01764874_master.jpeg', 5), ('https://product.hstatic.net/1000003969/product/nau_jndlu063_5_20231011103410_ec6e2ce9b4a94f24ab47b5436bb437de_master.jpeg', 5), 
('https://product.hstatic.net/1000003969/product/nau_jndlu038_14_20221115121450_725e945b50e0461c989f_a81472ca05854c77bee57c77ddc1094d_master.jpeg', 6), ('https://product.hstatic.net/1000003969/product/nau_jndlu038_16_20221115121450_bd2f0a90254f41078bc5_7cc861f94a2445b4b3ca7e375b6dc6e6_master.jpeg', 6), ('https://product.hstatic.net/1000003969/product/nau_jndlu038_17_20221115121450_68cc72f154b44661aaa2_c072ee8a623c487aa96d6b8f35827ecb_master.jpeg', 6), 
('https://product.hstatic.net/1000003969/product/den_jndng016_7_20230918201415_80e4e4c50acf46188e5996d03faa1dd7_master.jpeg', 7), ('https://product.hstatic.net/1000003969/product/den_jndng016_11_20230918201415_e76d792dfd8c40e0b190812c511a514c_master.jpeg', 7), ('https://product.hstatic.net/1000003969/product/den_jndng016_8_20230918201415_d3d317a8941c4dffa63f7e538f070253_master.jpeg', 7), 
('https://product.hstatic.net/1000003969/product/xanh_jndlu046_2_20221019115727_6d62d3bb44704433b93a_3fd9ad448b8f48e5bf44269d0ceec29a_master.jpeg', 8), ('https://product.hstatic.net/1000003969/product/xanh_jndlu046_4_20221019115727_e1cfc56f0d5748c8af1b_ddcbcf7e730f4f0a89cf9e3301ef19eb_master.jpeg', 8), ('https://product.hstatic.net/1000003969/product/xanh_jndlu046_3_20221019115727_e40b2b79979c461d88b6_bfad1a8fa70249b29dac1a4091a254c3_master.jpeg', 8), 
('https://product.hstatic.net/1000003969/product/den_jndlu054_1_20221205114455_cd6096b83079423ea64c5a0e501c6ec0_master.jpeg', 9), ('https://product.hstatic.net/1000003969/product/den_jndlu054_3_20221205114455_bf6c6181e7764f9fad67aac23563f8ab_master.jpeg', 9), ('https://product.hstatic.net/1000003969/product/den_jndlu054_5_20221205114456_e357151baeba4341a017756af2791d8e_master.jpeg', 9), 
('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_3_20240528180832_a5c3d5dd0b20407a8936fc2f73fa62cd_master.jpeg', 10), ('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_1_20240528180832_7cff891d266a468093ee300c5678f4ee_master.jpeg', 10), ('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_2_20240528180832_166016d0825e4fcc81eb8c3a96c116d3_master.jpeg', 10);

--2 Áo thun nữ
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/trang_jnath060_1_20240715114452_e9bdc72f20604627bdb73a9d7b70d603_master.jpeg', N'Áo Thun Form Boxy In Kim Tuyến',249000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Áo thun form boxy in kim tuyến cá tính, trẻ trung và nổi bật. Thiết kế in kim tuyến và phối nơ mang lại nét đặc biệt khi diện. Trang phục phù hợp dạo phố, thường ngày, đi học...', 2),
	('https://product.hstatic.net/1000003969/product/hong_jnath059_9_20240701190932_9b0af3feabd640a0833524135df223d5_master.jpeg', N'Áo Thun Form Boxy Thêu 3D',249000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Áo thun form boxy thêu 3D "MIAMI AESTHETIC" cá tính, trẻ trung. Trang phục phù hợp dạo phố, thường ngày, đi học...', 2),
	('https://product.hstatic.net/1000003969/product/hong_jnaki035_1_20240625094729_f261b6dacc38414fa4bfed8b4a56c1cf_master.jpeg', N'Áo Dệt Creme Tay Ngắn',449000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Áo dệt creme tay ngắn năng động. Trang phục phù hợp dạo phố, đi học. Chất liệu vải knit đàn hồi cao, tạo sự thoải mái cho người mặc', 2),
	('https://product.hstatic.net/1000003969/product/do_jnath057_9_20240618170235_232567f0ae2f412f9622c23676096dff_master.jpeg', N'Áo Thun Form Baby Tee Cherie',249000 , 50, N'Sweet H', N'Made In VietNam', N'Đỏ', N'Cotton', N'Áo thun form baby tee Cherie trẻ trung, năng động. Trang phục phù hợp dạo phố, thường ngày, đi học...', 2),
	('https://product.hstatic.net/1000003969/product/trang_jnath045_4_20240310170307_3be3718de2bc4b2b95bbc75d695d7f1c_master.jpeg', N'Áo Thun Oversize In Hoa',249000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Áo thun oversize in hoa trẻ trung, năng động.  Trang phục phù hợp dạo phố, thường ngày, đi học...', 2),
	('https://product.hstatic.net/1000003969/product/kem_jnath031_15_20220907103744_41e9a39e56b445eaa021_488673986b7c45a487ed93f2e301823b_master.jpeg', N'Áo Cổ Tròn Họa Tiết Monogram',399000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng kem', N'Cotton', N'Áo cổ tròn họa tiết Monogram sành điệu. Trang phục phù hợp dạo phố, thường ngày,...', 2),
	('https://product.hstatic.net/1000003969/product/den_jnath041_7_20230515154853_16280419f8c74bbf87c00ea45badccb9_master.jpeg', N'Áo Thun Form Rộng In Hình Poodle',249000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Áo thun form rộng in hình Poodle thời tranh, năng động. Trang phục phù hợp dạo phố, thường ngày, đi học...', 2),
	('https://product.hstatic.net/1000003969/product/den_hnath042_1_20230515084454_ed208761823348ee94cf97785deb1ac1_master.jpeg', N'Áo Thun Form Rộng In Hình Art Blossom',199000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Miêu tả: Áo thun form rộng in hình Art Blossom. Đặc tính: Trẻ trung - Năng động. Thể loại: Trang phục dạo phố, thường ngày', 2),
	('https://product.hstatic.net/1000003969/product/den_jnath046_9_20240715121130_80f16e85d6df4a4dbdf97b0bb9ad3ce3_master.jpeg', N'Áo Thun Sọc Form Ngắn Sát Nách',299000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Áo thun sọc form ngắn sát nách trẻ trung, năng động. Trang phục phù hợp dạo phố, thường ngày, đi học...', 2),
	('https://product.hstatic.net/1000003969/product/hong_jnaki036_1_20240625095740_74c4bde801ec4eabb046245a281065f3_master.jpeg', N'Áo Dệt Cổ Vuông Tay Ngắn',299000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Áo dệt cổ vuông tay ngắn nữ tính, thời trang. Trang phục phù hợp dạo phố, đi học, đi chơi. Phối màu hiện đại', 2);

	-- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/trang_jnath060_2_20240715114452_af63ba6b0d254303b203c4018893f4d4_master.jpeg', 11), ('https://product.hstatic.net/1000003969/product/trang_jnath060_3_20240715114452_44430add211744de8b7831e5ba7a5334_master.jpeg', 11), ('https://product.hstatic.net/1000003969/product/trang_jnath060_4_20240715114452_8e8837af96664306b762a23a35ae56bc_master.jpeg', 11), 
('https://product.hstatic.net/1000003969/product/hong_jnath059_10_20240701190932_b2c5db7eddce4a14b11de1f934180a7e_master.jpeg', 12), ('https://product.hstatic.net/1000003969/product/hong_jnath059_11_20240701190932_de783b43a15847b9b25b8c5e2293025e_master.jpeg', 12), ('https://product.hstatic.net/1000003969/product/hong_jnath059_12_20240701190932_b014f6fa49d2422486e9cbc2112eb9b9_master.jpeg', 12), 
('https://product.hstatic.net/1000003969/product/hong_jnaki035_3_20240625094729_211dd57d071d443fbc325ed5ea84c876_master.jpeg', 13), ('https://product.hstatic.net/1000003969/product/hong_jnaki035_2_20240625094729_80f27d2c678b4a19a0f4784caac2ecb2_master.jpeg', 13), ('https://product.hstatic.net/1000003969/product/hong_jnaki035_4_20240625094729_c85f6dfb422f461eb8078c37c603fc2c_master.jpeg', 13), 
('https://product.hstatic.net/1000003969/product/do_jnath057_11_20240618170235_0301776d91d04dbd938bc110eb8a1b4c_master.jpeg', 14), ('https://product.hstatic.net/1000003969/product/do_jnath057_10_20240618170235_ff50865b81334a738842181d221a557e_master.jpeg', 14), ('https://product.hstatic.net/1000003969/product/do_jnath057_12_20240618170235_10eaf9019e8e489cb059fcc0dfff9e2a_master.jpeg', 14), 
('https://product.hstatic.net/1000003969/product/trang_jnath045_2_20240310170307_b18a55e427f2466bb403d23065df12ed_master.jpeg', 15), ('https://product.hstatic.net/1000003969/product/trang_jnath045_3_20240310170307_c7f803bb1b524e95b5ae136053a9a777_master.jpeg', 15), ('https://product.hstatic.net/1000003969/product/trang_jnath045_4_20240310170307_3be3718de2bc4b2b95bbc75d695d7f1c_master.jpeg', 15), 
('https://product.hstatic.net/1000003969/product/kem_jnath031_17_20220907103744_5c3ab75b801442829c90_62bb116f652d4b6faabb239edad7c2b8_master.jpeg', 16), ('https://product.hstatic.net/1000003969/product/kem_jnath031_19_20220907103745_1389bb939bfc44fab283_3d1c6b56592848ab8101e98dfc88fca2_master.jpeg', 16), ('https://product.hstatic.net/1000003969/product/kem_jnath031_20_20220907103745_fcfc7cbe37e94d7d89fe_88efabc4b3ba455ca0b8204931ea7f5b_master.jpeg', 16), 
('https://product.hstatic.net/1000003969/product/den_jnath041_10_20230515154853_fb7f973eb9e14747a24c3ae0622831b0_master.jpeg', 17), ('https://product.hstatic.net/1000003969/product/den_jnath041_9_20230515154853_de24cc6707bf4acab72f7cfb49fb147a_master.jpeg', 17), ('https://product.hstatic.net/1000003969/product/den_jnath041_7_20230515154853_16280419f8c74bbf87c00ea45badccb9_master.jpeg', 17), 
('https://product.hstatic.net/1000003969/product/den_hnath042_2_20230515084454_ac347258787749ca963b634d60beb777_master.jpeg', 18), ('https://product.hstatic.net/1000003969/product/den_hnath042_3_20230515084454_136e7c9cfd28443ab39c5b7397f85dc6_master.jpeg', 18), ('https://product.hstatic.net/1000003969/product/den_hnath042_4_20230515084455_2c64e73ce91643338f791f11c8f8adcd_master.jpeg', 18), 
('https://product.hstatic.net/1000003969/product/den_jnath046_10_20240715121131_7bf694618db4470e88251760b7dd48f3_master.jpeg', 19), ('https://product.hstatic.net/1000003969/product/den_jnath046_11_20240715134545_001933dc402449e7acd22da55f4a0279_master.jpeg', 19), ('https://product.hstatic.net/1000003969/product/den_jnath046_12_20240715134545_cc36e9e958d24ec1bc159c3b1b7b2c49_master.jpeg', 19), 
('https://product.hstatic.net/1000003969/product/hong_jnaki036_2_20240625095740_756949f2a8914a6ab989c7bded2b4acc_master.jpeg', 20), ('https://product.hstatic.net/1000003969/product/hong_jnaki036_3_20240625095740_24853073888b4dc89342b2e4b9ab159b_master.jpeg', 20), ('https://product.hstatic.net/1000003969/product/hong_jnaki036_4_20240625095740_20db01989c3041e78c17491f9caa91cb_master.jpeg', 20);

--3 Áo sơ mi nữ
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/hong_jnasm026_9_20240527141426_04b0425c5d0e4f17bd52585e4479d123_master.jpeg', N'Áo Sơ Mi Dài Tay Phối Cổ',349000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Áo sơ mi dài tay phối cổ trẻ trung, năng động.  Áo được phối với phần cổ trắng làm điểm nhấn và phần thân áo không quá dài tạo điểm nhấn cho người mặc. Chất liệu vải cao cấp tạo sự thoải mái cho người mặc', 3),
	('https://product.hstatic.net/1000003969/product/nau_jnasm025_5_20240503172727_75ba0db08a344c4f87aeaa912f59865d_master.jpeg', N'Áo Sơ Mi Lụa Sọc',399000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Áo sơ mi lụa sọc mới lạ, hiện đại và nữ tính. Trang phục phù hợp dạo phố, thường ngày, đi học...', 3),
	('https://product.hstatic.net/1000003969/product/vang_jnasm028_7_20240709094219_565c448447a947f2a6e39a1fe77198f8_master.jpeg', N'Áo Sơ Mi Thêu Logo',349000 , 50, N'Sweet H', N'Made In VietNam', N'Vàng', N'Cotton', N'Áo sơ mi thêu logo nữ tính, sang trọng. Áo được phối với phần cổ làm điểm nhấn và phần thân áo không quá dài tạo điểm nhấn cho người mặc. Chất liệu vải cao cấp tạo sự thoải mái cho người mặc', 3),
	('https://product.hstatic.net/1000003969/product/trang_jnasm024_1_20240130181225_baa17ca979114330a6af2456a3a8539c_master.jpeg', N'Áo Sơmi Oversized',299000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Áo sơmi oversized thanh lịch, ứng dụng được nhiều dịp. Trang phục phù hợp đi làm, thường ngày,...', 3),
	('https://product.hstatic.net/1000003969/product/den_jnaki031_1_20240130091125_ff56d655805d49b6855326e3583363b3_master.jpeg', N'Áo Sơmi Croptop Dài Tay',249000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Áo sơmi croptop dài tay thanh lịch, công sở.  Trang phục phù hợp đi làm, thường ngày,...', 3),
	('https://product.hstatic.net/1000003969/product/den_jnasm023_8_20240122132555_9601beeda03e40f986c04ccf1577b47d_master.jpeg', N'Áo Sơ Mi Dài Tay Đính Ngọc Trai Cổ Áo',349000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Áo sơ mi dài tay đính ngọc trai cổ áo nữ tính. Trang phục phù hợp dạo phố, đi tiệc...', 3),
	('https://product.hstatic.net/1000003969/product/kem_jnasm022_7_20230918200811_e17c273a12e749a4b1074ace720cc0e3_master.jpeg', N'Áo Sơmi Over Size Nút Cố Sau',299000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng kem', N'Cotton', N'Áo sơmi over size nút cố sau thời trang, nữ tính. Trang phục phù hợp dạo phố, thường ngày, đi làm...', 3),
	('https://product.hstatic.net/1000003969/product/hong_jnasm017_7_20221004093138_e7d61e3512944052915d1784ddf3d6ab_master.jpeg', N'Áo Sơmi Dáng Oversized',249000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Áo sơmi dáng oversized trẻ trung, nữ tính. Trang phục phù hợp dạo phố, đi làm,...', 3),
	('https://product.hstatic.net/1000003969/product/xanh_jnasm019_1_20230830172822_487f360590c9442394650792b84e76ff_master.jpeg', N'Áo Sơ Mi Dài Tay Rập Nhăn',399000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Cotton', N'Áo sơ mi dài tay rập nhăn thanh lịch, công sở. Trang phục phù hợp đi làm, thường ngày,...', 3),
	('https://product.hstatic.net/1000003969/product/nau_jnasm025_5_20240503172727_75ba0db08a344c4f87aeaa912f59865d_master.jpeg', N'Áo Sơ Mi Lụa Sọc',399000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N' Áo sơ mi lụa sọc mới lạ, hiện đại và nữ tính. Trang phục phù hợp đi làm, thường ngày,...', 3);

	-- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/hong_jnasm026_10_20240527141426_cdf31d6b33e84074a2c0dc3a156f9fe4_master.jpeg', 21), ('https://product.hstatic.net/1000003969/product/hong_jnasm026_7_20240527141426_53a972d46bdb4cd3b13753bdd77f1174_master.jpeg', 21), ('https://product.hstatic.net/1000003969/product/hong_jnasm026_12_20240527141426_543c4e99d8e745a9ae6f1b9c33557104_master.jpeg', 21), 
('https://product.hstatic.net/1000003969/product/nau_jnasm025_8_20240503172727_8a77eced48e34f0a8b76112d74ba9171_master.jpeg', 22), ('https://product.hstatic.net/1000003969/product/nau_jnasm025_7_20240503172727_fcef3f901ded49b7b4eb50eb210d274d_master.jpeg', 22), ('https://product.hstatic.net/1000003969/product/nau_jnasm025_6_20240503172727_3cb4013c6e984a6091eaba029b5c997d_master.jpeg', 22), 
('https://product.hstatic.net/1000003969/product/vang_jnasm028_12_20240709094219_c8638ea35a924fc59b5b821d82b53926_master.jpeg', 23), ('https://product.hstatic.net/1000003969/product/vang_jnasm028_10_20240709094219_b8ed3c939e6c46acb91d0e1dcea1e0a0_master.jpeg', 23), ('https://product.hstatic.net/1000003969/product/vang_jnasm028_8_20240709094219_053c025ba75b40e6b31a046b7e080992_master.jpeg', 23), 
('https://product.hstatic.net/1000003969/product/trang_jnasm024_2_20240130181225_be55a13ec8df4318ba7158927579d02c_master.jpeg', 24), ('https://product.hstatic.net/1000003969/product/trang_jnasm024_6_20240130181226_8a7ea9b9181c4354941a34a9d8ce5ff1_master.jpeg', 24), ('https://product.hstatic.net/1000003969/product/trang_jnasm024_4_20240130181225_1e4a3cef439943e88e7d75b2e686b0a6_master.jpeg', 24), 
('https://product.hstatic.net/1000003969/product/den_jnaki031_2_20240130091125_44bbae2b3ac143a4a5ed01a521934292_master.jpeg', 25), ('https://product.hstatic.net/1000003969/product/den_jnaki031_4_20240130091126_29505515dc124008b5f0bdc2e1bc7e71_master.jpeg', 25), ('https://product.hstatic.net/1000003969/product/den_jnaki031_5_20240130091126_69e051de46fc4096bdf52a8d56ef683e_master.jpeg', 25), 
('https://product.hstatic.net/1000003969/product/den_jnasm023_10_20240122132555_2ae9d7577f1842c49239799a20e5f352_master.jpeg', 26), ('https://product.hstatic.net/1000003969/product/den_jnasm023_7_20240122132555_34de7077081c4a90b066f8865e50ab79_master.jpeg', 26), ('https://product.hstatic.net/1000003969/product/den_jnasm023_9_20240122132555_c2035255c62c47f9ad517be10f127459_master.jpeg', 26), 
('https://product.hstatic.net/1000003969/product/kem_jnasm022_8_20230918200811_537ab4d2ab504b78b6dc0c36aa908180_master.jpeg', 27), ('https://product.hstatic.net/1000003969/product/kem_jnasm022_9_20230918200811_d9d5490ca8c147b090ab168c8c7f7533_master.jpeg', 27), ('https://product.hstatic.net/1000003969/product/kem_jnasm022_11_20230918200811_fcdad3b4883e4372afd1edbf5968ecf1_master.jpeg', 27), 
('https://product.hstatic.net/1000003969/product/hong_jnasm017_8_20221004093138_a18e50493fb647638d17021062d0977e_master.jpeg', 28), ('https://product.hstatic.net/1000003969/product/hong_jnasm017_9_20221004093138_5b246b9155564c30a36cdf18a29d2d5b_master.jpeg', 28), ('https://product.hstatic.net/1000003969/product/hong_jnasm017_12_20221004093138_3e72768dc47c494b956b3fcab6d8b191_master.jpeg', 28), 
('https://product.hstatic.net/1000003969/product/xanh_jnasm019_2_20230830172822_efbbd791925d4d76b0f10712acda2cfb_master.jpeg', 29), ('https://product.hstatic.net/1000003969/product/xanh_jnasm019_3_20230830172822_296fe2f9171c4abeb1a3b73e75758486_master.jpeg', 29), ('https://product.hstatic.net/1000003969/product/xanh_jnasm019_4_20230830172822_2f5482cf59dc469f81b3be845033f366_master.jpeg', 29), 
('https://product.hstatic.net/1000003969/product/nau_jnasm025_6_20240503172727_3cb4013c6e984a6091eaba029b5c997d_master.jpeg', 30), ('https://product.hstatic.net/1000003969/product/nau_jnasm025_8_20240503172727_8a77eced48e34f0a8b76112d74ba9171_master.jpeg', 30), ('https://product.hstatic.net/1000003969/product/nau_jnasm025_7_20240503172727_fcef3f901ded49b7b4eb50eb210d274d_master.jpeg', 30);
	
--4 Denim nữ
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh029_8_20240520155954_81407fd7dc5b478da7ffc4a9e8520d86_master.jpeg', N'Quần Váy Jean',349000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh nhạt', N'Jean', N'Quần váy Jean trẻ trung, năng động.  Phù hợp với nhiều phong cách', 4),
	('https://product.hstatic.net/1000003969/product/den-xam_jnqsh029_1_20240520155954_ed73046c868347ef80e13716ea934628_master.jpeg', N'Quần Váy Jean',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Jean', N'Quần váy Jean trẻ trung, năng động.  Phù hợp với nhiều phong cách', 4),
	('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqda031_5_20240520150450_dabe7d510fd8453eb60d334dc8b80ecb_master.jpeg', N'Quần Dài Jean Ống Suông',499000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh nhạt', N'Jean', N'Quần jeans dài ống suông cá tính, trẻ trung, năng động. Trang phục phù hợp dạo phố, đi chơi, đi học', 4),
	('https://product.hstatic.net/1000003969/product/xanh-dam_jnqda031_1_20240520150450_fa9b654d032c4cd69fbc3421d97b8f05_master.jpeg', N'Jean Ống Suông Hiện Đại',299000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh đậm', N'Jean', N'Quần jeans dài ống suông cá tính, trẻ trung, năng động. Trang phục phù hợp dạo phố, đi chơi, đi học', 4),
	('https://product.hstatic.net/1000003969/product/xanh_hnqda013_11_20221118141827_1b07962795a64238867_083eef9056ac411bb4020190f0b2bbc3_master.jpeg', N'Quần Jean Dài Ống Loe',249000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh nhạt', N'Jean', N'QUẦN JEAN ỐNG LOE.Đặc tính: Cá tính - Năng động - Trẻ trung. Thể loại: Trang phục dạo phố.', 4),
	('https://product.hstatic.net/1000003969/product/xanh-dam_hnqda013_6_20221118141826_6f612988c19a45fe_2994e9b9a6ce490b902910379bca97fd_master.jpeg', N'Quần Ống Loe Jean Đứng',349000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh đậm', N'Jean', N'QUẦN JEAN ỐNG LOE.Đặc tính: Cá tính - Năng động - Trẻ trung. Thể loại: Trang phục dạo phố.', 4),
	('https://product.hstatic.net/1000003969/product/xanh-nhat_hnqda013_3_20221118141826_f4e2d0bc3b0e4f4_5f0198d3493744f48a2c55e7d5f18d5f_master.jpeg', N'Jean Ống Loe Xanh',249000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Jean', N'QUẦN JEAN ỐNG LOE.Đặc tính: Cá tính - Năng động - Trẻ trung. Thể loại: Trang phục dạo phố.', 4),
	('https://product.hstatic.net/1000003969/product/do_jnath035_2_20230831110257_0c8c70fb8e524c3b8bb68b1376076640_master.jpeg', N'Jean Ống Đứng Phong Cách',349000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Jean', N'QUẦN JEAN ỐNG LOE.Đặc tính: Cá tính - Năng động - Trẻ trung. Thể loại: Trang phục dạo phố.', 4),
	('https://product.hstatic.net/1000003969/product/kem_jnath031_17_20220907103744_5c3ab75b801442829c90_62bb116f652d4b6faabb239edad7c2b8_master.jpeg', N'Quần Dài Jean Ống Suông',399000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Jean', N'QUẦN JEAN ỐNG LOE.Đặc tính: Cá tính - Năng động - Trẻ trung. Thể loại: Trang phục dạo phố.', 4),
	('https://product.hstatic.net/1000003969/product/kem_jnkhc015_1_20240408210607_86a9bf38aaac4684a304dbbd58ec5815_master.jpeg', N'Quần Jean Dài Ống Loe',399000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh đậm', N'Jean', N' QUẦN JEAN ỐNG LOE.Đặc tính: Cá tính - Năng động - Trẻ trung. Thể loại: Trang phục dạo phố.', 4);

	-- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh029_7_20240520155954_0edd2ffb82ce4df48ae843fe70db5049_master.jpeg', 31), ('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh029_9_20240520155954_04bb9e1a7c0d44d1a9a9a42152d46126_master.jpeg', 31), ('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh029_11_20240520155954_5e5b01f1a97d48eca7f863ce01235779_master.jpeg', 31), 
('https://product.hstatic.net/1000003969/product/den-xam_jnqsh029_2_20240520155954_303fd495e8344ae5b0c032f0cf38d5c2_master.jpeg', 32), ('https://product.hstatic.net/1000003969/product/den-xam_jnqsh029_4_20240520155954_0127704b5a3447caac949331039ce423_master.jpeg', 32), ('https://product.hstatic.net/1000003969/product/den-xam_jnqsh029_5_20240520155954_0dfd7519ecb7408aa5771ab32f3efcb1_master.jpeg', 32), 
('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqda031_6_20240520150450_dd40919d0e504a8a81dc88a0cab47b0a_master.jpeg', 33), ('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqda031_7_20240520150450_c13ff9cc093c478eabcda191c67ff879_master.jpeg', 33), ('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqda031_8_20240520150450_290aa6bd2aa544c0a620feabab6f74c8_master.jpeg', 33), 
('https://product.hstatic.net/1000003969/product/xanh-dam_jnqda031_2_20240520150450_30d04873098a49a18b21f41ef42a16d7_master.jpeg', 34), ('https://product.hstatic.net/1000003969/product/xanh-dam_jnqda031_3_20240520150450_0c6bce5696d049a88511ff8b62df9c2e_master.jpeg', 34), ('https://product.hstatic.net/1000003969/product/xanh-dam_jnqda031_4_20240520150450_896226e2568f40bcb8a823d238cbf589_master.jpeg', 34), 
('https://product.hstatic.net/1000003969/product/xanh_hnqda013_9_20221118141826_b2b12b98312f462f9aca_66deba1286d84e8bb5a050694eb6a1a1_master.jpeg', 35), ('https://product.hstatic.net/1000003969/product/xanh_hnqda013_10_20221118141827_678f74deac0541818d5_1bddc63dc05b45ca85d83cafc7d74577_master.jpeg', 35), ('https://product.hstatic.net/1000003969/product/xanh_hnqda013_12_20221118141827_cceab3d4eddf4de49e5_3be3944fd80f414fb8430412e784c7cd_master.jpeg', 35), 
('https://product.hstatic.net/1000003969/product/xanh-dam_hnqda013_5_20221118141826_ea4ae9d4796c4530_1ce6f163570f423fb29f0e9eed4496af_master.jpeg', 36), ('https://product.hstatic.net/1000003969/product/xanh-dam_hnqda013_7_20221118141826_db6a1341e1ef43ce_822c39b7b01e40049f2ce7e046dbfc53_master.jpeg', 36), ('https://product.hstatic.net/1000003969/product/xanh-dam_hnqda013_8_20221118141826_5a6c30aa3f234967_62a9d77bbde6419b876a898e05842562_master.jpeg', 36), 
('https://product.hstatic.net/1000003969/product/xanh-nhat_hnqda013_4_20221118141826_62b90569dab74b8_c6ada6886d3b4a46b89688bac7a5ab2b_master.jpeg', 37), ('https://product.hstatic.net/1000003969/product/xanh-nhat_hnqda013_2_20221118141826_e446ac8b5a8c4ca_75f9b54ac8f249eda4f218d08ae9006b_master.jpeg', 37), ('https://product.hstatic.net/1000003969/product/xanh-nhat_hnqda013_1_20221118141826_53e7bce238d146d_1ce621ddddee43b8aaf3855e462e99d6_master.jpeg', 37), 
('https://product.hstatic.net/1000003969/product/do_jnath035_6_20230831110257_7f560f5cec42403a8c5325e9263e62f0_master.jpeg', 38), ('https://product.hstatic.net/1000003969/product/do_jnath035_4_20230831110257_bce5a6ff7ea34db5836644ee08612121_master.jpeg', 38), ('https://product.hstatic.net/1000003969/product/do_jnath035_1_20230831110257_07ee06d2af5b4080a8a4396e34681d02_master.jpeg', 38), 
('https://product.hstatic.net/1000003969/product/kem_jnath031_15_20220907103744_41e9a39e56b445eaa021_488673986b7c45a487ed93f2e301823b_master.jpeg', 39), ('https://product.hstatic.net/1000003969/product/kem_jnath031_18_20220907103745_a6a9b1f4359a43588e27_bf9de49585e244429a67276ae01b2af0_master.jpeg', 39), ('https://product.hstatic.net/1000003969/product/kem_jnath031_20_20220907103745_fcfc7cbe37e94d7d89fe_88efabc4b3ba455ca0b8204931ea7f5b_master.jpeg', 39), 
('https://product.hstatic.net/1000003969/product/kem_jnkhc015_2_20240408210607_6d7c758ffdf44108a0cfedacd7d81a51_master.jpeg', 40), ('https://product.hstatic.net/1000003969/product/kem_jnkhc015_3_20240408210607_79cd06f6f65c4c6695de5edef16aa718_master.jpeg', 40), ('https://product.hstatic.net/1000003969/product/kem_jnkhc015_4_20240408210607_2b79029ac90841558136d9d7a9a88cc5_master.jpeg', 40);
	
	--5 Quần
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/xanh-dam_jnqsh028_2_20240520155402_da52cf0546b443548274f99edef16646_master.jpeg', N'Quần Short Jean Form A',349000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh nhạt', N'Jean', N'Quần short Jean Form A trẻ trung, năng động.  Phù hợp với nhiều phong cách. Trang phục phù hợp đi chơi, đi học, dạo phố...', 5),
	('https://product.hstatic.net/1000003969/product/kem_jnqsh027_5_20240604153818_38814fc48b53473fb097027b0308db32_master.jpeg', N'Quần Short Ống A Phối Nẹp Nút',349000 , 50, N'Sweet H', N'Made In VietNam', N'Kem', N'Cotton', N'Quần short ống A phối nẹp nút thời trang, thanh lịch. Trang phục phù hợp đi học, đi làm, dạo phố, thường ngày, du lịch...', 5),
	('https://product.hstatic.net/1000003969/product/kem_jnqda029_1_20231108085857_b62ad92f214d4823945936c25fe44e40_master.jpeg', N'Quần Tây Dáng Đứng Ủi Li',299000 , 50, N'Sweet H', N'Made In VietNam', N'Kem', N'Cotton', N'Quần tây dáng đứng ủi li thanh lịch. Trang phục phù hợp dạo phố, đi làm,...', 5),
	('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh026_1_20240415191556_26cc37bba47b417d851a00c65f150c1d_master.jpeg', N'Quần Short Denim Phối Lưng Thun',349000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh đen', N'Jean', N'Quần short denim phói lưng thun phom dáng thoải mái.Thân phối bản thun phù hợp với nhiều form dáng, ống quần chữ A rộng, trẻ trung. Trang phục phù hợp dạo phố, thường ngày, ...', 5),
	('https://product.hstatic.net/1000003969/product/kem_jnqda032_1_20240625094105_d3dcb265b47d4c2081b45191ff90e689_master.jpeg', N'Quần Tây Ống Đứng Xếp Ly',499000 , 50, N'Sweet H', N'Made In VietNam', N'Kem', N'Cotton', N'Quần tây ống đứng xếp ly hiện đại, thanh lịch.  Trang phục phù hợp đi làm, thường ngày,...', 5),
	('https://product.hstatic.net/1000003969/product/trang_jnqsh025_1_20240521111800_68479464dab84413bfe32ab00aafe91c_master.jpeg', N'Quần Short Basic',349000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Quần short basic thời trang, năng động. Trang phục phù hợp dạo phố, thường ngày, du lịch...', 5),
	('https://product.hstatic.net/1000003969/product/nau_jnqda030_1_20240520224750_3f26402d221b42bc8f4af7d27fae192f_master.jpeg', N'Quần Tây Dáng Rộng',499000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Miêu tả: Quần tây dáng rộng. Đặc tính: Hiện đại - Thanh lịch - Sang trọng. Thể loại: Trang phục công sở', 5),
	('https://product.hstatic.net/1000003969/product/den_jnqda030_5_20240520224750_b58c67bb404a49039188eac75aed6732_master.jpeg', N'Quần Tây Dáng Rộng',499000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Miêu tả: Quần tây dáng rộng. Đặc tính: Hiện đại - Thanh lịch - Sang trọng. Thể loại: Trang phục công sở', 5),
	('https://product.hstatic.net/1000003969/product/den_jnqsh027_9_20240604153818_c931b282f2b74aba860707d55cae6fdf_master.jpeg', N'Quần Short Ống A Phối Nẹp Nút',349000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Quần short ống A phối nẹp nút thời trang, thanh lịch. Trang phục phù hợp đi học, đi làm, dạo phố, thường ngày, du lịch...', 5),
	('https://product.hstatic.net/1000003969/product/den_jnqda032_5_20240625094104_6988dcfcbac143129251c8f0f2dee045_master.jpeg', N'Quần Tây Ống Đứng Xếp Ly',499000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Quần tây ống đứng xếp ly hiện đại, thanh lịch.  Trang phục phù hợp đi làm, thường ngày,...', 5);

	-- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/xanh-dam_jnqsh028_1_20240520155402_6ac7e4086e5245d3b41b8ce7567e86e1_master.jpeg', 41), ('https://product.hstatic.net/1000003969/product/xanh-dam_jnqsh028_4_20240520155402_798810e61fb846a28f9855383831ce3b_master.jpeg', 41), ('https://product.hstatic.net/1000003969/product/xanh-dam_jnqsh028_5_20240520155402_09db59fb0ea84fb58369c589369ba2b8_master.jpeg', 41), 
('https://product.hstatic.net/1000003969/product/kem_jnqsh027_6_20240604153818_1779deed00ef4288bb8d3c5aa15868b5_master.jpeg', 42), ('https://product.hstatic.net/1000003969/product/kem_jnqsh027_7_20240604153818_83f52d8a11a14547abbf3f95e73b8ac6_master.jpeg', 42), ('https://product.hstatic.net/1000003969/product/kem_jnqsh027_6_20240604153818_1779deed00ef4288bb8d3c5aa15868b5_master.jpeg', 42), 
('https://product.hstatic.net/1000003969/product/kem_jnqda029_2_20231108155825_dd53f40bf55943b088409b3dc30fe067_master.png', 43), ('https://product.hstatic.net/1000003969/product/kem_jnqda029_6_20231108085858_56c219f27c7640c193fd1f1048b394c3_master.jpeg', 43), ('https://product.hstatic.net/1000003969/product/kem_jnqda029_4_20231108085858_5bebce8b24f44cdda189353523f19701_master.jpeg', 43), 
('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh026_4_20240415191556_9c1086c461c543b19a6c2f9c30b7f56c_master.jpeg', 44), ('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh026_3_20240415191556_f9a93bdf298e4b68b0c24b4f814c9b3f_master.jpeg', 44), ('https://product.hstatic.net/1000003969/product/xanh-nhat_jnqsh026_2_20240415191556_053f4c8fc04a4a6da99ff266282889ca_master.jpeg', 44), 
('https://product.hstatic.net/1000003969/product/kem_jnqda032_3_20240625094105_2dd934e54f304bfcb0e37b324f0b04ca_master.jpeg', 45), ('https://product.hstatic.net/1000003969/product/kem_jnqda032_2_20240625094105_52fd26fbe0d64bb59bca26def2cd5a11_master.jpeg', 45), ('https://product.hstatic.net/1000003969/product/kem_jnqda032_4_20240625094105_f9d4005bd761485ca4aedd17cd930d69_master.jpeg', 45), 
('https://product.hstatic.net/1000003969/product/trang_jnqsh025_2_20240520230301_379cbf9c74a24a769a2efe19d3441ed0_master.jpeg', 46), ('https://product.hstatic.net/1000003969/product/trang_jnqsh025_3_20240520230301_a4046fc23de94659b9da0e10bbb27f44_master.jpeg', 46), ('https://product.hstatic.net/1000003969/product/trang_jnqsh025_4_20240520230301_f2093dc55de94042b67339f4de333442_master.jpeg', 46), 
('https://product.hstatic.net/1000003969/product/nau_jnqda030_2_20240520224750_ff23ce4509224ae39a853047fd0f791a_master.jpeg', 47), ('https://product.hstatic.net/1000003969/product/nau_jnqda030_3_20240520224750_277fe6aeaa1143c298cd8c4a88601750_master.jpeg', 47), ('https://product.hstatic.net/1000003969/product/nau_jnqda030_4_20240520224750_e62c935a5e2e4bb4a18166c9e11449df_master.jpeg', 47), 
('https://product.hstatic.net/1000003969/product/den_jnqda030_6_20240520224750_f6f720001db74efeaee7ba66e1ef1e4f_master.jpeg', 48), ('https://product.hstatic.net/1000003969/product/den_jnqda030_7_20240520224750_1319d95da2684f64848f463a3d104922_master.jpeg', 48), ('https://product.hstatic.net/1000003969/product/den_jnqda030_8_20240520224750_322c4f213e744b25a65939b7ab1ecae8_master.jpeg', 48), 
('https://product.hstatic.net/1000003969/product/den_jnqsh027_10_20240604153818_86c36f8482be4d77a6c534a7d484d277_master.jpeg', 49), ('https://product.hstatic.net/1000003969/product/den_jnqsh027_11_20240604153818_0d277932e3294d059b496bd36370ecc7_master.jpeg', 49), ('https://product.hstatic.net/1000003969/product/den_jnqsh027_10_20240604153818_86c36f8482be4d77a6c534a7d484d277_master.jpeg', 49), 
('https://product.hstatic.net/1000003969/product/den_jnqda032_6_20240625094105_907429a980e542c9baa8393d4945430c_master.jpeg', 50), ('https://product.hstatic.net/1000003969/product/den_jnqda032_7_20240625094105_604c439425e74ba2ac3e9595028fcaec_master.jpeg', 50), ('https://product.hstatic.net/1000003969/product/den_jnqda032_8_20240625094105_dd24c45bb13542699cd78381a6754200_master.jpeg', 50);

--6 Váy
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/hong_jnvng011_1_20240116164233_002be81bb07649029be82c5e9f8d3d2c_master.jpeg', N'Chân Váy Mini Xếp Ly',349000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Chân váy mini xếp ly nữ tính, dễ phối đồ.  Trang phục phù hợp dạo phố, thường ngày,..', 6),
	('https://product.hstatic.net/1000003969/product/den_jnvng014_1_20240709093537_371339a301b44fa3a1e69c0634063968_master.jpeg', N'Chân Váy Ngắn Tùng Bí Thắt Nơ',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Chân váy ngắn tùng bí thắt nơ xinh xắn, nữ tính.  Phù hợp với nhiều mục đích sử dụng như đi chơi, đi học, đi làm, đi dạo phố,..', 6),
	('https://product.hstatic.net/1000003969/product/xanh-den_jnvng013_8_20240527141956_e9b4c5ac50154575a8b0d5c65c0b10b7_master.jpeg', N'Chân Váy Mini Xếp Ly Mắt Cáo',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Váy mini xếp ly mắt cáo cá tính, năng động. Váy được thiết kế đơn giản với điểm nhấn ở phần thắt lưng tạo sự nổi bật cho người sử dụng. Phù hợp với nhiều mục đích sử dụng như đi chơi, đi học, đi làm, đi dạo phố,...', 6),
	('https://product.hstatic.net/1000003969/product/den_jnvng012_1_20240325085049_90049f7a7eef441dae5176bdd2b87db9_master.jpeg', N'Chân Váy Mini Xếp Ly',349000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Chân váy mini xếp ly trẻ trung. năng động. Trang phục phù hợp dạo phố, thường ngày, đi học...', 6),
	('https://product.hstatic.net/1000003969/product/xam_jnvlu006_8_20230227122402_3da528dd9b214021b0dbd_3b78297ad1184563ae2b9e118b2dc7f4_master.jpeg', N'Chân Váy Midi Xẻ',199000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Chân váy midi xẻ nữ tính. Trang phục phù hợp dạo phố, thường ngày,...', 6),
	('https://product.hstatic.net/1000003969/product/kem_jnvda001_1_20231128113630_ceee93b27bfb48cea71663e3b5dcc8e2_master.jpeg', N'Chân Váy Midi Xếp Li',349000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Chân váy midi xếp li nữ tính, dễ phối đồ. Trang phục phù hợp dạo phố, đi tiệc...', 6),
	('https://product.hstatic.net/1000003969/product/nau_jnvlu006_1_20230227122402_fa1cce93e87c4f8a8ef38_d0165d5929a447eeb9e796f5a96373d7_master.jpeg', N'Chân Váy Midi Xẻ',299000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng kem', N'Cotton', N'Chân váy midi xẻ nữ tính. Trang phục phù hợp dạo phố, thường ngày,...', 6),
	('https://product.hstatic.net/1000003969/product/xam_jnvng012_5_20240325085049_28ff44a2543145cc8cc0dfda0f29f2a5_master.jpeg', N'Chân Váy Mini Xếp Ly',249000 , 50, N'Sweet H', N'Made In VietNam', N'Xám', N'Cotton', N'Chân váy midi xếp li nữ tính, dễ phối đồ. Trang phục phù hợp dạo phố, đi tiệc...', 6),
	('https://product.hstatic.net/1000003969/product/trang_jnvng014_5_20240715110435_267de0a19d8b4f2caa5f9745eb8d51bc_master.jpeg', N'Chân Váy Ngắn Tùng Bí Thắt Nơ',399000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Chân váy ngắn tùng bí thắt nơ xinh xắn, nữ tính.  Phù hợp với nhiều mục đích sử dụng như đi chơi, đi học, đi làm, đi dạo phố,..', 6),
	('https://product.hstatic.net/1000003969/product/den_jnvng011_7_20240116164234_748871c169f44065ba7e23ad2ddbdce9_master.jpeg', N'Chân Váy Mini Xếp Ly',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Chân váy mini xếp ly nữ tính, dễ phối đồ.  Trang phục phù hợp dạo phố, thường ngày,..', 6);

	-- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/hong_jnvng011_2_20240116164233_139e0dd6213c4b41909723691b747b6b_master.jpeg', 51), ('https://product.hstatic.net/1000003969/product/hong_jnvng011_3_20240116164234_f2e8e64ed672459b8a2eb22fcbb1ce98_master.jpeg', 51), ('https://product.hstatic.net/1000003969/product/hong_jnvng011_6_20240116164234_9bd689a414ad4f878445b3b8a3ff647e_master.jpeg', 51), 
('https://product.hstatic.net/1000003969/product/den_jnvng014_2_20240709093537_6675ae2cf59e4107a78372f81f640bbc_master.jpeg', 52), ('https://product.hstatic.net/1000003969/product/den_jnvng014_3_20240709093537_01d4a13c77784383a5097aee7cde687d_master.jpeg', 52), ('https://product.hstatic.net/1000003969/product/den_jnvng014_4_20240709093537_30a4d86b2060448a8887512a43573748_master.jpeg', 52), 
('https://product.hstatic.net/1000003969/product/xanh-den_jnvng013_5_20240527141956_4c96731b5053490e930bad3c7a317336_master.jpeg', 53), ('https://product.hstatic.net/1000003969/product/xanh-den_jnvng013_6_20240527141956_53b1dda1acba40c180e8b19169a9f468_master.jpeg', 53), ('https://product.hstatic.net/1000003969/product/xanh-den_jnvng013_7_20240527141956_9241087fc0f34f8597e6259ba908f249_master.jpeg', 53), 
('https://product.hstatic.net/1000003969/product/den_jnvng012_2_20240325085049_8a14ada78fac4e29b40423c9580b2878_master.jpeg', 54), ('https://product.hstatic.net/1000003969/product/den_jnvng012_3_20240325085049_0a0a8ab2a9934af5b583fc0075cfedda_master.jpeg', 54), ('https://product.hstatic.net/1000003969/product/den_jnvng012_4_20240325085049_9b8ecc1d7e68450cbc093e991b68bddc_master.jpeg', 54), 
('https://product.hstatic.net/1000003969/product/xam_jnvlu006_9_20230227122402_487526c5604f4018b078b_f020e224040744e38e94ba66a803b8f2_master.jpeg', 55), ('https://product.hstatic.net/1000003969/product/xam_jnvlu006_10_20230227122402_b93fb99a48c94b6c9082_3562213a64e041619bc03aff93e16b83_master.jpeg', 55), ('https://product.hstatic.net/1000003969/product/xam_jnvlu006_13_20230227122403_10144265c6444bcda721_ce5f11deb0164adfb29e98e744ea0ca9_master.jpeg', 55), 
('https://product.hstatic.net/1000003969/product/kem_jnvda001_2_20231128113630_c2c48522902a4ac78b9659f8022186e5_master.jpeg', 56), ('https://product.hstatic.net/1000003969/product/kem_jnvda001_5_20231128113630_bb860312dca8460fa74088b0b2adeccc_master.jpeg', 56), ('https://product.hstatic.net/1000003969/product/kem_jnvda001_6_20231128113630_8353baf2da464f528d786ad0912e1d77_master.jpeg', 56), 
('https://product.hstatic.net/1000003969/product/nau_jnvlu006_2_20230227122402_fe8f76ffe53d4126bb0ce_6a0c8d8c9f8543e5824adcdff0c11486_master.jpeg', 57), ('https://product.hstatic.net/1000003969/product/nau_jnvlu006_5_20230227122402_d0167f39733440ef9a58a_00bca43aeef74c34a934d9c9ee456f3d_master.jpeg', 57), ('https://product.hstatic.net/1000003969/product/nau_jnvlu006_6_20230227122402_bc4d36afdf3746e9986f7_6b19566b7c0649d5bd258230eab41f61_master.jpeg', 57), 
('https://product.hstatic.net/1000003969/product/xam_jnvng012_6_20240325085049_e7ab759b0c124e2fbdfb8cb7c7571268_master.jpeg', 58), ('https://product.hstatic.net/1000003969/product/xam_jnvng012_7_20240325085049_ad00ebe3d8c243fca4bab8c477ee1f19_master.jpeg', 58), ('https://product.hstatic.net/1000003969/product/xam_jnvng012_8_20240325085049_baf85f33c6e141d59190dd35e71837a7_master.jpeg', 58), 
('https://product.hstatic.net/1000003969/product/trang_jnvng014_6_20240715110435_1420d34b961547b0a0c633e855603ddf_master.jpeg', 59), ('https://product.hstatic.net/1000003969/product/trang_jnvng014_7_20240715110435_351bf2c5e8804bb78dfd789afb8e613b_master.jpeg', 59), ('https://product.hstatic.net/1000003969/product/trang_jnvng014_8_20240715110435_8f873fab7b634c8f8b6c73932f7422ed_master.jpeg', 59), 
('https://product.hstatic.net/1000003969/product/den_jnvng011_8_20240116164234_494318466f20469b99952be641d2f06b_master.jpeg', 60), ('https://product.hstatic.net/1000003969/product/den_jnvng011_9_20240116164234_b5219bfc0f6c46e39dd823502003a11f_master.jpeg', 60), ('https://product.hstatic.net/1000003969/product/den_jnvng011_11_20240116164234_0aea1a498c144846a19aa31d3308cc82_master.jpeg', 60);

--7 Khoác
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/kem_jnkhc015_1_20240408210607_86a9bf38aaac4684a304dbbd58ec5815_master.jpeg', N'Áo Blazer Tay Ngắn Form Rộng',499000 , 50, N'Sweet H', N'Made In VietNam', N'Kem', N'Cotton', N'Áo blazer tay ngắn form rộng thanh lịch, nữ tính và hiện đại. Áo với dáng tay ngắn, cắt may phần dọc lưng và chất liệu vải nhẹ nhưng vẫn rất tôn dáng.', 7),
	('https://product.hstatic.net/1000003969/product/hong_jnkhc015_7_20240408210607_1e0841dcfb724bbc830156c052a7d98a_master.jpeg', N'Áo Blazer Form Rộng',499000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Áo blazer tay ngắn form rộng thanh lịch, nữ tính và hiện đại. Áo với dáng tay ngắn, cắt may phần dọc lưng và chất liệu vải nhẹ nhưng vẫn rất tôn dáng.', 7),
	('https://product.hstatic.net/1000003969/product/den_jnkhc015_10_20240408210608_7227671b47484e6cb92da3e82af263bc_master.jpeg', N'Blazer Tay Ngắn Form Rộng',499000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Áo blazer tay ngắn form rộng thanh lịch, nữ tính và hiện đại. Áo với dáng tay ngắn, cắt may phần dọc lưng và chất liệu vải nhẹ nhưng vẫn rất tôn dáng.', 7),
	('https://product.hstatic.net/1000003969/product/nau_jnkhc010_7_20221212201055_125a1fc31bd445ed8ccd8_17f77a07f11b4512b94ba83b5d570d45_master.jpeg', N'Áo Blazer Dáng Oversized Cơ Bản',299000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Áo blazer dáng oversized cơ bảni thanh lịch. Trang phục phù hợp dạo phố, đi làm, đi tiệc....', 7),
	('https://product.hstatic.net/1000003969/product/kem_jnkhc010_4_20221212201055_94d9912443ed46ae8fafc_81f065bae6774c66b597dab9956bcd24_master.jpeg', N'Blazer Dáng Oversized Cơ Bản',249000 , 50, N'Sweet H', N'Made In VietNam', N'Kem', N'Cotton', N'Áo blazer dáng oversized cơ bảni thanh lịch. Trang phục phù hợp dạo phố, đi làm, đi tiệc....', 7);
	
	-- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/kem_jnkhc015_2_20240408210607_6d7c758ffdf44108a0cfedacd7d81a51_master.jpeg', 61), ('https://product.hstatic.net/1000003969/product/kem_jnkhc015_3_20240408210607_79cd06f6f65c4c6695de5edef16aa718_master.jpeg', 61), ('https://product.hstatic.net/1000003969/product/kem_jnkhc015_4_20240408210607_2b79029ac90841558136d9d7a9a88cc5_master.jpeg', 61), 
('https://product.hstatic.net/1000003969/product/hong_jnkhc015_5_20240408210607_2f8fb6338ad24d75b7c26cc670d90da4_master.jpeg', 62), ('https://product.hstatic.net/1000003969/product/hong_jnkhc015_6_20240408210607_235190b06cda4c85ab8b628f8facd4dd_master.jpeg', 62), ('https://product.hstatic.net/1000003969/product/hong_jnkhc015_5_20240408210607_2f8fb6338ad24d75b7c26cc670d90da4_master.jpeg', 62), 
('https://product.hstatic.net/1000003969/product/den_jnkhc015_9_20240408210608_6b6eca6e409b49629f1e263a6b8201a9_master.jpeg', 63), ('https://product.hstatic.net/1000003969/product/den_jnkhc015_11_20240408210608_46c4e81865ab404bb0a647fe987dd09e_master.jpeg', 63), ('https://product.hstatic.net/1000003969/product/den_jnkhc015_12_20240408210608_20078336444b4369bec43aaa7a17993f_master.jpeg', 63), 
('https://product.hstatic.net/1000003969/product/nau_jnkhc010_8_20221212201055_557926b3518a4dcc8da3c_4b4dff2dae5446c2a2bc578aa3b466d1_master.jpeg', 64), ('https://product.hstatic.net/1000003969/product/nau_jnkhc010_11_20221212201056_c0f2432818d74581829e_71901616facf4629b79ab2bfa59fee6e_master.jpeg', 64), ('https://product.hstatic.net/1000003969/product/nau_jnkhc010_8_20221212201055_557926b3518a4dcc8da3c_4b4dff2dae5446c2a2bc578aa3b466d1_master.jpeg', 64), 
('https://product.hstatic.net/1000003969/product/kem_jnkhc010_1_20221212201054_3ef0967604cd4259b3bc3_ae10aece9ab04da7b68e3eed5a16ae7a_master.jpeg', 65), ('https://product.hstatic.net/1000003969/product/kem_jnkhc010_6_20221212201055_e5bd0405281b49f7b5999_6177c7d1f5e446ddbe831dead82da6a5_master.jpeg', 65), ('https://product.hstatic.net/1000003969/product/kem_jnkhc010_2_20221212201055_c3514edc2ff1467989c4e_1c96070098a14f8bb96060d2553e8aef_master.jpeg', 65);

go
--8 Mắt kính
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/xam-xanh_mk115_1_20221214174223_b8f9e51fd96c4c74b93_9957d0e12e8b4c8dab8b883cfe2a2ca8_master.jpeg', N'Mắt Kính Butterfly Classic Gọng Cách Điệu',299000 , 50, N'Sweet H', N'Made In VietNam', N'Xám xanh', N'Kim loại', N'Mắt kính butterfly classic gọng cách điệu thời thượng. Đệm mũi silicon mềm không in hằn. Hộp kính tam giác da PU chống nước, nắp nam châm và kèm khăn lau kính', 8),
	('https://product.hstatic.net/1000003969/product/hong_mk111_1_20221214173530_ad285d99ce4e4aeba78c0fff92b5ed97_master.jpeg', N'Mắt Kính Square Fashion Gọng Kim Loại',299000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Kim loại', N'Mắt kính square fashion gọng kim loại thời trang. Tròng đen, hồng, xanh chống tia UVA/UVB, TAC phân cực', 8),
	('https://product.hstatic.net/1000003969/product/xanh-mint_mk112_1_20221214173706_60adc532ba7546f0ba_d33d4ca8dc7143f3b55b82d563156da4_master.jpeg', N'Mắt Kính Polygon Trendy Gọng Kim Loại',299000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh mint', N'Kim loại', N'Mắt kính polygon trendy gọng kim loại cổ điển. Hộp kính tam giác da PU chống nước, nắp nam châm và kèm khăn lau kính', 8),
	('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_1_20221214174045_8f08cea135a745f8976_8c4ec1e885584b00bdee9880ada26b73_master.jpeg', N'Mắt Kính Butterfly Classic Gọng Kim Loại',499000 , 50, N'Sweet H', N'Made In VietNam', N'Xám xanh', N'Kim loại', N'Mắt kính butterfly classic gọng kim loại thời trang. Đệm mũi silicon mềm không in hằn. Hộp kính tam giác da PU chống nước, nắp nam châm và kèm khăn lau kính', 8),
	('https://product.hstatic.net/1000003969/product/nau_mk119_1_20240705154218_b77fb3008ec549ebb3314e418a4e9890_master.jpeg', N'Mắt Kính Thời Trang',349000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Kim loại', N'Mắt Kính Thời Trang phong cách. Phù hợp sử dụng khi đi dạo phố, du lịch. Hộp kính tam giác da PU chống nước, nắp nam châm và kèm khăn lau kính', 8),
	('https://product.hstatic.net/1000003969/product/trang_mk116_1_20240705153422_1e63f081a603493c89545c4fdf50aca9_master.jpeg', N'Mắt Kính Thời Trang',349000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Kim loại', N'Mắt Kính Thời Trang, cá tính. Phù hợp cho cả nam và nữ, có thể sử dụng khi đi dạo phố, du lịch, hoặc tham gia các hoạt động ngoài trời', 8),
	('https://product.hstatic.net/1000003969/product/vang_mk117_1_20240705153641_f2438edb9bfa4a5e9ece5a54dad8822c_master.jpeg', N'Mắt Kính Thời Trang',399000 , 50, N'Sweet H', N'Made In VietNam', N'Vàng', N'Kim loại', N'Mắt Kính Thời Trang sang trọng. Phù hợp sử dụng khi đi dạo phố, du lịch, hoặc tham gia các hoạt động ngoài trời', 8),
	('https://product.hstatic.net/1000003969/product/den_mk118_11_20240705153831_5f427df699f54926bf9dfa7511028afc_master.jpeg', N'Mắt Kính Thời Trang',399000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Kim loại', N'Mắt Kính Thời Trang, cá tính. Phù hợp cho cả nam và nữ, có thể sử dụng khi đi dạo phố, du lịch, hoặc tham gia các hoạt động ngoài trời', 8),
	('https://product.hstatic.net/1000003969/product/xam_mk107_5_20221214172627_bf1b8f79acab42c1aa850fd8_a7f0ec05e42a4aa2b11724df91e5cf75_master.jpeg', N'Mắt Kính Polygon Oversize Kim Loại',299000 , 50, N'Sweet H', N'Made In VietNam', N'Xám', N'Kim loại', N'Mắt kính polygon oversize kim loại thời trang. Thiết kế phù hợp phối với nhiều trang phục thời trang đa dạng', 8),
	('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_1_20221214174045_8f08cea135a745f8976_8c4ec1e885584b00bdee9880ada26b73_master.jpeg', N'Mắt Kính Butterfly Classic Gọng Kim Loại',399000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng Xanh', N'Kim loại', N'Mắt kính butterfly classic gọng kim loại thời trang. Hộp kính tam giác da PU chống nước, nắp nam châm và kèm khăn lau kính', 8);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/xam-xanh_mk115_2_20230418180226_d335760b311a4f619bce2655ddb5b1ce_master.jpeg', 66), ('https://product.hstatic.net/1000003969/product/xam-xanh_mk115_2_20221214174224_cfb1aefaf6694225b5e_a2a19d1641e945acbc5338f444c19159_master.jpeg', 66), ('https://product.hstatic.net/1000003969/product/xam-xanh_mk115_3_20230418180226_3e1a8ed2fab24ca1815021ee6869552d_master.jpeg', 66), 
('https://product.hstatic.net/1000003969/product/hong_mk111_2_20221220153332_0995568f4873473f9dc54e4c389acc58_master.jpeg', 67), ('https://product.hstatic.net/1000003969/product/hong_mk111_2_20221214173530_4148d79cabc34e8ab03bb3c9118e6bb3_master.jpeg', 67), ('https://product.hstatic.net/1000003969/product/hong_mk111_3_20221220153332_b9d9421f41974fcf9eddaccf1660a20a_master.jpeg', 67), 
('https://product.hstatic.net/1000003969/product/xanh-mint_mk112_2_20230418175515_aadd3f119246485c84330231741b8d29_master.jpeg', 68), ('https://product.hstatic.net/1000003969/product/xanh-mint_mk112_2_20221214173706_845e63961a734601b0_ae95128f18f44ae8a4e5b251ea037ee7_master.jpeg', 68), ('https://product.hstatic.net/1000003969/product/xanh-mint_mk112_3_20230418175515_537a70ec015348468aee848e234f436b_master.jpeg', 68), 
('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_2_20230418175933_4ed7071dc8bd46b0aff404923b8c2261_master.jpeg', 69), ('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_2_20221214174045_3eb160e2f1cd438a94f_2201dac309dc4c468503758c2d85c0f8_master.jpeg', 69), ('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_3_20230418175933_b057ef165f9a4d56bae7e61e7cb514b9_master.jpeg', 69), 
('https://product.hstatic.net/1000003969/product/nau_mk119_2_20240719163719_7bf24aa8e5a94721bf6e9af91f6dd1d5_master.jpeg', 70), ('https://product.hstatic.net/1000003969/product/nau_mk119_2_20240705154218_65d37d0a0d7c4b98ae38626830a537df_master.jpeg', 70), ('https://product.hstatic.net/1000003969/product/nau_mk119_3_20240719163719_fcc907cbcee84ecb9f544d362ee65c98_master.jpeg', 70), 
('https://product.hstatic.net/1000003969/product/trang_mk116_2_20240719163328_82564e7665b9421896b32728d6abdea8_master.jpeg', 71), ('https://product.hstatic.net/1000003969/product/trang_mk116_2_20240705153422_579fe90ca806496db71a804519651f25_master.jpeg', 71), ('https://product.hstatic.net/1000003969/product/trang_mk116_3_20240719163328_1241ac4054ed42c4af50c67fbe6907e9_master.jpeg', 71), 
('https://product.hstatic.net/1000003969/product/vang_mk117_2_20240719163434_99bb1e6675454a37b603bf942a55119e_master.jpeg', 72), ('https://product.hstatic.net/1000003969/product/vang_mk117_2_20240705153641_eb0e5d48e83d4b618f0d1dbb515c7bcd_master.jpeg', 72), ('https://product.hstatic.net/1000003969/product/vang_mk117_3_20240719163435_c3ae5d6e52d344519d09770f356513ca_master.jpeg', 72), 
('https://product.hstatic.net/1000003969/product/den_mk118_2_20240719163608_bee2d9187e5847b4a9c7bece9b7ea82d_master.jpeg', 73), ('https://product.hstatic.net/1000003969/product/den_mk118_12_20240705153831_84c8ede8f60449ac9051d378a14101ac_master.jpeg', 73), ('https://product.hstatic.net/1000003969/product/den_mk118_3_20240719163608_51b267af3e6b4bf082e1234f8d72353d_master.jpeg', 73), 
('https://product.hstatic.net/1000003969/product/xam_mk107_8_20221220152425_7d43a35f0d134a8e95dd6d49_3d60f846150b44dbbc14c19767098c14_master.jpeg', 74), ('https://product.hstatic.net/1000003969/product/xam_mk107_6_20221214172627_34e4ae2447454d4fa6c79bbc_446554e7d89d4b97b5cafcc18a2dd72e_master.jpeg', 74), ('https://product.hstatic.net/1000003969/product/xam_mk107_9_20221220152426_7bf1a21f185843fab3da30fe_88dec82ace8e4e3cb665eb5fe3638529_master.jpeg', 74), 
('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_3_20230418175933_b057ef165f9a4d56bae7e61e7cb514b9_master.jpeg', 75), ('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_2_20221214174045_3eb160e2f1cd438a94f_2201dac309dc4c468503758c2d85c0f8_master.jpeg', 75), ('https://product.hstatic.net/1000003969/product/xam-xanh_mk114_2_20230418175933_4ed7071dc8bd46b0aff404923b8c2261_master.jpeg', 75);


--9 Vớ
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/nhieu-mau_vo003_1_d3083db025ee4e5a9d5c4db055176ab0_master.jpg', N'Vớ Cổ Cao Bộ 3 Đôi Kiểu Trơn',89000 , 50, N'Sweet H', N'Made In VietNam', N'Đen, Đỏ, Vàng', N'Cotton', N'Set 3 đôi vớ cổ cao, khác màu cùng kiểu. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9),
	('https://product.hstatic.net/1000003969/product/nhieu-mau_vo009_1_88231362ae544bc38095740ed57763ce_master.jpg', N'Vớ Cổ Cao Bộ 2 Đôi Kiểu Trơn',68000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Set 3 đôi vớ cổ cao, khác màu cùng kiểu. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9),
	('https://product.hstatic.net/1000003969/product/xam-dam_vo002_1_9c6eb7ff9d424ee4b38de75231c65c01_master.jpg', N'Vớ Lười Bộ 2 Đôi Kiểu Trơn',68000 , 50, N'Sweet H', N'Made In VietNam', N'Xám', N'Cotton', N'Thiết kế đơn giản, màu sắc trẻ trung. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9),
	('https://product.hstatic.net/1000003969/product/den_vo002_1_c1746487d4154419a6c799dd0a2fe2fb_master.jpg', N'Vớ Lười Bộ 2 Đôi Kiểu Trơn',68000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Thiết kế đơn giản, màu sắc trẻ trung. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9),
	('https://product.hstatic.net/1000003969/product/hong_vo002_1_247949f2deb6481e9029050e429c44b0_master.jpg', N'Vớ Lười Bộ 2 Đôi Kiểu Trơn',68000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Cotton', N'Thiết kế đơn giản, màu sắc trẻ trung. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9),
	('https://product.hstatic.net/1000003969/product/trang_vo001_2_41a160a4417c4912b231acfc75f248d9_master.jpg', N'Vớ Cổ Thấp Bộ 2 Đôi Kiểu Sọc',68000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Thiết kế đơn giản, màu sắc trẻ trung. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9),
	('https://product.hstatic.net/1000003969/product/den_vo001_2_93f0cbfb442d43dbac53b8888754f1dd_master.jpg', N'Vớ Cổ Thấp Bộ 2 Đôi Kiểu Sọc',68000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Thiết kế đơn giản, màu sắc trẻ trung. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9),
	('https://product.hstatic.net/1000003969/product/xam_vo001_2_908c80fdc8a44b57889d2199e80f952d_master.jpg', N'Vớ Cổ Thấp Bộ 2 Đôi Kiểu Sọc',68000 , 50, N'Sweet H', N'Made In VietNam', N'Xám', N'Cotton', N'Thiết kế đơn giản, màu sắc trẻ trung. Chất liệu vải cotton mềm mại cùng spandex thấm hút, khử mùi tốt', 9);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/nhieu-mau_vo003_7_cda83312b6334d8984d7440035326023_master.jpg', 76), ('https://product.hstatic.net/1000003969/product/nhieu-mau_vo003_4_d48e162bf15e4c50adba7b95188dcef6_master.jpg', 76), ('https://product.hstatic.net/1000003969/product/nhieu-mau_vo003_2_9398774651f14b13aefbd85cd39f74b2_master.jpg', 76), 
('https://product.hstatic.net/1000003969/product/nhieu-mau_vo009_2_d4a249cf3a5b4136be3c67e3aa63cd0f_master.jpg', 77), ('https://product.hstatic.net/1000003969/product/nhieu-mau_vo009_3_bb09049201914b1babcee5f67dfcf381_master.jpg', 77), ('https://product.hstatic.net/1000003969/product/nhieu-mau_vo009_4_be27784750b84b57aa0461c3a97b00cc_master.jpg', 77), 
('https://product.hstatic.net/1000003969/product/xam-dam_vo002_2_c3a2664bbb904159b82ece5a3b0407a9_master.jpg', 78), ('https://product.hstatic.net/1000003969/product/xam-dam_vo002_2_c3a2664bbb904159b82ece5a3b0407a9_master.jpg', 78), ('https://product.hstatic.net/1000003969/product/xam-dam_vo002_2_c3a2664bbb904159b82ece5a3b0407a9_master.jpg', 78), 
('https://product.hstatic.net/1000003969/product/den_vo002_2_7429813bc16948fcbb09140e8ea1568e_master.jpg', 79), ('https://product.hstatic.net/1000003969/product/den_vo002_2_7429813bc16948fcbb09140e8ea1568e_master.jpg', 79), ('https://product.hstatic.net/1000003969/product/den_vo002_2_7429813bc16948fcbb09140e8ea1568e_master.jpg', 79), 
('https://product.hstatic.net/1000003969/product/hong_vo002_2_07c382788aae422fb1ae93197ee6f44e_master.jpg', 80), ('https://product.hstatic.net/1000003969/product/hong_vo002_2_07c382788aae422fb1ae93197ee6f44e_master.jpg', 80), ('https://product.hstatic.net/1000003969/product/hong_vo002_2_07c382788aae422fb1ae93197ee6f44e_master.jpg', 80), 
('https://product.hstatic.net/1000003969/product/trang_vo001_1_68e16a3b6b9c46e8ab3af05defe37d9c_master.jpg', 81), ('https://product.hstatic.net/1000003969/product/trang_vo001_1_68e16a3b6b9c46e8ab3af05defe37d9c_master.jpg', 81), ('https://product.hstatic.net/1000003969/product/trang_vo001_1_68e16a3b6b9c46e8ab3af05defe37d9c_master.jpg', 81), 
('https://product.hstatic.net/1000003969/product/den_vo001_1_4f6d779a21e2481c8fa6796d111d3c9c_master.jpg', 82), ('https://product.hstatic.net/1000003969/product/den_vo001_1_4f6d779a21e2481c8fa6796d111d3c9c_master.jpg', 82), ('https://product.hstatic.net/1000003969/product/den_vo001_1_4f6d779a21e2481c8fa6796d111d3c9c_master.jpg', 82), 
('https://product.hstatic.net/1000003969/product/xam_vo001_1_44b57a92907b45b9bfc42f7f257db96f_master.jpg', 83), ('https://product.hstatic.net/1000003969/product/xam_vo001_1_44b57a92907b45b9bfc42f7f257db96f_master.jpg', 83), ('https://product.hstatic.net/1000003969/product/xam_vo001_1_44b57a92907b45b9bfc42f7f257db96f_master.jpg', 83);

go

go
--9 Túi cỡ nhỏ
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/hong_txn779_9_20240129142441_5034ae6405144fda83083e6dca654698_master.jpeg', N'Túi Xách Nhỏ Đeo Vai Xoxo',749000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Túi xách nhỏ đeo vai Xoxo kèm theo charm tình yêu đặc biệt. Túi được dập phồng cùng hoạ tiết chữ xung quanh túi mới lạ. Phần quai thiết kế lạ mắt', 9),
	('https://product.hstatic.net/1000003969/product/xanh_txn833_17_20240705152940_b71665e5e1f84973b9fc8e94a0497c79_master.jpeg', N'Túi Xách Nhỏ Đeo Vai Phối Tay Cầm Đôi',549000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh đen', N'Da', N'Túi Xách Nhỏ Đeo Vai Phối Tay Cầm Đôi thời thượng, thanh lịch. Form túi cơ bản cứng cáp, phù hợp đi học, đi làm, đi tiệc/', 9),
	('https://product.hstatic.net/1000003969/product/xanh_txn807_1_20240527134442_6b8ccc7421674e1d8ff74231895e43ed_master.jpeg', N'Túi Xách Nhỏ Tay Cầm Khoá Bấm',649000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Da', N'Túi Xách Nhỏ Tay Cầm Khoá Bấm thời thượng, thanh lịch. Khoá kim loại trang trí cách điệu nổi bật, chắc chắn. Túi có tay cầm và dây đeo phù hợp với đa dạng mục đích và cách thức sử dụng', 9),
	('https://product.hstatic.net/1000003969/product/nau_txn816_17_20240506134431_d91deca6efa64f83a818e68dd946c292_master.jpeg', N'Túi Xách Nhỏ Đeo Vai Hoạ Tiết Nautical',649000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Da', N'Túi xách nhỏ deo vai hoạ tiết Nautical mới lạ độc đáo. Túi được phối màu cùng họa tiết về biển đan xen vô cùng nổi bật. Túi có thêm 1 túi dây rút bên trong vừa tạo điểm nhần vừa mang lại sự tiện dụng', 9),
	('https://product.hstatic.net/1000003969/product/kem_txn784_9_20240226094759_17e42df702054b64987671a8b49d6746_master.jpeg', N'Túi Xách Nhỏ Top Handle Trang Trí Logo Border',549000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Túi xách nhỏ top handle trang trí logo Border, kết hợp đường dập nổi tạo điểm nhấn. Túi thiết kế dáng nhỏ gọn, đủ cho bạn để những vật dụng cần thiết.', 9),
	('https://product.hstatic.net/1000003969/product/xanh-mint_txn798_1_20240304142330_ff68a214a4514a0b9287c80c0eabf605_master.jpeg', N'Túi Xách Nhỏ Phối Khoá Trang Trí',549000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh mint', N'Da', N'Túi xách nhỏ phối khoá trang trí với kiểu dáng basic, trẻ trung. Thiết kế khoá chạm khắc sang trọng, tạo điểm nhấn cho túi', 9),
	('https://product.hstatic.net/1000003969/product/hong_txn790_9_20240219124655_99ef659249d149168cd18033eeb4c17e_master.jpeg', N'Túi Xách Nhỏ Dáng Đeo Vai In Bloom',699000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Túi xách nhỏ top dáng đeo vai In Bloom hoạ tiết hoa in nổi tạo điểm nhấn lạ mắt. Túi thiết kế dáng nhỏ gọn nhưng vẫn cho bạn thoải mái đựng những vật dụng cần thiết.', 9),
	('https://product.hstatic.net/1000003969/product/kem_txn801_9_20240318120242_77ee5028c77a40078b8a4206a396fa5a_master.jpeg', N'Túi Xách Nhỏ Buckle Khoá Trang Trí',549000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng kem', N'Da', N'Túi xách nhỏ buckle khoá trang trí kim loại dễ dàng sử dụng, thanh lịch và thời trang. Túi được thiết kế với đường nét tối giản, chất liệu mộc bằng Canvas phối với da trơn.', 9),
	('https://product.hstatic.net/1000003969/product/vang_txn774_1_20240113085554_ee6f8c8cff3a450bb0a277274c70abec_master.jpeg', N'Túi Xách Nhỏ Đeo Vai Dây Trang Trí Hoa 3D',699000 , 50, N'Sweet H', N'Made In VietNam', N'Vàng', N'Da', N'Túi xách nhỏ đeo vai dây trang trí hoa 3D xinh xắn, cho bạn thêm phần nổi bật. Túi nhỏ gọn vừa đủ cho bạn mang theo những vận dụng cần thiết.', 9),
	('https://product.hstatic.net/1000003969/product/trang-xa-cu_txn766_1_20231218174626_49d15364701a4828a38833c400b47fa3_master.jpeg', N'Túi Xách Nhỏ Cong Snowflakes',549000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Túi xách nhỏ cong Snowflakes trang trí thời trang và bắt mắt. Túi thiết kế dáng nhỏ gọn, nổi bật khóa bông tuyết giúp bạn thu hút mọi ánh nhìn', 9),
	('https://product.hstatic.net/1000003969/product/hong_txn780_9_20240129125242_bc8f667053ab49b7bf4e97313bb6dbee_master.jpeg', N'Túi Xách Nhỏ Hobo Dập Hoạ Tiết Phối Charm',649000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Túi xách nhỏ hobo dập hoạ tiết phối charm nổi bật, lạ mắt. Túi được thiết kế rộng rãi cho bạn thoải mái đựng những vật dụng cần thiết', 9),
	('https://product.hstatic.net/1000003969/product/tim_txn738_1_20231002165353_497d81a894b64571bfaf9827c28e2109_master.jpeg', N'Túi Xách Nhỏ Top Handle Cozy',499000 , 50, N'Sweet H', N'Made In VietNam', N'Tím', N'Da', N'Túi xách nhỏ top handle Cozy dập nổi mềm mại sang trọng. Túi thiết kế dáng nhỏ gọn nhưng vẫn đủ cho bạn đựng những vật dụng cần thiết.', 9),
	('https://product.hstatic.net/1000003969/product/trang-kem_txn750_11_20231108084835_2c9204bef389417fbb593bda74189031_master.jpeg', N'Túi Xách Nhỏ Đeo Vai Lock & Key',449000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Túi xách nhỏ đeo vai Lock & Key sang trọng, thời trang. Túi thiết kế dáng nhỏ gọn, nổi bật khóa kim loại và charm key đủ để bạn thu hút mọi ánh nhìn.', 9),
	('https://product.hstatic.net/1000003969/product/xanh-nhat_txn741_1_20231025000552_df8c0a7b3cad466ca4672e3dd5a66c41_master.jpeg', N'Túi Xách Nhỏ Hobo Trang Trí Logo Cách Điệu',349000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Da', N'Túi xách nhỏ Hobo trang trí logo cách điệu với chất liệu denim thời thượng bao phủ bề mặt lạ mắt. Túi nhỏ gọn vừa đủ cho bạn mang theo những vận dụng cần thiết', 9),
	('https://product.hstatic.net/1000003969/product/xanh_txn742_8_20231023092021_319b17302ec04e88b42388b7a4b636ce_master.jpeg', N'Túi Xách Nhỏ Crossbody Trang Trí Logo Cách Điệu',399000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng xanh', N'Da', N'Túi xách nhỏ Crossbody trang trí logo cách điệu nữ tính, thời trang. Túi thiết kế dáng nhỏ gọn, nổi bật khóa cách điệu. Chất liệu da tổng hợp cao cấp, dễ vệ sinh, bền đẹp', 9),
	('https://product.hstatic.net/1000003969/product/den_txn721_17_20230801134207_eb6acdf20c0745d4aa166433aad216c0_master.jpeg', N'Túi Xách Nhỏ Margaritas',649000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Túi xách nhỏ Margaritas xinh xắn, kết hợp chất liệu da mềm hiệu ứng Hologram độc đáo. Túi có 01 ngăn lớn tiện dụng cho bạn thoải mái mang theo những vật dụng cần thiết.', 9),
	('https://product.hstatic.net/1000003969/product/kem_txn689_1_20230421164444_2a685686ce0640e787a64db0e630b6fd_master.jpeg', N'Túi Xách Nhỏ Đeo Vai Trang Trí Khóa Luxe',549000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Túi xách nhỏ đeo vai trang trí khoá Luxe cách điệu tạo điểm nhấn sang trọng. Thiết kế tối giản dễ dàng ứng dụng nhiều dịp: Đi làm, đi chơi, đi tiệc,...', 9),
	('https://product.hstatic.net/1000003969/product/kem_txn677_1_20230218110220_3daf917dd29841c4836a0d2_af64febda9d444719435be165abecc3f_master.jpeg', N'Túi Xách Nhỏ Top Handle Trang Trí Khoá',599000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng hồng', N'Da', N'Túi xách nhỏ top handle trang trí khoá với kiểu dáng hình hộp mang vẻ thanh lịch. Túi được thiết kế rộng rãi cho bạn thoải mái đựng những vật dụng cần thiết', 9);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/hong_txn779_12_20240130162800_f0bd8f1aa5704b21a454354d5d29fce9_master.jpeg', 84), ('https://product.hstatic.net/1000003969/product/hong_txn779_10_20240129142441_f255d14c12f14b18affa3b09a1aea6b2_master.jpeg', 84), ('https://product.hstatic.net/1000003969/product/hong_txn779_13_20240130162800_74a4bbe468c642c6b6f078832da7cc78_master.jpeg', 84), 
('https://product.hstatic.net/1000003969/product/xanh_txn833_2_20240709153458_72b28cbef63a4e20a34a901a9e57d42c_master.jpeg', 85), ('https://product.hstatic.net/1000003969/product/xanh_txn833_18_20240705152940_17d2dad7941548188fb19c685ff01a90_master.jpeg', 85), ('https://product.hstatic.net/1000003969/product/xanh_txn833_3_20240709153458_2aafd115210e42d4875b9eced16fab80_master.jpeg', 85), 
('https://product.hstatic.net/1000003969/product/xanh_txn807_2_20240531171847_6864877516f2476ea94587b76da8adec_master.jpeg', 86), ('https://product.hstatic.net/1000003969/product/xanh_txn807_2_20240527134442_cca4b9b738a74f2f91da9d7b7a3bac6e_master.jpeg', 86), ('https://product.hstatic.net/1000003969/product/xanh_txn807_3_20240531171847_66c29b661f884e9d89c71a578090b049_master.jpeg', 86), 
('https://product.hstatic.net/1000003969/product/nau_txn816_2_20240531210823_14bfe87985034d988809eef0c1de52d4_master.jpeg', 87), ('https://product.hstatic.net/1000003969/product/nau_txn816_18_20240506134431_bf55d0d327af4328967eb9036991ef46_master.jpeg', 87), ('https://product.hstatic.net/1000003969/product/nau_txn816_3_20240531210823_e789bb306d4545bda9bfaf3521e96b4d_master.jpeg', 87), 
('https://product.hstatic.net/1000003969/product/kem_txn784_3_20240227112123_5be1a2cfb49c466c9d2b7d644f772020_master.jpeg', 88), ('https://product.hstatic.net/1000003969/product/kem_txn784_10_20240226094759_3900e49755c44b6da886482e00ee1764_master.jpeg', 88), ('https://product.hstatic.net/1000003969/product/kem_txn784_2_20240227112123_5c31d2e2dd844c4f9beaea4f7ed92b4a_master.jpeg', 88), 
('https://product.hstatic.net/1000003969/product/xanh-mint_txn798_2_20240319151319_d9261dde96514309b35881bbc1f75c14_master.jpeg', 89), ('https://product.hstatic.net/1000003969/product/xanh-mint_txn798_18_20240304134020_498f5fce3a0d47d8af664b8859cfa2fa_master.jpeg', 89), ('https://product.hstatic.net/1000003969/product/xanh-mint_txn798_3_20240319151319_f254c0c1e6b04ca6963e7cddf5af7ebe_master.jpeg', 89), 
('https://product.hstatic.net/1000003969/product/hong_txn790_12_20240222142534_7cbee13a5363414981567c39ac0ac6f9_master.jpeg', 90), ('https://product.hstatic.net/1000003969/product/hong_txn790_10_20240219091405_81ca27b27b9940ab851dfb4e5ea49dc3_master.jpeg', 90), ('https://product.hstatic.net/1000003969/product/hong_txn790_13_20240222142534_b25721e66b4b44edbd06f6b468b6566c_master.jpeg', 90), 
('https://product.hstatic.net/1000003969/product/kem_txn801_12_20240320120727_ead96b4b907d481988f5e8c037f8b0db_master.jpeg', 91), ('https://product.hstatic.net/1000003969/product/kem_txn801_10_20240318120242_d3b5b32fae594f95b14939254155886b_master.jpeg', 91), ('https://product.hstatic.net/1000003969/product/kem_txn801_14_20240318120242_1d5716d599234c858800fd396afff2dd_master.jpeg', 91), 
('https://product.hstatic.net/1000003969/product/vang_txn774_12_20240116163023_fc269043a422471ba3191715d5b70cb8_master.jpeg', 92), ('https://product.hstatic.net/1000003969/product/vang_txn774_2_20240113085554_4b9d03e193aa4881bca4ce975272315c_master.jpeg', 92), ('https://product.hstatic.net/1000003969/product/vang_txn774_13_20240116163023_779f678530bc4f51a3ce53f1c01446c6_master.jpeg', 92), 
('https://product.hstatic.net/1000003969/product/trang-xa-cu_txn766_3_20231226134141_82597b54b3d649109700ac4a961cc774_master.jpeg', 93), ('https://product.hstatic.net/1000003969/product/trang-xa-cu_txn766_18_20231218141434_cd21b4ca5d5d45f3ae96d7fcfdfee53f_master.jpeg', 93), ('https://product.hstatic.net/1000003969/product/trang-xa-cu_txn766_2_20231226134141_746e847059da4c2eae70c7abbaa09318_master.jpeg', 93),
('https://product.hstatic.net/1000003969/product/hong_txn780_12_20240207143533_237db07a96c64f0db8fd0389091aa33e_master.jpeg', 94), ('https://product.hstatic.net/1000003969/product/hong_txn780_10_20240129125242_91bb3aecd9404735b6fd6b19eba9cedc_master.jpeg', 94), ('https://product.hstatic.net/1000003969/product/hong_txn780_13_20240207143533_389961d63c8447fe992e9c553105c03e_master.jpeg', 94), 
('https://product.hstatic.net/1000003969/product/tim_txn738_2_20231005104956_1f5aae4a29d44f63a9ec097d58080eb5_master.jpeg', 95), ('https://product.hstatic.net/1000003969/product/tim_txn738_2_20231002111405_c1215c86b3be4606a3317902282ebfc6_master.jpeg', 95), ('https://product.hstatic.net/1000003969/product/tim_txn738_3_20231005130845_c53374d67cc2481abdfee657df0868da_master.jpeg', 95), 
('https://product.hstatic.net/1000003969/product/trang-kem_txn750_12_20231107175755_be38d341125d478bb6625de7108c2627_master.jpeg', 96), ('https://product.hstatic.net/1000003969/product/trang-kem_txn750_14_20231108084835_1be705b5af504f12bc84614925bdb6fc_master.jpeg', 96), ('https://product.hstatic.net/1000003969/product/trang-kem_txn750_13_20231107175755_f0505b13d493420e9749391f0eb7e5c7_master.jpeg', 96), 
('https://product.hstatic.net/1000003969/product/xanh-nhat_txn741_2_20231030170132_cf0e41e6115d44e682632adf67cfcef4_master.jpeg', 97), ('https://product.hstatic.net/1000003969/product/xanh-nhat_txn741_2_20231023091103_9ec4a007ba66423fb7c3cfdf7f43ac6c_master.jpeg', 97), ('https://product.hstatic.net/1000003969/product/xanh-nhat_txn741_3_20231030170132_8767d958bb7f4d2d9e36c897fabd55af_master.jpeg', 97),
('https://product.hstatic.net/1000003969/product/xanh_txn742_2_20231030170228_653822d122174451aa3249ba08aba5a2_master.jpeg', 98), ('https://product.hstatic.net/1000003969/product/xanh_txn742_9_20231023092021_ba269b8709bd4556bdce23b4dd9b3203_master.jpeg', 98), ('https://product.hstatic.net/1000003969/product/xanh_txn742_3_20231030170228_821c5e2fc27c45e5bd90ef9e4ffaed5a_master.jpeg', 98), 
('https://product.hstatic.net/1000003969/product/den_txn721_22_20230801162951_879e2abb2bc9441b8a4263904475975c_master.jpeg', 99), ('https://product.hstatic.net/1000003969/product/den_txn721_19_20230801134207_c342d5b026c645e4b75c66027d3db3d0_master.jpeg', 99), ('https://product.hstatic.net/1000003969/product/den_txn721_23_20230801162951_0341e529315a4db79e01182af51d2858_master.jpeg', 99), 
('https://product.hstatic.net/1000003969/product/kem_txn689_3_20230421164444_37b7384df2144de3a7f91147de9a6807_master.jpeg', 100), ('https://product.hstatic.net/1000003969/product/kem_txn689_4_20230421164444_f55b82d7526244b39fbbbe007337aecc_master.jpeg', 100), ('https://product.hstatic.net/1000003969/product/kem_txn689_2_20230421164444_a8293078a96b46718f9e346a943eb9e9_master.jpeg', 100), 
('https://product.hstatic.net/1000003969/product/kem_txn677_2_20230223144520_138c72a653ee4d4f9fe1694_9f55cfbf812242709900532ca841091a_master.jpeg', 101), ('https://product.hstatic.net/1000003969/product/kem_txn677_2_20230218110220_d20340e27c0f4a798d82232_d82148bda3854db4be53deff5a41991c_master.jpeg', 101), ('https://product.hstatic.net/1000003969/product/kem_txn677_3_20230223144520_c110b61d6ce842418062169_2155029f5ef04388be548f24bcd155d4_master.jpeg', 101);


--10 Túi cỡ trung
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/hong_txt313_1_20240705152340_7b3af83633e847dd85e298f420ed0a56_master.jpeg', N'Túi Xách Trung Tote La Vie Est Belle',649000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Si mờ trơn', N'Túi Xách Trung Tote La Vie Est Belle thời thượng, phong cách. Form túi tote cứng cáp. Chất liệu canvas bền đẹp, dễ sử dụng', 10),
	('https://product.hstatic.net/1000003969/product/kem_txt315_1_20240705153210_e6edafcd30be47f2a22d2d2fcc8c68e7_master.jpeg', N'Túi Xách Trung Tote La Mer',799000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Si mờ trơn', N'Túi Xách Trung Tote La Mer nữ tính, tinh tế. Chất liệu vải mang lại cảm giác mềm mại thoải mái cho người sử dụng. Form túi cứng cáp, bên trong có túi lót rút bằng vải', 10),
	('https://product.hstatic.net/1000003969/product/xanh-la_txt312_1_20240424093647_28f6f6ee8051477394af8688188e68bd_master.jpeg', N'Túi Xách Trung Tote Camping',749000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh trắng', N'Si mờ trơn', N'Túi xách trung tote camping kèm charm khắc laser logo Juno. Túi được phối màu với đường viền lạ mắt. Túi có 1 ngăn lớn rộng rãi, 1 ngăn nhỏ tiện lợi cho nàng đựng đủ các vật dụng cần thiết ', 10),
	('https://product.hstatic.net/1000003969/product/kem_txt309_17_20240122101616_0b3d8c612fc8453eb1c8ea4dad8dab6e_master.jpeg', N'Túi Xách Trung Tote Dập Hoạ Tiết Trang Trí',749000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Si mờ trơn', N'Túi xách trung tote dập hoạ tiết trang trí thanh lịch, thời thượng. Thiết kế kèm dây đeo tiện dụng, túi rộng rãi đựng được nhiều vận dụng cần thiết. Có nhiều sự lựa chọn về màu sắc để nàng thoải mái phối đồ và tạo phong cách mới', 10),
	('https://product.hstatic.net/1000003969/product/xanh_txt311_17_20240318114051_4a05db09ad674e29b113966863e93698_master.jpeg', N'Túi Xách Trung Phối Buckle Khoá Trang Trí',649000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Si mờ trơn', N'Túi xách trung phối buckle khoá trang trí kim loại dễ dàng sử dụng, tạo điểm nhấn nổi bật cho túi. Túi được thiết kế với đường nét tối giản, chất liệu mộc bằng Canvas phối với da trơn..', 10),
	('https://product.hstatic.net/1000003969/product/kem_txt310_9_20240311174150_142c25d1801641869ba9306e8f75d4c2_master.jpeg', N'Túi Xách Trung Trang Trí Charm Và Khóa',649000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Si mờ trơn', N'Túi xách trung trang trí charm và khoá lạ mắt, sang trọng. Khóa kim loại dễ dàng sử dụng, kèm dây đeo tiện lợi, phù hợp mang nhiều dịp: đi làm, dạo phố, dự tiệc.', 10),
	('https://product.hstatic.net/1000003969/product/xanh-dam_txt305_1_20231002202107_c2e9cf0e612349feab795c0b617d92ab_master.jpeg', N'Túi Xách Trung Tote In Logo Jn',649000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Si mờ trơn', N'Túi xách trung tote in logo Jn thanh lịch, hiện đại, phù hợp đi học, đi làm. Túi có 01 ngăn lớn rộng rãi và những ngăn nhỏ cho bạn thoải mái mang theo vận dụng cần thiết', 10),
	('https://product.hstatic.net/1000003969/product/den_txt307_17_20231106091542_113e6905448945df9dea6fffa81d49cd_master.jpeg', N'Túi Xách Trung Lock & Key',649000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Si mờ trơn', N'Túi xách trung  Lock & Key tạo điểm nhấn sang trọng.  Túi được thiết kế rộng rãi cho bạn thoải mái đựng những vật dụng cần thiết, dễ dàng vệ sinh, bền đẹp.', 10),
	('https://product.hstatic.net/1000003969/product/den_txt304_9_20231002163003_cc31f4bb8775476b8ee2bb4083442b70_master.jpeg', N'Túi Xách Trung Hobo Cozy',549000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Si mờ trơn', N'Túi xách trung hobo Cozy với hoạ tiết dập nổi bắt mắt. Khoang túi một ngăn rộng có thể đựng nhiều đồ dùng cá nhân, có 2 cách đeo túi cho bạn lựa chọn phong cách.', 10),
	('https://product.hstatic.net/1000003969/product/hong_txt306_9_20231106094214_7d4102a6412a4083981473b3ae97eef9_master.jpeg', N'Túi Xách Trung Khoá Trang Trí Diamond',699000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Si mờ trơn', N'Túi xách trung khoá trang trí Diamond thanh lịch, thời thượng. Thiết kế kèm dây đeo tiện dụng, túi rộng rãi đựng được nhiều vận dụng cần thiết. Có nhiều sự lựa chọn về màu sắc để nàng thoải mái phối đồ và tạo phong cách mới', 10),
	('https://product.hstatic.net/1000003969/product/kem_txt303_1_20230823110920_456963d482d641a39a6e556d309458fa_master.jpeg', N'Túi Xách Trung Satchel Elite Of The Class',649000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng kem', N'Si mờ trơn', N'Túi xách trung Satchel Elite Of The Class nữ tính, tinh tế phù hợp những buổi đi chơi, dự tiệc. Thiết kế túi rộng rãi cho nàng đựng những vật dụng cần thiết, có 3 màu sắc.', 10),
	('https://product.hstatic.net/1000003969/product/vang-nau_txt302_17_20230731132630_09f111b5205349a2a507a39d1cf06d20_master.jpeg', N'Túi Xách Trung Satchel - Enhanced Confidence',549000 , 50, N'Sweet H', N'Made In VietNam', N'Vàng', N'Si mờ trơn', N'Túi xách trung khoáSatchel - Enhanced Confidence thanh lịch, thời thượng. Thiết kế kèm dây đeo tiện dụng, túi rộng rãi đựng được nhiều vận dụng cần thiết. Có nhiều sự lựa chọn về màu sắc để nàng thoải mái phối đồ và tạo phong cách mới', 10),
	('https://product.hstatic.net/1000003969/product/den-van_txt301_39_20240103091541_8846c6573bc04f7c960efbfaeb3ad5ef_master.jpeg', N'Túi Xách Trung Đeo Vai Wholeheartedly',699000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Si mờ trơn', N'Túi xách trung đeo vai Wholeheartedly thiết kế thanh lịch, hiện đại. Túi có 01 ngăn lớn rộng rãi và những ngăn nhỏ cho bạn thoải mái mang theo vận dụng cần thiết, dễ dàng vệ sinh. ', 10),
	('https://product.hstatic.net/1000003969/product/kem-vang_txt295_1_20230218170627_da5cd6bec23d401582_34747c8d9e6449ada4f3d8514866c31a_master.jpeg', N'Túi Xách Trung Trang Trí Charm',449000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng kem', N'Si mờ trơn', N'Túi xách trung trang trí charm với thiết kế túi trẻ trung, mang lại vẻ nữ tính cho người mang. Túi có ngăn chứa đồ rộng rãi cho bạn thoải mái sử dụng.', 10),
	('https://product.hstatic.net/1000003969/product/den_txt299_17_20230313161010_66033b58c1434aae9d49b5_d2f7314b35254b93a33c9db0e7618044_master.jpeg', N'Túi Xách Trung Tote Trung Trang Trí Logo Cách Điệu',549000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Si mờ trơn', N'Túi xách trung tote trung trang trí logo cách điệu nhiều ngăn tiện lợi, thanh lịch phù hợp với chị em văn phòng. Bên trong có ngăn lớn, khóa kim loại cho bạn thoải mái sử dụng.', 10),
	('https://product.hstatic.net/1000003969/product/kem_txt294_9_20230218170306_32c3104c1ac14cddba3fd89_97e75eda64264c748e30c7e7a4e7d446_master.jpeg', N'Túi Xách Trung Top Handle Trang Trí Charm',799000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Si mờ trơn', N'Túi xách trung top handle trang trí charm hiện đại, thanh lịch. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng.', 10),
	('https://product.hstatic.net/1000003969/product/den_txt230_1_096c6bf646114cf78a33c001a31fb160_master.jpg', N'Túi Xách Trung Dập Sọc Nổi',549000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Si mờ trơn', N'Túi xách trung dập sọc nổi thanh lịch, hiện đại. Bên ngoài có thẻ tag treo trang trí sang trọng. Bên trong có 01 ngăn lớn kèm khóa kéo tiện dụng. Tặng kèm quai đeo dài để đeo chéo', 10),
	('https://product.hstatic.net/1000003969/product/xanh-bac-ha_txt226_33_trans_20220714095440_07b090de_1e0b0c25f6de40af98e59c1342b9b580_master.jpeg', N'Túi Dập Hiệu Ứng Princess Diamond',649000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh trắng', N'Si mờ trơn', N'Túi xách dáng hộp dập nổi hình kim cương thanh lịch, sang trọng. Bề mặt phối hai màu trẻ trung. Bên trong có 1 ngăn lớn kèm khóa kéo tiện dụng và ngăn nhỏ. Tặng kèm quai đeo dài', 10);

  -- Insert data into product_image
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/hong_txt313_2_20240709171012_171862fe3b944a4dba169397b422ea9d_master.jpeg', 102), ('https://product.hstatic.net/1000003969/product/hong_txt313_2_20240705152340_f0d60a0177bc421baa714a4ce83e3fb2_master.jpeg', 102), ('https://product.hstatic.net/1000003969/product/hong_txt313_3_20240709171012_007e89e6ce5d4cdd9b560ade4891163f_master.jpeg', 102), 
('https://product.hstatic.net/1000003969/product/kem_txt315_2_20240709152631_2dd69f8ac44b492e93115149d3144180_master.jpeg', 103), ('https://product.hstatic.net/1000003969/product/kem_txt315_2_20240705153210_c2cbb9f936644e4b8a866a09ccecadaa_master.jpeg', 103), ('https://product.hstatic.net/1000003969/product/kem_txt315_3_20240709152631_1ea0692aedfd4e80926ee2b5e94e908e_master.jpeg', 103), 
('https://product.hstatic.net/1000003969/product/xanh-la_txt312_3_20240507075549_f8fa00f8995442f6bc87f16246979e64_master.jpeg', 104), ('https://product.hstatic.net/1000003969/product/xanh-la_txt312_4_20240424093647_df50e503fc4b4fa3834f0a6e34cfd527_master.jpeg', 104), ('https://product.hstatic.net/1000003969/product/xanh-la_txt312_3_20240507075549_f8fa00f8995442f6bc87f16246979e64_master.jpeg', 104), 
('https://product.hstatic.net/1000003969/product/kem_txt309_23_20240123180414_195f33c43ce44e4e90cc054362363b5f_master.jpeg', 105), ('https://product.hstatic.net/1000003969/product/kem_txt309_18_20240122101616_b0a215d31e4446918dd3c59dc37cbcf3_master.jpeg', 105), ('https://product.hstatic.net/1000003969/product/kem_txt309_22_20240122101617_950bdedf89bd4e1abe8182432dad77dc_master.jpeg', 105), 
('https://product.hstatic.net/1000003969/product/xanh_txt311_21_20240320121115_756a9de2c0254b02a74f7a4bfbef2991_master.jpeg', 106), ('https://product.hstatic.net/1000003969/product/xanh_txt311_18_20240318114051_b6957a73e76b42d39dccf19e05876ee5_master.jpeg', 106), ('https://product.hstatic.net/1000003969/product/xanh_txt311_22_20240318114051_489aa916975e4a969486709d5f941101_master.jpeg', 106), 
('https://product.hstatic.net/1000003969/product/kem_txt310_10_20240311174150_0b1256bd3d324d019d87449f86bd355d_master.jpeg', 107), ('https://product.hstatic.net/1000003969/product/kem_txt310_10_20240311174150_0b1256bd3d324d019d87449f86bd355d_master.jpeg', 107), ('https://product.hstatic.net/1000003969/product/kem_txt310_14_20240311174151_e7beea2fd1a64ff6a489ab605f323f5e_master.jpeg', 107), 
('https://product.hstatic.net/1000003969/product/xanh-dam_txt305_2_20231005104831_c77d1bfed91b4386a5f9c4a8119c99f7_master.jpeg', 108), ('https://product.hstatic.net/1000003969/product/xanh-dam_txt305_10_20231002093212_9d7956ce7dc443a99c9d9d50d538b7e3_master.jpeg', 108), ('https://product.hstatic.net/1000003969/product/xanh-dam_txt305_3_20231005104831_fc9b3f6d444a4d61b54ac88dc5ba614b_master.jpeg', 108), 
('https://product.hstatic.net/1000003969/product/den_txt307_23_20231107173640_e1603543bc114c3a839e49e7d0920459_master.jpeg', 109), ('https://product.hstatic.net/1000003969/product/den_txt307_18_20231106091543_ab188c5df4ca4850adef7ef37e7ff2e8_master.jpeg', 109), ('https://product.hstatic.net/1000003969/product/den_txt307_22_20231107173640_6051e84a7b8b4e23b2a0a860a42e003e_master.jpeg', 109), 
('https://product.hstatic.net/1000003969/product/den_txt304_12_20231005104711_e157e6c8c4134db395702af1ee766657_master.jpeg', 110), ('https://product.hstatic.net/1000003969/product/den_txt304_14_20231006214752_0c57bc11f99e4d3e819e867b232e01fa_master.jpeg', 110), ('https://product.hstatic.net/1000003969/product/den_txt304_13_20231005132545_00c9515071a24d9b9ff25ea745e27bf8_master.jpeg', 110), 
('https://product.hstatic.net/1000003969/product/hong_txt306_13_20231107163231_8689b5269c444ade991cd91aed83fbdd_master.jpeg', 111), ('https://product.hstatic.net/1000003969/product/hong_txt306_10_20231106094214_b2a8962c475a41ada5cdb084793e1469_master.jpeg', 111), ('https://product.hstatic.net/1000003969/product/hong_txt306_12_20231107163231_4cf6b882795c4739997ae8b1b14273e6_master.jpeg', 111), 
('https://product.hstatic.net/1000003969/product/kem_txt303_2_20230822170254_e26a4d1420284eb1834cb3108c9029d9_master.jpeg', 112), ('https://product.hstatic.net/1000003969/product/kem_txt303_4_20230823110920_ec40748192224b04951a5f616d81263b_master.jpeg', 112), ('https://product.hstatic.net/1000003969/product/kem_txt303_3_20230822170254_fdff36fc244e4070b2c8bb0912567fa8_master.jpeg', 112), 
('https://product.hstatic.net/1000003969/product/vang-nau_txt302_23_20230804131233_a8786563b5b94721a52d72a311eb42cd_master.jpeg', 113), ('https://product.hstatic.net/1000003969/product/vang-nau_txt302_18_20230731132630_169fea0ecefd4977aa8e5a5870871250_master.jpeg', 113), ('https://product.hstatic.net/1000003969/product/vang-nau_txt302_22_20230804131233_c7d2b739c08e47fa85e5412b2f1a7050_master.jpeg', 113), 
('https://product.hstatic.net/1000003969/product/den-van_txt301_12_20240319144240_58ec0ac93c7149fda3eedeb0baf72bf7_master.jpeg', 114), ('https://product.hstatic.net/1000003969/product/den-van_txt301_40_20240103091541_2fbce88e47db416eae14b9398b436183_master.jpeg', 114), ('https://product.hstatic.net/1000003969/product/den-van_txt301_13_20240319144240_5d4959dfeb134e29822b6a857799f61d_master.jpeg', 114), 
('https://product.hstatic.net/1000003969/product/kem-vang_txt295_3_20230223145053_509d91a2da0a4d30b9_3b0510791d7d41359fbb0c44e80ba870_master.jpeg', 115), ('https://product.hstatic.net/1000003969/product/kem-vang_txt295_2_20230218170627_b42be4f778a1477f85_79e76e7840734d1280b902623c34d8e5_master.jpeg', 115), ('https://product.hstatic.net/1000003969/product/kem-vang_txt295_2_20230223145053_80deb5fb23af4708b4_d3d9063b95ef4f72945ca22aef6525ca_master.jpeg', 115), 
('https://product.hstatic.net/1000003969/product/den_txt299_22_20230314121648_50e97f9793e7413699e15b_b3eb00c522474496b12ae58aea81b44e_master.jpeg', 116), ('https://product.hstatic.net/1000003969/product/den_txt299_18_20230313161010_b385895b472d4f79b294e1_f60ce1fb1228485186d42172877cea76_master.jpeg', 116), ('https://product.hstatic.net/1000003969/product/den_txt299_23_20230314121648_97d5342a683a4918a81e9e_2d5ff49b15ff41688ca58efda8675bcf_master.jpeg', 116), 
('https://product.hstatic.net/1000003969/product/kem_txt294_13_20230220115715_f44049f1c2f740f793aa1a_9666ac131de848fc85445d0158fbae67_master.jpeg', 117), ('https://product.hstatic.net/1000003969/product/kem_txt294_10_20230218170306_034d9d9904d4433aaf8798_307aa592c7864ad9bed48af8917d9bcd_master.jpeg', 117), ('https://product.hstatic.net/1000003969/product/kem_txt294_12_20230220115715_760cd0f07ca745e68de348_fb11274e4ab1445dac167524af83d55b_master.jpeg', 117), 
('https://product.hstatic.net/1000003969/product/den_txt230_7_ec52523bda0d40cfba7e102870e4be2f_master.jpg', 118), ('https://product.hstatic.net/1000003969/product/den_txt230_2_129a620375a94a388c00ce38b9748f02_master.jpg', 118), ('https://product.hstatic.net/1000003969/product/den_txt230_8_632078f0f658407ab4b3573364fa92c8_master.jpg', 118), 
('https://product.hstatic.net/1000003969/product/xanh-bac-ha_txt226_8_34c654136ea743f380c0763c82e32ab1_master.jpg', 119), ('https://product.hstatic.net/1000003969/product/xanh-bac-ha_txt226_2_66ba45b008cc4c6099bf83e58de67e30_master.jpg', 119), ('https://product.hstatic.net/1000003969/product/xanh-bac-ha_txt226_7_0f478327c8df466dac70d941e2de70e1_master.jpg', 119);


--11 Túi cỡ lớn
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/nau_txl095_1_20240701104949_2a234deb962f4efdbc924f2363c40645_master.jpeg', N'Túi Xách Lớn Phối Tay Cầm Trang Trí',799000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Da', N'Túi Xách Lớn Phối Tay Cầm Trang Trí sang trọng, thanh lịch. Form túi basic, cứng cáp. Không gian bên trong túi rộng rãi. Túi có phần dây PU đi kèm để nàng có thể thay đổi phong cách tùy chọn', 11),
	('https://product.hstatic.net/1000003969/product/kem_txl095_9_20240701104949_5d4b2e35b8724e2b97e4f3d2daa29d97_master.jpeg', N'Túi Xách Lớn Phối Tay Cầm Trang Trí',649000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Túi Xách Lớn Phối Tay Cầm Trang Trí sang trọng, thanh lịch. Form túi basic, cứng cáp. Không gian bên trong túi rộng rãi. Túi có phần dây PU đi kèm để nàng có thể thay đổi phong cách tùy chọn', 11),
	('https://product.hstatic.net/1000003969/product/xanh_txl094_8_20240506132204_f5ec2165de7a4f9d908102785772f4b1_master.jpeg', N'Túi Xách Lớn Hoạ Tiết Nautical',299000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Da', N'Túi xách lớn hoạ tiết Nautical cực kì mới lạ, tạo điểm nhấn. Túi thiết kế size to, bề mặt phối 2 màu in dập nổi đan xen họa tiết của biển mang lại sự nổi bật khi đeo', 11),
	('https://product.hstatic.net/1000003969/product/nau_txl094_1_20240506132203_9861305969204b1e9c8daf1d7413a370_master.jpeg', N'Túi Xách Lớn Hoạ Tiết Nautical',499000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Da', N'Túi xách lớn hoạ tiết Nautical cực kì mới lạ, tạo điểm nhấn. Túi thiết kế size to, bề mặt phối 2 màu in dập nổi đan xen họa tiết của biển mang lại sự nổi bật khi đeo', 11),
	('https://product.hstatic.net/1000003969/product/den_txl096_1_20240701110025_884619efc60048b99e00e34734076234_master.jpeg', N'Túi Xách Lớn Tote Trang Trí Khoá',449000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Túi Xách Lớn Tote Trang Trí Khoá cá tính, hiện đạo. Form túi cứng cáp với khóa kim loại trang trí tạo điểm nhấn. Chất liệu da tổng hợp kết hợp với canvas mới mẻ', 11),
	('https://product.hstatic.net/1000003969/product/kem_txl096_9_20240701110141_9fc72f28bc194e77b29220e17bcbabbc_master.jpeg', N'Túi Xách Lớn Tote Trang Trí Khoá',349000 , 50, N'Sweet H', N'Made In VietNam', N'Kem', N'Da', N'Túi Xách Lớn Tote Trang Trí Khoá cá tính, hiện đạo. Form túi cứng cáp với khóa kim loại trang trí tạo điểm nhấn. Chất liệu da tổng hợp kết hợp với canvas mới mẻ', 11),
	('https://product.hstatic.net/1000003969/product/hong_txl092_1_20231211143646_51e4997e94ff4b3684f03c485dd040c7_master.jpeg', N'Túi Xách Lớn Tote Bag Phối Lưới Xuyên Thấu',699000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Túi xách lớn Tote Bag phối lưới xuyên thấu thời trang. Khoang túi bên trong rộng rãi, tặng kèm ví tiện lợi, cho bạn thoải mái đựng những vận dụng cần thiết', 11),
	('https://product.hstatic.net/1000003969/product/xanh_txl090_1_20231023104139_3da00a0aa14a438dbe2e1fdeb8b24481_master.jpeg', N'Túi Xách Lớn Tote Lớn Trang Trí Charm',449000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Da', N'Túi xách lớn tote trang trí charm Juno thanh lịch, phù hợp với chị em văn phòng. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng.', 11),
	('https://product.hstatic.net/1000003969/product/kem_txl085_1_20230607090329_b16cee6e790a49e6bd0666ff4dc697d7_master.jpeg', N'Túi Xách Lớn Tote Phối Charm Trang Trí',649000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Da', N'Túi xách lớn tote phối charm trang trí thanh lịch, phù hợp với chị em văn phòng. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng', 11),
	('https://product.hstatic.net/1000003969/product/den_txl080_21_20230415174642_b0d8f422567c4413a2b2b38172f1ee6d_master.jpeg', N'Túi Xách Lớn Tote Lớn Gắn Charm Trang Trí',599000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Túi xách lớn tote lớn gắn charm trang trí thanh lịch, phù hợp với chị em văn phòng. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng.', 11),
	('https://product.hstatic.net/1000003969/product/kem_txl082_21_20230415180606_c73dc577b8ea4ecb92288f69c49a0166_master.jpeg', N'Túi Xách Lớn Tote Lớn Gắn Charm Trang Trí',649000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Túi xách lớn tote lớn gắn charm trang trí thanh lịch. Bên trong có ngăn đựng lớn, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng.', 11),
	('https://product.hstatic.net/1000003969/product/nau_txl083_11_20230415181433_67961b4540434ee697b93c3232c98fb0_master.jpeg', N'Túi Xách Lớn Tote Lớn Phối Ngăn Trang Trí',549000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Da', N'Túi xách lớn tote lớn phối ngăn trang trí hiện đại, thanh lịch. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ cùng ví nhỏ tặng kèm giúp việc sắp xếp ngăn nắp, tiện dụng.', 11),
	('https://product.hstatic.net/1000003969/product/kem_txl081_21_20230415175726_741440bc14b94ef28013a72f130ce5d9_master.jpeg', N'Túi Xách Lớn Tote Lớn Gắn Charm Trang Trí',599000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Túi xách lớn tote lớn gắn charm trang trí hiện đại, thanh lịch. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng. Có túi nhỏ tặng kèm.', 11),
	('https://product.hstatic.net/1000003969/product/den_txl058_1_c24e64c475f14a80a14197bc2774d8d1_master.jpg', N'Túi Xách Lớn Tote Tối Giản',549000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Túi xách lớn với quai phối móc trang trí hiện đại, thanh lịch. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng.', 11),
	('https://product.hstatic.net/1000003969/product/kem-van_txl064_37_20220808103509_eb3ba90d5e324f14a0_d4baa35eff344725864dd453b5ffe5ba_master.jpeg', N'Túi Xách Lớn Tote Ngăn Lớn',699000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Túi xách lớn tote ngăn lớn với quai phối móc trang trí hiện đại, thanh lịch. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng.', 11),
	('https://product.hstatic.net/1000003969/product/kem_txl061_17_20230127101652_88ccf84ffe6d4ba484f10e_ed846cf9f3db42aeb15d50507d6581e3_master.jpeg', N'Túi Xách Lớn 1 Ngăn Trước',399000 , 50, N'Sweet H', N'Made In VietNam', N'Kem', N'Da', N'Túi xách lớn phối viền màu hai bên tạo điểm nhấn sang trọng. Thiết kế một ngăn trước với khóa kim loại nổi bật, bên trong có một ngăn lớn rộng rãi tiện dụng.', 11),
	('https://product.hstatic.net/1000003969/product/vang_txl093_9_20240113090648_a09013cd8c9a42579b2caf48c710f6f4_master.jpeg', N'Túi Xách Lớn Trang Trí Hoa 3D',399000 , 50, N'Sweet H', N'Made In VietNam', N'Vàng', N'Da', N'Túi xách lớn trang trí hoa 3D nổi bật, cho bạn thêm phần trẻ trung. Khoang túi bên trong rộng rãi, có ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng', 11),
	('https://product.hstatic.net/1000003969/product/den_txl081_11_20230415175725_86530c6c0c7346a4aede01245ed4c0fc_master.jpeg', N'Túi Xách Lớn Tote Lớn Gắn Charm Trang Trí',649000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Túi xách lớn tote lớn gắn charm trang trí hiện đại, thanh lịch. Khoang túi bên trong rộng rãi, có nhiều ngăn nhỏ giúp việc sắp xếp ngăn nắp, tiện dụng. Có túi nhỏ tặng kèm.', 11);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/nau_txl095_2_20240702165642_6de61b5cbf2b4d9cbbe20e29dde9fa8c_master.jpeg', 120), ('https://product.hstatic.net/1000003969/product/nau_txl095_2_20240701104949_64c321b36819438584bdf5a66bdefa97_master.jpeg', 120), ('https://product.hstatic.net/1000003969/product/nau_txl095_3_20240702165642_b4def96dfc23425ea2d475e90c7a6041_master.jpeg', 120), 
('https://product.hstatic.net/1000003969/product/kem_txl095_11_20240701104949_bf47bc75bcdf4489b2dff0543bae0747_master.jpeg', 121), ('https://product.hstatic.net/1000003969/product/kem_txl095_11_20240701104949_bf47bc75bcdf4489b2dff0543bae0747_master.jpeg', 121), ('https://product.hstatic.net/1000003969/product/kem_txl095_10_20240701104949_b4b5f51f95f64169911bc25652e99f3b_master.jpeg', 121), 
('https://product.hstatic.net/1000003969/product/xanh_txl094_2_20240531210658_705787fd17c3408a8ffb27655599a7e7_master.jpeg', 122), ('https://product.hstatic.net/1000003969/product/xanh_txl094_9_20240506132204_a88c0ffd2dc1493994c22c51968d18bb_master.jpeg', 122), ('https://product.hstatic.net/1000003969/product/xanh_txl094_13_20240506132204_4d267ddcfcd2408b80fe1991727e8c9b_master.jpeg', 122), 
('https://product.hstatic.net/1000003969/product/nau_txl094_2_20240506132203_b8e6910a9f154984adafa2f719f328d0_master.jpeg', 123), ('https://product.hstatic.net/1000003969/product/nau_txl094_3_20240506132203_893c8bccbc134d64a697687f443d775f_master.jpeg', 123), ('https://product.hstatic.net/1000003969/product/nau_txl094_5_20240506132204_5a18dfc3880541c189aa959a399d2259_master.jpeg', 123), 
('https://product.hstatic.net/1000003969/product/den_txl096_12_20240702153619_efa3d2aee13147c8a9b50f2f7b3419cd_master.jpeg', 124), ('https://product.hstatic.net/1000003969/product/den_txl096_2_20240701110025_0e2e82d4a0d64eefab2849e56ccde0d2_master.jpeg', 124), ('https://product.hstatic.net/1000003969/product/den_txl096_13_20240702153618_7e19ffe0474a4a96a10754202a48e985_master.jpeg', 124), 
('https://product.hstatic.net/1000003969/product/kem_txl096_22_20240702153619_e14fda24bc0242d8af4ab3cabedde49e_master.jpeg', 125), ('https://product.hstatic.net/1000003969/product/kem_txl096_10_20240701110141_fc14fd3256524e5186fb5da6be9beda3_master.jpeg', 125), ('https://product.hstatic.net/1000003969/product/kem_txl096_23_20240702153619_c02d8650ffab4f5abf4c491b91fca76e_master.jpeg', 125), 
('https://product.hstatic.net/1000003969/product/hong_txl092_2_20231212164556_622eb0d148054013a1f875934f797642_master.jpeg', 126), ('https://product.hstatic.net/1000003969/product/hong_txl092_2_20231211132930_b4489d8ee8b14b15894592ac5987e184_master.jpeg', 126), ('https://product.hstatic.net/1000003969/product/hong_txl092_3_20231212164556_a2ccee6e1ba34eba9e01d70900879274_master.jpeg', 126), 
('https://product.hstatic.net/1000003969/product/xanh_txl090_3_20231027172453_4fb3bd200cbb4d849414f0513b476414_master.jpeg', 127), ('https://product.hstatic.net/1000003969/product/xanh_txl090_2_20231025000434_1676e07f8b944285a770b2f85c69cb9d_master.jpeg', 127), ('https://product.hstatic.net/1000003969/product/xanh_txl090_2_20231027172453_622307d612ad4b978649d33cfabac81c_master.jpeg', 127), 
('https://product.hstatic.net/1000003969/product/kem_txl085_2_20230524153348_f73c49fc58c047068215aee2712cb275_master.jpeg', 128), ('https://product.hstatic.net/1000003969/product/kem_txl085_2_20230523112632_01bd0697655f4e8bab753e7079ba517c_master.jpeg', 128), ('https://product.hstatic.net/1000003969/product/kem_txl085_3_20230524153348_1a1b5100db154819a5ddb16d3064bb5b_master.jpeg', 128), 
('https://product.hstatic.net/1000003969/product/den_txl080_23_20230415174642_32195c1dc931466b9e71bd494989523b_master.jpeg', 129), ('https://product.hstatic.net/1000003969/product/den_txl080_24_20230415174642_080cb71789424e629085ee72a243db1f_master.jpeg', 129), ('https://product.hstatic.net/1000003969/product/den_txl080_22_20230415174642_09004dd3211e42e1ba54c567621cda92_master.jpeg', 129), 
('https://product.hstatic.net/1000003969/product/kem_txl082_22_20230415180606_b4c541e8f5c94e1f80ad0eed8fc96cca_master.jpeg', 130), ('https://product.hstatic.net/1000003969/product/kem_txl082_24_20230415180606_9a79705b699d41de92a85339287849a9_master.jpeg', 130), ('https://product.hstatic.net/1000003969/product/kem_txl082_23_20230415180606_1084c17887614be98c418c633e7fc77f_master.jpeg', 130), 
('https://product.hstatic.net/1000003969/product/nau_txl083_13_20230415181433_df8d4ed8f8f2468098c247649d46e433_master.jpeg', 131), ('https://product.hstatic.net/1000003969/product/nau_txl083_14_20230415181433_794a1bd384c549a1bd376d3d9969dd6b_master.jpeg', 131), ('https://product.hstatic.net/1000003969/product/nau_txl083_12_20230415181433_670bad7ecbcc4b6a89b4ef073af1fc3c_master.jpeg', 131), 
('https://product.hstatic.net/1000003969/product/kem_txl081_22_20230415175726_27694599ea624d0d9c87b27e2ac4f926_master.jpeg', 132), ('https://product.hstatic.net/1000003969/product/kem_txl081_24_20230415175726_bb9af23554dc46c48d8d0aafd1f8e7cf_master.jpeg', 132), ('https://product.hstatic.net/1000003969/product/kem_txl081_23_20230415175726_58ae133e72cc4152b163cd7077f7913e_master.jpeg', 132), 
('https://product.hstatic.net/1000003969/product/den_txl058_7_f323c07c09c341d0a8ac51cf0c4a7f6a_master.jpg', 133), ('https://product.hstatic.net/1000003969/product/den_txl058_2_9a151cb3eae94cf99a632ad5570a5d07_master.jpg', 133), ('https://product.hstatic.net/1000003969/product/den_txl058_7_f323c07c09c341d0a8ac51cf0c4a7f6a_master.jpg', 133), 
('https://product.hstatic.net/1000003969/product/kem-van_txl064_53_20220826182552_1ec729ebf9124c13b1_52eb04ce61e049b6af8e2d0c864aa005_master.jpeg', 134), ('https://product.hstatic.net/1000003969/product/kem-van_txl064_47_20220808130006_3d1490bdff2040b3a9_9865b640f97343b29318038f00a8272d_master.jpeg', 134), ('https://product.hstatic.net/1000003969/product/kem-van_txl064_54_20220826182552_364806486005457bba_77467e4a9f064ffa9cb4e7438becb4ed_master.jpeg', 134), 
('https://product.hstatic.net/1000003969/product/kem_txl061_8_cba8f2b10b864af187ddd54128d35f9d_master.jpg', 135), ('https://product.hstatic.net/1000003969/product/kem_txl061_2_c86901f04a8548f886e99ba1290371fb_master.jpg', 135), ('https://product.hstatic.net/1000003969/product/kem_txl061_7_9610e807cf444fd684d20e91e88ba60d_master.jpg', 135), 
('https://product.hstatic.net/1000003969/product/vang_txl093_2_20240116162219_811ce8b6648d473cbd4bbfc9341b6e72_master.jpeg', 136), ('https://product.hstatic.net/1000003969/product/vang_txl093_10_20240113090648_aea48186fcf34c479a2ba948a813b38a_master.jpeg', 136), ('https://product.hstatic.net/1000003969/product/vang_txl093_3_20240116162219_6a6a7a788bae4ee9bc08fc0caa8a74e3_master.jpeg', 136), 
('https://product.hstatic.net/1000003969/product/den_txl081_12_20230415175726_cdefe509fde44a46a64d0f28369d1cc0_master.jpeg', 137), ('https://product.hstatic.net/1000003969/product/den_txl081_14_20230415175726_e677a1f61b4b49e1868658ff614a31ab_master.jpeg', 137), ('https://product.hstatic.net/1000003969/product/den_txl081_13_20230415175726_9a83afb80dfc433e8b93207e2e385ee2_master.jpeg', 137);


--12 Balo
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/trang_bl063_17_20230420113556_6ca4de9ef62f449ba225b4a6801e2147_master.jpeg', N'Balo Phom Đứng Hoạ Tiết 3D BL063',499000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Si mờ trơn', N'Balo phong đứng với họa tiết dập nổi 3D lạ mắt, nổi bật. Dây đeo chắc chắn, phối charm tinh tế. Chất liệu da tổng hợp sang trọng, dễ vệ sinh', 12),
	('https://product.hstatic.net/1000003969/product/xanh_bl165_9_20240527124245_3370a3d8a5e844a9a7289adf06136cc5_master.jpeg', N'Balo Nắp Gập Phối Khoá Kéo Trang Trí',549000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Da', N'Balo Nắp Gập Phối Khoá Kéo Trang Trí trẻ trung, năng động. Khoá kim loại trang trí nổi bật. Form dáng nhỏ gọn, không gian túi vừa đủ để nàng đựng các vật dụng cần thiết', 12),
	('https://product.hstatic.net/1000003969/product/kem_bl164_1_20240527122231_96435e6f588f4f468c26737b96ce31dc_master.jpeg', N'Balo Dập Hoạ Tiết Phối Khoá Trang Trí',299000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Balo Dập Hoạ Tiết Phối Khoá Trang Trí phá cách, độc đáo. Dây đeo là sự kết hợp độc đáo giữa dây da và dây da phối xích, có thể điều chỉnh kích cỡ', 12),
	('https://product.hstatic.net/1000003969/product/den_bl161_17_20240113091157_ad610834917d428bb4dee9aab8c8184c_master.jpeg', N'Balo Nhỏ Đính Hoa 3D',549000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Balo nhỏ đính hoa 3D trang trí xinh xắn. Bên trong có một ngăn lớn cho bạn đựng được nhiều vận dụng cần thiết, da tổng hợp cao cấp bền đẹp, dễ vệ sinh.', 12),
	('https://product.hstatic.net/1000003969/product/trang_bl162_17_20240129144807_8a467a4abd614a40b7254ca8e20ffbba_master.jpeg', N'Balo Xoxo',649000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Balo Xoxo với hoạ tiết đôi môi bắt mắt cùng kiểu dáng nhỏ nhắn. Phía trước có một ngăn nhỏ tiện lợi và khoang túi một ngăn rộng có thể đựng nhiều đồ dùng cá nhân.', 12),
	('https://product.hstatic.net/1000003969/product/bac_bl159_1_20240724105842_e0781ea4562d4e658a93221cf1a44425_master.jpeg', N'Balo Mini Cozy',349000 , 50, N'Sweet H', N'Made In VietNam', N'Xám', N'Da', N'Balo mini Cozy với hoạ tiết dập nổi bắt mắt cùng kiểu dáng nhỏ nhắn. Phía trước có một ngăn nhỏ tiện lợi và khoang túi một ngăn rộng có thể đựng nhiều đồ dùng cá nhân', 12),
	('https://product.hstatic.net/1000003969/product/hong_bl158_1_20230829154114_dd8f9daf9335449b9709549df84230ca_master.jpeg', N'Balo Mini - Cycling',399000 , 50, N'Sweet H', N'Made In VietNam', N'Tím', N'Da', N'Balo mini - Cycling với hoạ tiết dập nổi bắt mắt cùng kiểu dáng nhỏ nhắn. Phía trước có một ngăn nhỏ tiện lợi và khoang túi một ngăn rộng có thể đựng nhiều đồ dùng cá nhân.', 12),
	('https://product.hstatic.net/1000003969/product/kem_bl157_1_20230516115947_13af22d76de14c75ae0161439042beca_master.jpeg', N'Balo Tối Giản Phối Họa Tiết Ô Vuông',649000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Balo tối giản phối hoạ tiết ô vuông lạ mắt. Bên trong có một ngăn lớn rộng, đựng được nhiều vận dụng cần thiết và phối khóa kéo tiện dụng', 12),
	('https://product.hstatic.net/1000003969/product/hong_bl147_1_20230206094452_a30977fc1ccb40e8ae2ca95_8e6e88de3f544f58882cfb15ceee57b6_master.jpeg', N'Balo Nhỏ Trang Trí Logo Cách Điệu',549000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Balo nhỏ trang trí logo cách điệu dập nổi xinh xắn. Bên trong có một ngăn lớn rộng, đựng được nhiều vận dụng cần thiết và phối khóa kéo tiện dụng.', 12),
	('https://product.hstatic.net/1000003969/product/kem_bl119_9_20231018125855_783c25554d094aa492b4bfb24aa6cb52_master.jpeg', N'Balo Tay Cầm Nhún',699000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Balo dáng đưng mini, tay cầm nhún mới lạ bắt mắt. Kiểu dáng nhỏ nhắn, khoang túi một ngăn rộng có thể đựng nhiều đồ dùng cá nhân', 12),
	('https://product.hstatic.net/1000003969/product/xanh_bl128_1_trans_20220719170727_83525eba50ab4a7d8_238c33175c104789ba5ec1b388489022_master.jpeg', N'Balo Chần Bông Cách Điệu',449000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Da', N'Balo chần bông cách điệu lạ mắt. Bên ngoài có 1 ngăn khóa bấm, bên trong có 1 ngăn lớn rộng rãi tiện dụng, phù hợp mang nhiều dịp: đi học, đi làm, dạo phố', 12),
	('https://product.hstatic.net/1000003969/product/den_bl151_9_20230221105527_575ce14b36a542f19d65fb2d_10dc4ad555da42e48dd2ddd04ac33083_master.jpeg', N'Balo May Chỉ Trang Trí',349000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Balo may chỉ trang trí thời trang, nữ tính. Bên trong có một ngăn lớn cho bạn đựng được nhiều vận dụng cần thiết, bền đẹp, dễ vệ sinh, sử dụng nhiều dịp: đi làm, dạo phố..', 12),
	('https://product.hstatic.net/1000003969/product/kem-dam_bl146_17_20230109095939_87744d29bf58467599f_2cbaf71d83ea4311a2fc6a5770314a77_master.jpeg', N'Balo Phối Khoá Trang Trí',699000 , 50, N'Sweet H', N'Made In VietNam', N'Hồng', N'Da', N'Balo phối khoá trang trí năng động, thời trang. Bên trong có ngăn đựng lớn giúp bạn đựng được nhiều vận dụng cần thiết, bền đẹp, dễ vệ sinh, sử dụng nhiều dịp: đi làm, dạo phố.', 12),
	('https://product.hstatic.net/1000003969/product/kem_bl107_1_552c9c8270b04abab841df6d6b583d6b_master.jpg', N'Balo 1 Ngăn Trước',549000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Da', N'Ba lô tối giản với ngăn trước tiện dụng, hiện đại. Bên trong có 01 ngăn lớn rộng rãi đựng vừa khổ A4 và ngăn nhỏ tiện dụng. Bên ngoài là ngăn cỡ vừa kèm khóa kéo', 12),
	('https://product.hstatic.net/1000003969/product/den_bl158_11_20230828105441_ab565f794e484afa9e732fe0edec945b_master.jpeg', N'Balo Mini - Cycling',349000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Balo mini - Cycling với hoạ tiết dập nổi bắt mắt cùng kiểu dáng nhỏ nhắn. Phía trước có một ngăn nhỏ tiện lợi và khoang túi một ngăn rộng có thể đựng nhiều đồ dùng cá nhân.', 12),
	('https://product.hstatic.net/1000003969/product/den_bl164_17_20240527151910_e40ed48cb85349199b3193fa5c6e265d_master.jpeg', N'Balo Dập Hoạ Tiết Phối Khoá Trang Trí',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Da', N'Balo Dập Hoạ Tiết Phối Khoá Trang Trí phá cách, độc đáo. Dây đeo là sự kết hợp độc đáo giữa dây da và dây da phối xích, có thể điều chỉnh kích cỡ', 12),
	('https://product.hstatic.net/1000003969/product/nau_bl165_1_20240527124246_9ec1d855068a4615af994b9191edf23a_master.jpeg', N'Balo Nắp Gập Phối Khoá Kéo Trang Trí',199000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Da', N'Balo Nắp Gập Phối Khoá Kéo Trang Trí trẻ trung, năng động. Khoá kim loại trang trí nổi bật. Form dáng nhỏ gọn, không gian túi vừa đủ để nàng đựng các vật dụng cần thiết', 12),
	('https://product.hstatic.net/1000003969/product/den_bl063_33_20230420113556_45798ba6adf5482c9add83adef28628c_master.jpeg', N'Balo Phom Đứng Hoạ Tiết 3D BL063',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Si mờ trơn', N'Balo phong đứng với họa tiết dập nổi 3D lạ mắt, nổi bật. Dây đeo chắc chắn, phối charm tinh tế. Chất liệu da tổng hợp sang trọng, dễ vệ sinh', 12);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/trang_bl063_7_3893e25c82ba4ed79b5f68c5d28b1f4b_master.jpg', 138), ('https://product.hstatic.net/1000003969/product/trang_bl063_3_e2a47a6823b24671ae4e7125bfb53992_master.jpg', 138), ('https://product.hstatic.net/1000003969/product/trang_bl063_8_3083a0ea273a4af2b49049cb9345df7b_master.jpg', 138), 
('https://product.hstatic.net/1000003969/product/xanh_bl165_2_20240528154507_1d0393e109804ed4ba748f7a2484c627_master.jpeg', 139), ('https://product.hstatic.net/1000003969/product/xanh_bl165_10_20240527124245_5192f5de625b47c88d994082f51c2b43_master.jpeg', 139), ('https://product.hstatic.net/1000003969/product/xanh_bl165_3_20240528154508_5c23a99e187f4f4b9dda5b3b2b7e8938_master.jpeg', 139), 
('https://product.hstatic.net/1000003969/product/kem_bl164_12_20240531171005_d0988821dd73464a8753bc16ee6dc4aa_master.jpeg', 140), ('https://product.hstatic.net/1000003969/product/kem_bl164_2_20240527122231_61034b484d8b4200aa59b511e6d16ac2_master.jpeg', 140), ('https://product.hstatic.net/1000003969/product/kem_bl164_13_20240531171005_6edf06153aab474f8b4b5f3f97a266d1_master.jpeg', 140), 
('https://product.hstatic.net/1000003969/product/den_bl161_2_20240116162005_0a9c6b564a794cc39a5f1f3d68fb75b6_master.jpeg', 141), ('https://product.hstatic.net/1000003969/product/den_bl161_2_20240115200704_d959862e53e441148b5d7bb23549e512_master.jpeg', 141), ('https://product.hstatic.net/1000003969/product/den_bl161_3_20240116162006_fa74bb13719b4c6aa952d139be9934cb_master.jpeg', 141), 
('https://product.hstatic.net/1000003969/product/trang_bl162_22_20240130163010_e9286f345d724027926d97e6dc334bfd_master.jpeg', 142), ('https://product.hstatic.net/1000003969/product/trang_bl162_18_20240129144807_aee8c8fbbe0d42ce9b0822c78e4efe51_master.jpeg', 142), ('https://product.hstatic.net/1000003969/product/trang_bl162_23_20240130163010_a49dfec6a1154aeebfba7bef1ef28dc8_master.jpeg', 142), 
('https://product.hstatic.net/1000003969/product/bac_bl159_2_20231005105145_e32a6a3631754e6e8e64ae08c1c0721b_master.jpeg', 143), ('https://product.hstatic.net/1000003969/product/bac_bl159_14_20231002110505_58c66b2227f54edc93cab275e1490254_master.jpeg', 143), ('https://product.hstatic.net/1000003969/product/bac_bl159_15_20231002110506_a0b04208a00e4f95821940b3854a0f39_master.jpeg', 143), 
('https://product.hstatic.net/1000003969/product/hong_bl158_2_20230830093116_dbd44378bf064baf9c4c254172f7a85a_master.jpeg', 144), ('https://product.hstatic.net/1000003969/product/hong_bl158_4_20230829154114_19bd7c1eba1e4d15b0f0100ff10106f4_master.jpeg', 144), ('https://product.hstatic.net/1000003969/product/hong_bl158_2_20230830093116_dbd44378bf064baf9c4c254172f7a85a_master.jpeg', 144), 
('https://product.hstatic.net/1000003969/product/kem_bl157_2_20230516182436_596ff65a8f6a461fb4cc18689ad719b7_master.jpeg', 145), ('https://product.hstatic.net/1000003969/product/kem_bl157_2_20230516115947_e3c41aa7e62d4e969de2f54563c13e58_master.jpeg', 145), ('https://product.hstatic.net/1000003969/product/kem_bl157_3_20230516182436_93c7dc53402d453a9062876814534443_master.jpeg', 145), 
('https://product.hstatic.net/1000003969/product/hong_bl147_2_20230210133027_20efd8a83b84418cabee6e2_d3e4c4e0a2d642d79f680ece306db661_master.jpeg', 146), ('https://product.hstatic.net/1000003969/product/hong_bl147_2_20230206094452_c0a154c9795d43e586cd2c5_340f478bcc014683b1fecf4c34c08f60_master.jpeg', 146), ('https://product.hstatic.net/1000003969/product/hong_bl147_3_20230210133027_4837f428a4e245eeaf90680_257469df1e3747c5bbc08e16de65d0af_master.jpeg', 146), 
('https://product.hstatic.net/1000003969/product/kem_bl119_10_20231020141118_60db055a3a8b4cd98026a5c77da59d93_master.jpeg', 147), ('https://product.hstatic.net/1000003969/product/kem_bl119_10_20231018125855_eabdf71abe084c0295e2129208cd1ad1_master.jpeg', 147), ('https://product.hstatic.net/1000003969/product/kem_bl119_11_20231020141118_9e4de817a72749639499d59bcfa09f0e_master.jpeg', 147), 
('https://product.hstatic.net/1000003969/product/xanh_bl128_7_e1f74b4b3cee4625b8f9ab8b3cb1ef56_master.jpg', 148), ('https://product.hstatic.net/1000003969/product/xanh_bl128_2_c3b162ffd32d42c48f934e9ad9c6719c_master.jpg', 148), ('https://product.hstatic.net/1000003969/product/xanh_bl128_8_b2a2100021f7406f86b1d9170bb3c1cb_master.jpg', 148), 
('https://product.hstatic.net/1000003969/product/den_bl151_12_20230223135804_0e1db1818b2c443b97993f8_5539b1db7fb04230bb121b74b3d7bf6c_master.jpeg', 149), ('https://product.hstatic.net/1000003969/product/den_bl151_10_20230217214705_ab42cc00360440829c1158a_94146f2f85e24bc5a2b53f828795585f_master.jpeg', 149), ('https://product.hstatic.net/1000003969/product/den_bl151_9_20230221105527_575ce14b36a542f19d65fb2d_10dc4ad555da42e48dd2ddd04ac33083_master.jpeg', 149), 
('https://product.hstatic.net/1000003969/product/kem-dam_bl146_19_20230109095939_f58cdb3213a7455c82b_20cf03def59d456d8674b2688e49ce81_master.jpeg', 150), ('https://product.hstatic.net/1000003969/product/kem-dam_bl146_21_20230109095939_d9554c112401433ab61_2bbacf6778d94aa0a832f2957ac5a2b5_master.jpeg', 150), ('https://product.hstatic.net/1000003969/product/kem-dam_bl146_18_20230109095939_75c88af0c821430f8b5_9d91c9cc09d746beaeb37edb46a8719b_master.jpeg', 150), 
('https://product.hstatic.net/1000003969/product/kem_bl107_7_d13e3748ecc642ff825137d589907419_master.jpg', 151), ('https://product.hstatic.net/1000003969/product/kem_bl107_2_3b7137ff8f0f487e8b90bef55c3ac8ea_master.jpg', 151), ('https://product.hstatic.net/1000003969/product/kem_bl107_8_884c325fdb314cc08bdcb11d876e39e1_master.jpg', 151), 
('https://product.hstatic.net/1000003969/product/den_bl158_13_20230828105442_b813720449a64e028b9aef38f43dc658_master.jpeg', 152), ('https://product.hstatic.net/1000003969/product/den_bl158_14_20230828105442_d6ce101c4e9c4182a51ed163faf656bd_master.jpeg', 152), ('https://product.hstatic.net/1000003969/product/den_bl158_12_20230828105442_d4873a283d3249d2ad9e4f6bae5d96f6_master.jpeg', 152), 
('https://product.hstatic.net/1000003969/product/den_bl164_22_20240531171005_62d39f41aede4bd4a275e808c2524749_master.jpeg', 153), ('https://product.hstatic.net/1000003969/product/den_bl164_18_20240527151910_f34d1852dee1483aa37e0e5888ff045b_master.jpeg', 153), ('https://product.hstatic.net/1000003969/product/den_bl164_23_20240531171005_e30bec451b0442398dd4a6c626da951a_master.jpeg', 153), 
('https://product.hstatic.net/1000003969/product/nau_bl165_12_20240604225839_03362b5b0e164ebc9f6170f00e1ec48f_master.jpeg', 154), ('https://product.hstatic.net/1000003969/product/nau_bl165_2_20240527124246_4e71ba120d6342f59a0f2516130761cb_master.jpeg', 154), ('https://product.hstatic.net/1000003969/product/nau_bl165_13_20240604225839_2c5750f760a140369c0c72954510bb4a_master.jpeg', 154), 
('https://product.hstatic.net/1000003969/product/den_bl063_7_4b902d0a110d4bd2a0c1483914453d83_master.jpg', 155), ('https://product.hstatic.net/1000003969/product/den_bl063_2_4d4652fec6704d2287bbcf76943983fe_master.jpg', 155), ('https://product.hstatic.net/1000003969/product/den_bl063_8_da505e8149e64eb0bdb5b0f12ccb36c0_master.jpg', 155);


--13 Ví - Clutch
INSERT INTO products (thumbnail_image, [name], price, quantity, brand, made_in, color, material, description, category_id) VALUES
    ('https://product.hstatic.net/1000003969/product/den_jndng023_1_20240719142822_409f5df19ca341f8893f7beca2ced221_master.jpeg', N'Đầm Bí Hạ Vai',499000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm Bí Hạ Vai nữ tính, nổi bật và thu hút. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_8_20240528181636_048f4c63ac9640b8a6d19e1cf186718a_master.jpeg', N'Đầm Mini Tay Ngắn Nút J',549000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh đen', N'Cotton', N'Trang phục được thiết kế đơn giản tập trung vào chất liệu vải denim cao cấp tạo sự thoải mái tối đa cho người mặc', 13),
	('https://product.hstatic.net/1000003969/product/kem_jndng014_1_20230313202310_d4b02a4bd8244a58846da1987f35b5ef_master.jpeg', N'Đầm Ngắn 2 Dây Cup Ngực',299000 , 50, N'Sweet H', N'Made In VietNam', N'Trắng', N'Cotton', N'Đầm ngắn 2 dây cup ngực sang trọng, gợi cảm. Trang phục phù hợp dạo phố, thường ngày, đi tiệc', 13),
	('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_2_20230526141427_bd4757e76a2e425b9cea2a7a084446c9_master.jpeg', N'Đầm Sơmi Dáng Dài',499000 , 50, N'Sweet H', N'Made In VietNam', N'Sọc trắng đỏ', N'Cotton', N'Đầm sơmi thun lưng dáng dài thanh lịch, hiện đại. Trang phục phù hợp dạo phố, thường ngày, đi làm...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu063_1_20231011103409_72e78c6330e64dec874da64f74994858_master.jpeg', N'Đầm Thun Ôm Midi',449000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm thun ôm midi thời trang, nữ tính.  Trang phục phù hợp dạo phố, thường ngày,...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu038_13_20221115121450_ef820acb61de4ac99e1d_568bfd0761e34888a490c0631055d7d6_master.jpeg', N'Đầm Ngắn Tay Dài Xếp Ly',349000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm ngắn tay dài xếp ly nữ tính, xinh xắn. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/den_jndng016_10_20230918201415_d6dc09c2a0e04cfa8f8755aa4666aa0b_master.jpeg', N'Đầm Caro 2 Dây Smocking',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm caro 2 dây smocking thời trang, nữ tính. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu063_1_20231011103409_72e78c6330e64dec874da64f74994858_master.jpeg', N'Đầm Thun Ôm Midi',449000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm thun ôm midi thời trang, nữ tính.  Trang phục phù hợp dạo phố, thường ngày,...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu038_13_20221115121450_ef820acb61de4ac99e1d_568bfd0761e34888a490c0631055d7d6_master.jpeg', N'Đầm Ngắn Tay Dài Xếp Ly',349000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm ngắn tay dài xếp ly nữ tính, xinh xắn. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/den_jndng016_10_20230918201415_d6dc09c2a0e04cfa8f8755aa4666aa0b_master.jpeg', N'Đầm Caro 2 Dây Smocking',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm caro 2 dây smocking thời trang, nữ tính. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu063_1_20231011103409_72e78c6330e64dec874da64f74994858_master.jpeg', N'Đầm Thun Ôm Midi',449000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm thun ôm midi thời trang, nữ tính.  Trang phục phù hợp dạo phố, thường ngày,...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu038_13_20221115121450_ef820acb61de4ac99e1d_568bfd0761e34888a490c0631055d7d6_master.jpeg', N'Đầm Ngắn Tay Dài Xếp Ly',349000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm ngắn tay dài xếp ly nữ tính, xinh xắn. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/den_jndng016_10_20230918201415_d6dc09c2a0e04cfa8f8755aa4666aa0b_master.jpeg', N'Đầm Caro 2 Dây Smocking',399000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm caro 2 dây smocking thời trang, nữ tính. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu063_1_20231011103409_72e78c6330e64dec874da64f74994858_master.jpeg', N'Đầm Thun Ôm Midi',449000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm thun ôm midi thời trang, nữ tính.  Trang phục phù hợp dạo phố, thường ngày,...', 13),
	('https://product.hstatic.net/1000003969/product/nau_jndlu038_13_20221115121450_ef820acb61de4ac99e1d_568bfd0761e34888a490c0631055d7d6_master.jpeg', N'Đầm Ngắn Tay Dài Xếp Ly',349000 , 50, N'Sweet H', N'Made In VietNam', N'Nâu', N'Cotton', N'Đầm ngắn tay dài xếp ly nữ tính, xinh xắn. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/xanh_jndlu046_1_20221019115727_e67e362c9170482788e8_04e0eb75905240558163ed3d977f5e3e_master.jpeg', N'Đầm Mini Cổ Sơ Mi Vai Chờm',399000 , 50, N'Sweet H', N'Made In VietNam', N'Xanh', N'Cotton', N'Đầm mini cổ sơ mi vai chờm năng động, thời trang. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/den_jndlu054_2_20221205114455_4795f8420b7c43ebbad6687d8e5a0b65_master.jpeg', N'Đầm Mini Phối Ren Cúp Ngực Tay Dài',199000 , 50, N'Sweet H', N'Made In VietNam', N'Đen', N'Cotton', N'Đầm mini phối ren cúp ngực tay dài thời trang, gợi cảm. Trang phục phù hợp dạo phố, thường ngày, đi tiệc...', 13),
	('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_4_20240528180832_31130efa5bcf4ceb8253fd5a9ac1b479_master.jpeg', N'Đầm Maxi 2 Dây Phối Ren',399000 , 50, N'Sweet H', N'Made In VietNam', N'Sọc Xanh', N'Cotton', N'Đầm maxi 2 dây phối ren thời trang, năng động. Đầm 2 dây sọc dọc tạo cảm giác thon thả cho nàng. Phối màu hiện đại', 13);

  -- Insert data into product_images
INSERT INTO product_images (image_url, product_id) VALUES
('https://product.hstatic.net/1000003969/product/den_jndng023_2_20240719142822_181a8ccc2a4d4f409a7d1be6aa8c257c_master.jpeg', 156), ('https://product.hstatic.net/1000003969/product/den_jndng023_3_20240719142822_f1558836467446ac8458a314185b7fd5_master.jpeg', 156), ('https://product.hstatic.net/1000003969/product/den_jndng023_4_20240719142822_44de24a3c5b245e9b17510d6e52eb925_master.jpeg', 156), 
('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_7_20240528181636_43daf4bec7b445bea1586a08d9e9924d_master.jpeg', 157), ('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_12_20240528181636_14f6ebc1ebe94b5a8d48d279975bd94e_master.jpeg', 157), ('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_10_20240528181636_20d2ff0500bb467485476a7d511581ea_master.jpeg', 157), 
('https://product.hstatic.net/1000003969/product/kem_jndng014_2_20230313202310_d579ca759ae5466bb67f44fac12052ef_master.jpeg', 158), ('https://product.hstatic.net/1000003969/product/kem_jndng014_3_20230313202310_861163831b1b466b904647f89e385fbb_master.jpeg', 158), ('https://product.hstatic.net/1000003969/product/kem_jndng014_5_20230313202310_3a87647173314761be24f9f90f2677b4_master.jpeg', 158), 
('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_1_20230526141427_a0bc44383a4e475cb9da7245bd53fff7_master.jpeg', 159), ('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_6_20230526141428_dae0a82ef12044cea8fde933990fa4d6_master.jpeg', 159), ('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_5_20230526141428_97290daa2865497cb34b1b51b88b1bc2_master.jpeg', 159), 
('https://product.hstatic.net/1000003969/product/nau_jndlu063_2_20231011103409_c9b9a5e028454f08b34d9b049745bbbf_master.jpeg', 160), ('https://product.hstatic.net/1000003969/product/nau_jndlu063_3_20231011103410_60a4a998414f4abb8d4537eb01764874_master.jpeg', 160), ('https://product.hstatic.net/1000003969/product/nau_jndlu063_5_20231011103410_ec6e2ce9b4a94f24ab47b5436bb437de_master.jpeg', 160), 
('https://product.hstatic.net/1000003969/product/nau_jndlu038_14_20221115121450_725e945b50e0461c989f_a81472ca05854c77bee57c77ddc1094d_master.jpeg', 161), ('https://product.hstatic.net/1000003969/product/nau_jndlu038_16_20221115121450_bd2f0a90254f41078bc5_7cc861f94a2445b4b3ca7e375b6dc6e6_master.jpeg', 161), ('https://product.hstatic.net/1000003969/product/nau_jndlu038_17_20221115121450_68cc72f154b44661aaa2_c072ee8a623c487aa96d6b8f35827ecb_master.jpeg', 161), 
('https://product.hstatic.net/1000003969/product/den_jndng016_7_20230918201415_80e4e4c50acf46188e5996d03faa1dd7_master.jpeg', 162), ('https://product.hstatic.net/1000003969/product/den_jndng016_11_20230918201415_e76d792dfd8c40e0b190812c511a514c_master.jpeg', 162), ('https://product.hstatic.net/1000003969/product/den_jndng016_8_20230918201415_d3d317a8941c4dffa63f7e538f070253_master.jpeg', 162), 
('https://product.hstatic.net/1000003969/product/xanh_jndlu046_2_20221019115727_6d62d3bb44704433b93a_3fd9ad448b8f48e5bf44269d0ceec29a_master.jpeg', 163), ('https://product.hstatic.net/1000003969/product/xanh_jndlu046_4_20221019115727_e1cfc56f0d5748c8af1b_ddcbcf7e730f4f0a89cf9e3301ef19eb_master.jpeg', 163), ('https://product.hstatic.net/1000003969/product/xanh_jndlu046_3_20221019115727_e40b2b79979c461d88b6_bfad1a8fa70249b29dac1a4091a254c3_master.jpeg', 163), 
('https://product.hstatic.net/1000003969/product/den_jndlu054_1_20221205114455_cd6096b83079423ea64c5a0e501c6ec0_master.jpeg', 164), ('https://product.hstatic.net/1000003969/product/den_jndlu054_3_20221205114455_bf6c6181e7764f9fad67aac23563f8ab_master.jpeg', 164), ('https://product.hstatic.net/1000003969/product/den_jndlu054_5_20221205114456_e357151baeba4341a017756af2791d8e_master.jpeg', 164), 
('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_7_20240528181636_43daf4bec7b445bea1586a08d9e9924d_master.jpeg', 165), ('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_12_20240528181636_14f6ebc1ebe94b5a8d48d279975bd94e_master.jpeg', 165), ('https://product.hstatic.net/1000003969/product/xanh-den_jndng019_10_20240528181636_20d2ff0500bb467485476a7d511581ea_master.jpeg', 165), 
('https://product.hstatic.net/1000003969/product/kem_jndng014_2_20230313202310_d579ca759ae5466bb67f44fac12052ef_master.jpeg', 166), ('https://product.hstatic.net/1000003969/product/kem_jndng014_3_20230313202310_861163831b1b466b904647f89e385fbb_master.jpeg', 166), ('https://product.hstatic.net/1000003969/product/kem_jndng014_5_20230313202310_3a87647173314761be24f9f90f2677b4_master.jpeg', 166), 
('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_1_20230526141427_a0bc44383a4e475cb9da7245bd53fff7_master.jpeg', 167), ('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_6_20230526141428_dae0a82ef12044cea8fde933990fa4d6_master.jpeg', 167), ('https://product.hstatic.net/1000003969/product/soc-trang-do_jndda002_5_20230526141428_97290daa2865497cb34b1b51b88b1bc2_master.jpeg', 167), 
('https://product.hstatic.net/1000003969/product/nau_jndlu063_2_20231011103409_c9b9a5e028454f08b34d9b049745bbbf_master.jpeg', 168), ('https://product.hstatic.net/1000003969/product/nau_jndlu063_3_20231011103410_60a4a998414f4abb8d4537eb01764874_master.jpeg', 168), ('https://product.hstatic.net/1000003969/product/nau_jndlu063_5_20231011103410_ec6e2ce9b4a94f24ab47b5436bb437de_master.jpeg', 168), 
('https://product.hstatic.net/1000003969/product/nau_jndlu038_14_20221115121450_725e945b50e0461c989f_a81472ca05854c77bee57c77ddc1094d_master.jpeg', 169), ('https://product.hstatic.net/1000003969/product/nau_jndlu038_16_20221115121450_bd2f0a90254f41078bc5_7cc861f94a2445b4b3ca7e375b6dc6e6_master.jpeg', 169), ('https://product.hstatic.net/1000003969/product/nau_jndlu038_17_20221115121450_68cc72f154b44661aaa2_c072ee8a623c487aa96d6b8f35827ecb_master.jpeg', 169), 
('https://product.hstatic.net/1000003969/product/den_jndng016_7_20230918201415_80e4e4c50acf46188e5996d03faa1dd7_master.jpeg', 170), ('https://product.hstatic.net/1000003969/product/den_jndng016_11_20230918201415_e76d792dfd8c40e0b190812c511a514c_master.jpeg', 170), ('https://product.hstatic.net/1000003969/product/den_jndng016_8_20230918201415_d3d317a8941c4dffa63f7e538f070253_master.jpeg', 170), 
('https://product.hstatic.net/1000003969/product/xanh_jndlu046_2_20221019115727_6d62d3bb44704433b93a_3fd9ad448b8f48e5bf44269d0ceec29a_master.jpeg', 171), ('https://product.hstatic.net/1000003969/product/xanh_jndlu046_4_20221019115727_e1cfc56f0d5748c8af1b_ddcbcf7e730f4f0a89cf9e3301ef19eb_master.jpeg', 171), ('https://product.hstatic.net/1000003969/product/xanh_jndlu046_3_20221019115727_e40b2b79979c461d88b6_bfad1a8fa70249b29dac1a4091a254c3_master.jpeg', 171), 
('https://product.hstatic.net/1000003969/product/den_jndlu054_1_20221205114455_cd6096b83079423ea64c5a0e501c6ec0_master.jpeg', 172), ('https://product.hstatic.net/1000003969/product/den_jndlu054_3_20221205114455_bf6c6181e7764f9fad67aac23563f8ab_master.jpeg', 172), ('https://product.hstatic.net/1000003969/product/den_jndlu054_5_20221205114456_e357151baeba4341a017756af2791d8e_master.jpeg', 172), 
('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_3_20240528180832_a5c3d5dd0b20407a8936fc2f73fa62cd_master.jpeg', 173), ('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_1_20240528180832_7cff891d266a468093ee300c5678f4ee_master.jpeg', 173), ('https://product.hstatic.net/1000003969/product/soc-xanh_jndda006_2_20240528180832_166016d0825e4fcc81eb8c3a96c116d3_master.jpeg', 173);

go

go

--14 Giày sandal

--15 Giày cao gót

--16 Giày Sneakers

--17 Giày búp bê

--18 Dép guốc

go

go

--19 Parisian Chic

--20 Summer Ombre

--21 Summer Play

--22 Sunshine Retreat

--23 The Raw MySelf

--24 Love Is In The Air

--25 X-mas

--26 Magic Snow

--27 Panorama Diamond

--28 Panorama City

--29 Lady Moon

--30 Feelin Fall


go


go
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

select * from products
--  drop database SweetH_Clothes_Store