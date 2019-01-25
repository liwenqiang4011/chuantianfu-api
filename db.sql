#创建数据库
CREATE DATABASE chuantianfu CHARSET=UTF8;

USE chuantianfu;

#1.管理员信息表
CREATE TABLE ctf_admin (
    aid INT PRIMARY KEY  AUTO_INCREMENT,
    aname VARCHAR(32) UNIQUE,
    apwd VARCHAR(64) 
);

INSERT INTO ctf_admin VALUES(null,'xiaoming',md5('123456'));

#2.项目全局设置 ctf_settings
CREATE TABLE ctf_settings (
    sid INT PRIMARY KEY  AUTO_INCREMENT,
    appName VARCHAR(32),#店家名称
    apiUrl VARCHAR(64), #数据API子系统地址
    AdminUrl VARCHAR(64), #管理后台子系统地址
    appUrl VARCHAR(64), #顾客App子系统地址
    icp VARCHAR(64), #系统备案号
    copyright VARCHAR(128) #系统版权声明   
);

INSERT INTO ctf_settings VALUES(null,'小肥牛','http://127.0.0.1:8090','ht8091tp://127.0.0.1:','http://127.0.0.1:8092','京ICP备12003709号-3','Copyright © 2002-2019 北京达内金桥科技有限公司版权所有');

#3.桌台信息表：ctf_table
CREATE TABLE ctf_table (
    tid INT PRIMARY KEY  AUTO_INCREMENT, #桌台编号
    tname VARCHAR(64),#桌台昵称
    type VARCHAR(16),#桌台类型（3-4人）
    status INT  #当前状态
);

INSERT INTO ctf_table VALUES(null,'一号桌','3-4',0);
INSERT INTO ctf_table VALUES(null,'二号桌','3-4',1);
INSERT INTO ctf_table VALUES(null,'三号桌','3-4',2);
INSERT INTO ctf_table VALUES(null,'四号桌','3-4',3);

#4.桌台预定信息表：ctf_reservation
CREATE TABLE ctf_reservation(
    rid INT PRIMARY KEY  AUTO_INCREMENT, #信息编号
    contactName VARCHAR(64), #联系人姓名
    phone VARCHAR(16), #联系电话
    contactTime BIGINT, #联系时间
    dinnerTime BIGINT #预约的用餐时间
);



#5.菜品分类
CREATE TABLE ctf_category(
    cid INT PRIMARY KEY  AUTO_INCREMENT, #类别编号
    cname VARCHAR(32) #类别名称
);

INSERT INTO ctf_category VALUES(null,'肉类');
INSERT INTO ctf_category VALUES(null,'海鲜河虾');
INSERT INTO ctf_category VALUES(null,'丸滑类');

#6.菜品信息表：ctf_dish
CREATE TABLE ctf_dish(
    did INT PRIMARY KEY  AUTO_INCREMENT, #菜品编号，起始值为100000
    title VARCHAR(32), #菜品名称/标题
    imgUrl VARCHAR(128), #图片地址
    price DECIMAL(6,2), #价格
    detail VARCHAR(128), #详细描述信息
    categoryId INT,
    FOREIGN KEY(categoryId) REFERENCES ctf_category(cid)
);

INSERT INTO ctf_dish VALUES(100000,'招牌虾滑','img/01.jpg',20.6,'精选湛江、北海区域出产的南美品种白虾虾仁，配以盐和淀粉等调料制作而成。虾肉含量越高，虾滑口感越纯正。相比纯虾肉，虾滑食用方便、入口爽滑鲜甜Q弹，海底捞独有的定制生产工艺，含肉量虾肉含量93%，出品装盘前手工摔打10次，是火锅中的经典食材。',1);

#7.订单信息表 ctf_order
CREATE TABLE ctf_order(
    oid INT PRIMARY KEY  AUTO_INCREMENT, #菜品编号，起始值为100000
    startTime BIGINT, #开始时间
    endTime BIGINT, #结束时间
    customerCount INT, #用餐人数
    tableId INT, #桌台编号
    FOREIGN KEY(tableId) REFERENCES ctf_table(tid)
);


#8.订单表 ctf_order_detail
CREATE TABLE ctf_order(
    did INT PRIMARY KEY  AUTO_INCREMENT, #订单编号
    dishId INT, #菜品编号
    FOREIGN KEY(dishId) REFERENCES ctf_dish(did),
    dishCount INT, #菜品数量
    customerName VARCHAR(64), #点餐用户的称呼
    orderId INT,#订单编号
    FOREIGN KEY(orderId) REFERENCES ctf_order(oid)
);