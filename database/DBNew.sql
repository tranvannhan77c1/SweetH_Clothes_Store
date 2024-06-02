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
	[size] nvarchar(255)  not null,
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
    phone nvarchar(10),
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