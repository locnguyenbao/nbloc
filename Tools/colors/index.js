const colors = require('colors');
function colors() {
  console.log(colors.say({ text: "hello world", f: "colors" }));
}
module.exports = colors;