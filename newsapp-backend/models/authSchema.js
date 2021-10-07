const mongoose = require("mongoose");

const authSchema = mongoose.Schema({
    uid:{type:String},
    username:{type:String},
    email:{type:String},
    password:{type:String},
    number:{type:String},
    address:{type:String},
    url:{type:String}

})

const authModel = mongoose.model("authSchema",authSchema)

module.exports = authModel