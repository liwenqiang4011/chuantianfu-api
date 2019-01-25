#设置客户端语言
SET NAMES UTF8;

#放弃数据库(如果存在)
DROP DATABASE IF EXISTS chuantianfu; 

#创建数据库
CREATE DATABASE chuantianfu CHARSET=UTF8;

USE chuantianfu;

#1.管理员信息表
CREATE TABLE ctf_admin (
    aid INT PRIMARY KEY  AUTO_INCREMENT,
    aname VARCHAR(32) UNIQUE,
    apwd VARCHAR(64) 
);

INSERT INTO ctf_admin VALUES(null,'admin',PASSWORD('123456'));
INSERT INTO ctf_admin VALUES(null,'boss',PASSWORD('999999'));

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

INSERT INTO ctf_settings VALUES(null,'川天府','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','陕ICP备12003709号-3','Copyright © 2002-2019 北京达内金桥科技有限公司版权所有');

#3.桌台信息表：ctf_table
CREATE TABLE ctf_table (
    tid INT PRIMARY KEY  AUTO_INCREMENT, #桌台编号
    tname VARCHAR(64),#桌台昵称
    type VARCHAR(16),#桌台类型（3-4人）
    status INT  #当前状态
);

INSERT INTO ctf_table VALUES(null,'福满堂','3-4人桌',0);
INSERT INTO ctf_table VALUES(null,'金镶玉','6-8人桌',1);
INSERT INTO ctf_table VALUES(null,'寿齐天','10人桌',2);
INSERT INTO ctf_table VALUES(null,'全家福','3-4人桌',3);

#4.桌台预定信息表：ctf_reservation
CREATE TABLE ctf_reservation(
    rid INT PRIMARY KEY  AUTO_INCREMENT, #信息编号
    contactName VARCHAR(64), #联系人姓名
    phone VARCHAR(16), #联系电话
    contactTime BIGINT, #联系时间
    dinnerTime BIGINT, #预约的用餐时间
    tableId INT,
    FOREIGN KEY(tableId) REFERENCES ctf_table(tid)
);
INSERT INTO ctf_reservation VALUES(null,'唐三藏','12545895231',1548404903247,1548446400000,1);
INSERT INTO ctf_reservation VALUES(null,'孙悟空','12545895231',1548404945893,1548446400000,2);



#5.菜品分类
CREATE TABLE ctf_category(
    cid INT PRIMARY KEY  AUTO_INCREMENT, #类别编号
    cname VARCHAR(32) #类别名称
);

INSERT INTO ctf_category VALUES(null,'肉类');
INSERT INTO ctf_category VALUES(null,'海鲜河虾');
INSERT INTO ctf_category VALUES(null,'丸滑类');
INSERT INTO ctf_category VALUES(null,'蔬菜豆制品');
INSERT INTO ctf_category VALUES(null,'菌菇类');

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
INSERT INTO ctf_dish VALUES(100000,'草鱼片','pic_004.jpg',20.6,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'招牌虾滑','pic_073.jpg',40,'精选湛江、北海区域出产的南美品种白虾虾仁，配以盐和淀粉等调料制作而成。虾肉含量越高，虾滑口感越纯正。相比纯虾肉，虾滑食用方便、入口爽滑鲜甜Q弹，海底捞独有的定制生产工艺，含肉量虾肉含量93%，出品装盘前手工摔打10次，是火锅中的经典食材。',2);
INSERT INTO ctf_dish VALUES(null,'脆皮肠','pic_006.jpg',20.6,'锅开后再煮3分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'酥肉','pic_007.jpg',20.6,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮3分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'现炸酥肉(非清真)','pic_008.jpg',20.6,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮1分钟左右即可食用，也可直接食用。',1);
INSERT INTO ctf_dish VALUES(null,'牛百叶','pic_011.jpg',20.6,'毛肚切丝后，配以调味料腌制而成。锅开后再煮2分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'腰花','pic_012.jpg',20.6,'选用大型厂家冷鲜腰花，经过解冻、清洗、切片而成。锅开后涮30秒左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'猪脑花','pic_013.jpg',20.6,'选用大型厂家冷鲜猪脑经过清洗，过水、撕膜而成。肉质细腻，锅开后再煮8分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'午餐肉','pic_017.jpg',20.6,'锅开后再煮2分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'牛仔骨','pic_018.jpg',20.6,'牛仔骨又称牛小排，选自资质合格的厂家生产配送。锅开后再煮5分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'新西兰羊肉卷','pic_034.jpg',20.6,'选用新西兰羔羊肉的前胸和肩胛为原料，在国内经过分割、压制成型，肥瘦均匀。锅开后涮30秒左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'捞派黄喉','pic_075.jpg',20.6,'黄喉主要是猪和牛的大血管，以脆爽见长，是四川火锅中的经典菜式。捞派黄喉选用猪黄喉，相比牛黄喉，猪黄喉只有30cm可用，肉质比牛黄喉薄，口感更脆。 捞派黄喉，通过去筋膜、清水浸泡15小时以上，自然去除黄喉的血水和腥味。口感脆嫩弹牙，是川味火锅的经典菜式。',1);
INSERT INTO ctf_dish VALUES(null,'千层毛肚','pic_078.jpg',20.6,'选自牛的草肚，加入葱、姜、五香料一起煮熟后切片而成。五香味浓、耙软化渣。锅开后再煮3分钟左右即可食用。',1);
INSERT INTO ctf_dish VALUES(null,'捞派脆脆毛肚','pic_081.jpg',20.6,'选自牛的草肚，采用流水清洗、撕片等工艺，加入各种调味料腌制而成。口感脆嫩，锅开后再采用“七上八下”的方法涮15秒即可食用。',1);



#7.订单信息表 ctf_order
CREATE TABLE ctf_order(
    oid INT PRIMARY KEY  AUTO_INCREMENT, #
    startTime BIGINT, #开始时间
    endTime BIGINT, #结束时间
    customerCount INT, #用餐人数
    tableId INT, #桌台编号
    FOREIGN KEY(tableId) REFERENCES ctf_table(tid)
);

INSERT INTO ctf_order VALUES(null,1548406192843,1548432000000,4,1);

#8.订单详情表 ctf_order_detail
CREATE TABLE ctf_order_detail(
    did INT PRIMARY KEY  AUTO_INCREMENT, #订单编号
    dishId INT, #菜品编号
    FOREIGN KEY(dishId) REFERENCES ctf_dish(did),
    dishCount INT, #菜品数量
    customerName VARCHAR(64), #点餐用户的称呼
    orderId INT,#订单编号
    FOREIGN KEY(orderId) REFERENCES ctf_order(oid)
);

INSERT INTO ctf_order_detail VALUES(null,100001,1,'孙悟空',1);