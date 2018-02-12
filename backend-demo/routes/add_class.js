var express = require('express');
var router = express.Router();


router.get('/', function(req, res) {
    console.log("print");

    var name = req.param("name");

    console.log("john");



    var collection = req.db.get("class");


    collection.insert({name: name}, function (err, docs) {
       
    });

});

module.exports = router;
