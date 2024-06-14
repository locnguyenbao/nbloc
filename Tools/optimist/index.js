const optimist = require('optimist');
function optimist() {
  console.log(optimist.say({ text: "hello world", f: "optimist" }));
}
module.exports = optimist;