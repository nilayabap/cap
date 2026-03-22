const cds = require('@sap/cds');
const req = require('express/lib/request');
//const { stringify } = require('querystring');

module.exports = cds.service.impl(async function(srv) {
    srv.on('printhello', req => {
        console.log(req.data.input) //print the request coming from server
        //return req.data.input
    return `Hello ${req.data.input}`
    })

    srv.on('addition', req =>{
        console.log(req.data)
        let result = req.data.num1 + req.data.num2;

        return result
    })

    
    srv.on('MyFunction', req =>{
        //console.log(req.data)
        let result = {}

        if (req.data.Category == 1) {
            result.product = 'BMW',
            result.price   = '1200',
            result.location = 'New Delhi'
        }

        else {
            result.product = 'Audi',
            result.price   = '1800',
            result.location = 'Kolkata',
            result.price    = [
                {
                    "Chesis" : "LTP231456789",
                    "Engine" : "ENG123456789"

                }

            ]

        }
        console.log(result)
        return result;
    })
 

})