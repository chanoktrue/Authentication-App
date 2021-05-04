
// www.glitch.com
// url = https://keen-whimsical-chef.glitch.me/

const express = require("express");
const app = express();
const jwt = require("jsonwebtoken");

// body parser to parse JSON
app.use(express.json());

const users = [{ username: "roj", password: "123456" }];
const accounts = [
  { name: "Roj", balance: 5000 },
  { name: "Roj", balance: 2500 }
];

function authenticate(req, res, next) {
  const headers = req.headers["authorization"];
  if (headers) {
    //Bearer xxxxxx
    const token = headers.split(" ")[1];
    const decoded = jwt.verify(token, "SECRET");

    if (decoded) {
      const username = decoded.username;
      // console.log(username)
      const persistedUser = users.find(
        user => user.username == username.toLowerCase()
      );
      if (persistedUser) {
        next();
      } else {
        res.json({ message: "Unauthorized access" });
      }
    } else {
      res.json({ message: "Unauthorized access" });
    }
  }
}

app.get("/accounts", authenticate, (req, res) => {
  res.json(accounts);
});

app.post("/login", (req, res) => {
  const username = req.body.username;
  const password = req.body.password;

  const authUser = users.find(
    user =>
      user.username == username.toLowerCase() &&
      user.password == password.toLowerCase()
  );

  if (authUser) {
    // generate a token
    const token = jwt.sign({ username: username }, "SECRET");
    if (token) {
      res.json({ token: token });
    } else {
      res.json({ message: "Authentication Failed", success: false });
    }
  } else {
    res.json({ message: "Authentication Failed", success: false });
  }
});

// liten for requests:)
const listener = app.listen(process.env.PORT, () => {
  console.log("Your app is listening on port " + listener.address().port);
});

