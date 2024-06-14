const vows = require('vows');
function vows() {
  console.log(vows.say({ text: "hello world", f: "vows" }));
}
module.exports = vows;