/**
 * 管理员相关路由
 */
const express=require('express');
const pool = require('../../pool');
var router = express.Router();
module.exports=router;

/*GET请求可以有主体吗:没有，所以不可以用req.body
 * API:GET/admin/login
 * 请求数据：{aname:'xxx',apwd:'xxx'}
 * 完成用户登录验证(提示:有的项目中此处选择POST请求)
 * {code:200,msg:'login succ'}
 * {code:400,msg:'aname or apwd err'}
 */
router.get('/login/:aname/:apwd',(req,res)=>{
    var aname=req.params.aname;
    var apwd=req.params.apwd;
    //需要对用户的密码执行加密函数
    pool.query('SELECT aid FROM ctf_admin WHERE aname=? AND apwd=PASSWORD(?)',[aname,apwd],(err,result)=>{
        if(err)throw err;
        if(result.length>0){  //查询到一行数据
            res.send({code:200,msg:'login succ'})
        }else{
            res.send({code:400,msg:'aname or apwd err'})
        }
    })
})

/**PATCH请求可以有主体码
 * API:PATCH/admin
 * 请求数据：{aname:'xxx',oldPwd:'xxx',newPwd:'xxx'}
 * 根据管理员名和密码修改管理员密码
 * 请求数据：{aname:'xxx',apwd:'xxx'}
 * {code:200,msg:'modified succ'}
 * {code:400,msg:'aname or apwd err'}
 * {code:401,msg:'apwd not modified'}
 */
router.patch('/',(req,res)=>{
    var data=req.body;
    var aname=req.body.aname;
    var oldPwd=req.body.oldPwd;
    var newPwd=req.body.newPwd;
    //首先根据aname/oldPwd查询该用户是否存在
    pool.query('SELECT aid FROM ctf_admin WHERE aname=? AND apwd=PASSWORD(?)',[aname,oldPwd],(err,result)=>{
        if(err)throw err;
        if(result.length>0){  //查询到一行数据
            //如果查询到了用户，再修改其密码
            pool.query('UPDATE ctf_admin SET apwd=PASSWORD(?) WHERE aname=?',[newPwd,aname],(err,result)=>{
                if(err)throw err;
                if(result.changedRows>0){
                    res.send({code:200,msg:'modified succ'})
                }else if(result.changedRows==0 && result.affectedRows==1){
                    res.send({code:401,msg:'apwd not modified'})
                }
            })
        }else{
                res.send({code:400,msg:'aname or apwd err'})
        }
    
    })
})
