/**
 * 川天府扫码点餐项目API子系统
 */
const PORT =8090;
const express=require('express');
const categoryRouter=require('./routes/admin/category');
const adminRouter=require('./routes/admin/admin');
const cors=require('cors');
const bodyParser=require('body-parser')

var app=express();
app.listen(PORT,()=>{
    console.log("服务器已监听"+PORT+"端口...")
});
//使用中间件
app.use(cors({origin:'*'}));
app.use(bodyParser.json());//把JSON格式的请求主体数据解析出来放入req.body属性

//挂载路由器
app.use('/admin/category',categoryRouter);
app.use('/admin',adminRouter);
