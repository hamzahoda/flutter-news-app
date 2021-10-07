const express = require("express");
const bd = require("body-parser");
const cors = require("cors");
const mongoose = require("mongoose");
let authModel = require("./models/authSchema");
const bcrypt = require("bcryptjs");
let favouriteModel = require("./models/favouriteSchema")

const app = express();
const port = 5000;

app.use(cors());
app.use(
  bd.urlencoded({
    extended: false,
  })
);

app.use(bd.json());

mongoose.connect(
  "mongodb+srv://hamza:helloworld@cluster0.rik5g.mongodb.net/myFirstDatabase?retryWrites=true&w=majority",
  {
    // useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
  }
);

mongoose.connection.on("connected", () => {
  console.log("Database connected");
});
mongoose.connection.on("error", () => {
  console.log("Database connection error");
});

app.get("/", (req, res) => {
  res.send("working root route");
  console.log("Response working");
});

app.post("/signup", async (req, res) => {
  var checkUser = await authModel.findOne({ email: req.body.email });
  if (checkUser) {
    res
      .status(200)
      .send({ result: checkUser, message: "Email already registered" });
  } else {
    // res.send({ message: "Yes you can sign up" });
    var hashPass = await bcrypt.hash(req.body.password, 12);

    let userCreate = new authModel({
      uid:req.body.uid,
      username:req.body.username,
      email: req.body.email,
      password: hashPass,
      number:req.body.number,
      address:req.body.address,
      url:req.body.url
    });

    userCreate
      .save()
      .then((response) => {
        // console.log("Response",response)
        res.status(200).send({
          result: response,
          message: "User Created successfully",
        });
      })
      .catch((error) => {
        res.status(400).send({
          result: error.message,
          message: "User not Created successfully",
        });
        console.log("error", error);
      });
  }

  console.log(req.body);
  // res.send("Signup successfull ")
});


app.post("/singleuserdata", async (req, res) => {
  var finduser = await authModel.findOne({ uid: req.body.uid });
  if (finduser) {
    res
      .status(200)
      .send({ result: finduser, message: "User exist" });
  } else {
    
        res.status(200).send({
          result: response,
          message: "User Does not Exist",
      })
      .catch((error) => {
        res.status(400).send({
          result: error.message,
          message: "Something went wrong",
        });
        console.log("error", error);
      });
  }

  console.log(req.body);
  // res.send("Signup successfull ")
});



app.post("/updateuser", async (req, res) => {
  var finduser = await authModel.findOneAndReplace({ uid: req.body.uid },{
    uid:req.body.uid,
    username:req.body.username,
    email:req.body.email,
    password:req.body.password,
    number:req.body.number,
    address:req.body.address,
    url:req.body.url
  });
  if (finduser) {
    res
      .status(200)
      .send({ result: finduser, message: "User Updated" ,success:"1"});
  } else {
    
        res.status(200).send({
          result: response,
          message: "User Does not Exist",
      })
      .catch((error) => {
        res.status(400).send({
          result: error.message,
          message: "Something went wrong",
        });
        console.log("error", error);
      });
  }

  console.log(req.body);
  // res.send("Signup successfull ")
});



// app.post("/signin", async (req, res) => {
//   var checkUser = await authModel.findOne({ email: req.body.email });
//   if (checkUser) {
//     var checkPass = await bcrypt.compare(req.body.password, checkUser.password);

//     if (checkPass) {
//       res.status(200).send("Login Successfull");
//     } else {
//       res.status(403).send("Invalid Username or password");
//     }
//   } else {
//     res.status(200).send({ message: "No User is Registered with this Email" });
//   }
// });



app.post("/setfavourite", async (req, res) => {
  var checkFavourite = await favouriteModel.findOne({ title: req.body.title });
  if (checkFavourite) {
    res
      .status(200)
      .send({ result: checkFavourite, message: "Already added to favourite",success:"0" });
  } else {
    // res.send({ message: "Yes you can sign up" });

    let favouriteCreate = new favouriteModel({
      uid:req.body.uid,
      title:req.body.title,
      description:req.body.description,
      author:req.body.author,
      urlToImage:req.body.urlToImage,
      publishedAt:req.body.publishedAt,
      content:req.body.content,
    });

    favouriteCreate
      .save()
      .then((response) => {
        // console.log("Response",response)
        res.status(200).send({
          result: response,
          message: "Added to favourites successfully",
          success:"1"
        });
      })
      .catch((error) => {
        res.status(400).send({
          result: error.message,
          message: "Not added to favourite successfully",
          success:"2"
        });
        console.log("error", error);
      });
  }

  console.log(req.body);
  // res.send("Signup successfull ")
});




app.post("/getfavourite", async (req, res) => {
  var result = await favouriteModel.find({uid:req.body.uid});
  res
    .status(200)
    .send({ data: result, message: "All data fetch successfully" });
});




// app.post("/checkfavourite", async (req, res) => {
//   var checkFavourite = await favouriteModel.findOne({ title: req.body.title });
//   if (checkFavourite) {
//     res
//       .status(200)
//       .send({ result: checkFavourite, message: "Already added to favourite" });
//   } else {
//     res
//     .status(200)
//     .send({ message: "Not added to favourite" });
//   }
// });






app.listen(port, () => {
  console.log("Server running at port 5000:");
});
