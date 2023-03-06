module.exports = cds.service.impl(async function(){
 
    const{
        Employeeset,POs
    } =this.entities;

    this.before('UPDATE',Employeeset, (req,res) => {
        console.log("Did it came",req.data.salaryAmount);
        if (parseFloat(req.data.salaryAmount) >= 1000000) {
            req.error(500,'Salary must be below 1million');            
        }
    });

    this.on('boost',async req => {
      try {
        const ID = req.params[0];
        console.log("Your Purchase Order with id---->" +ID+ "will be boosted");
        console.log (ID);
    //     const tx = cds.transaction(req);  
    //     await tx.update(POs).with({
    //         // GROSS_AMOUNT: { '+=' : 20000 },
    //          NOTE: "Boosted..!!"                        
    //    }).where(ID); 
      
       await cds.transaction(req).run([
        UPDATE(POs).set({
            GROSS_AMOUNT: { '+=' : 200 },
            NOTE: "Boosted..!!"  
        }).where({ID: ID})
       ])
       return {};


    // return tx.run([ 
    //    UPDATE(POs).set ({GROSS_AMOUNT: { '+=': 20000}}, {Note: "Boosted..!!"}).where(ID)
    // ])
        
      } catch (error) {
        return "Error" + error.toString();
      }

    });

    this.on('largestOrder',async req => {
        try {
            const ID = req.params[0];
            console.log(`Your Purchase Order with id---->${ID}will be boosted`);
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);

            return reply;

        } catch (error) {
            return "Error" + error.toString();
        }
    });
})