const cds = require('@sap/cds');
const { message } = require('@sap/cds/lib/log/cds-error');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl(async function (srv) {

    const {Product} = srv.entities;
    let originalstock;
    let ID;
   
    srv.on('MyFunction', async(req) =>{
        let result = `Super cool ${ req.data.name}`
        return result

    });

        srv.on('MyAction', async(req) =>{
        let result = `Super cool ${ req.data.name}`
        return result

    });

//*************************************************************************
//********************** Order Product logic Begin ************************
//*************************************************************************
//*---------- IF the Stock is >5000 then that product stock can not be ordered again
    srv.before('orderProduct', async(req) =>{
//*------Check what is coming in the console from application
        console.log(req.data);    // This will return the data from orderProduct user input
        console.log(req.params);  // This will return the primary key 

//*-------Select the data 
//        const result = SELECT `stock` .from (Product).where({ID:req.params[0]}); Does not return value of select
//*----await is important---This returns the stock from existing DB
//      const result = await SELECT `stock` .from(Product).where({ ID:req.params[0].ID });

// Approach 2 for select query
        ID = req.params[0].ID;

        const result = await SELECT.from(Product)
        .columns('stock')
        .where({ ID });
        
        originalstock = result[0].stock;

//*------Output Result
        console.log( "Original Stock", originalstock );

//*----Validation
        if (originalstock > 5000 ) {
            return req.error({
                code : '400',
                message : 'Stock should not be more than 5000'
            })
        };

    });

srv.on('orderProduct', async(req) =>{
    let updatedstock = req.data.stock + originalstock;
    console.log( "Updated Stock :", updatedstock );

    const result = await UPDATE(Product)
                        .with({ stock:updatedstock })
                        .where({ ID:ID });

    console.log( "Updated Result :", result );

    return req.notify( `Order Placed Successfully. Updated Stock: ${updatedstock}` )

})

//*************************************************************************
//********************** Order Product logic End ************************
//*************************************************************************


})