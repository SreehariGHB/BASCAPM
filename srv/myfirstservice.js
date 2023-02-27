// const mySrv = function(srv){
//     srv.on('hello',(req,res) => {
//         return "Hello  " + req.data.msg;
//     })
// };

// module.exports = mySrv;

module.exports = (say)=>{
    say.on('hello', (req,res) => "Hello " + req.data.msg);
}