/**
 * mysql数据库连接池
 */
const mysql=require('mysql');
var pool=mysql.createPool({
    host:'127.0.0.1', //数据库地址
    port:3306, //数据库端口号
    user:'root', //数据库管理员
    password:'', //数据库管理员密码
    database:'chuantianfu', //数据库名
    connectionLimit:10 //连接数量
});
module.exports=pool;