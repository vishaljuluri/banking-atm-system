create database if not exists bank_db;
use bank_db;


create table customers(
    customer_id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) unique not null,
    phone varchar(15) not null,
    created_at timestamp default current_timestamp
);

create table accounts(
    account_number bigint primary key,
    customer_id int not null, 
    account_type enum('SAVINGS','CURRENT') not null,
    balance decimal(15,2) not null default 0.00,
    pin_hash varchar(64) not null,
    failed_attempts int not null default 0,
    status enum('ACTIVE','LOCKED') not null default 'ACTIVE',
    created_at timestamp default current_timestamp,
    
    foreign key (customer_id)
    references customers(customer_id),

    constraint chk_balance check (balance >= 0)
);

create table transactions(
    txn_id bigint primary key auto_increment,
    account_number bigint not null,
    txn_type enum('DEPOSIT','WITHDRAW','TRANSFER_OUT','TRANSFER_IN') not null,
    amount decimal(15,2) not null,
    balance_after decimal(15,2) not null,
    related_account bigint null,
    txn_time timestamp default current_timestamp,
    
    foreign key (account_number)
    references accounts(account_number),
    
    foreign key (related_account)
    references accounts(account_number)
);