const mongoose = require("mongoose");

const favouriteSchema = mongoose.Schema({
    uid:{type:String},
    title:{type:String},
    description:{type:String},
    author:{type:String},
    urlToImage:{type:String},
    publishedAt:{type:String},
    content:{type:String},

})

const favouriteModel = mongoose.model("favouriteSchema",favouriteSchema)

module.exports = favouriteModel