module.exports = cds.service.impl(async function(){
 
    const{
        Employeeset
    } =this.entities;

    this.before('UPDATE',Employeeset, (req,res) => {
        console.log("Did it came",req.data.salaryAmount);
        if (parseFloat(req.data.salaryAmount) >= 1000000) {
            req.error(500,'Salary must be below 1million');            
        }
    });
})