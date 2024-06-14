// Import necessary constructs from the samsara library
const {
    Proc,
    arr,
    first,
    second,
    split,
    fanout,
    fanin,
    Right,
    Left,
    Tuple,
    Thunk,
    Cont,
    runProc
} = require("./src/samsara");

// Define simple functions
const foo = x => x + 1;
const bar = x => x * 3;

// Run and log various processes
console.log(runProc(Proc(foo).then(bar), 3)); // Output: 12

console.log(runProc(first(bar), 1, 2)); // Output: [3, 2]
console.log(runProc(second(bar), 1, 2)); // Output: [1, 6]
console.log(runProc(split(foo, bar), 1, 2)); // Output: [2, 6]
console.log(runProc(fanout(foo, bar), 1)); // Output: [2, 3]

// Constant function
const constA = x => _ => x;

// List operations
const cons = (x, y) => [x].concat(y);
const listcase = x => x.length === 0 ? Left() : Right(Tuple([x[0], x.slice(1)]));

// Asynchronous map function
const mapA = f => {
    const arrF = arr(f);
    return Proc(arrF(listcase))
        .then(fanin(constA([]), Proc(split(f, Thunk(mapA, [f])).then(arrF(cons)))));
};

console.log(runProc(mapA(bar), [1, 2, 3])); // Output: [3, 6, 9]

// Continuations
const defer = [];
const later = callback => defer.push(callback);

const coo = Cont((x, r) => later(() => r([x * 5])));
const qoo = Cont((x, r) => r([x, x]));

const zoo = Proc(bar).then(coo).then(x => x[0]).then(qoo);
runProc(zoo, 4, (...args) => console.log("results:", args)); // Output after 500ms: [60, 60]

const joo = Proc(constA(Left(5))).then(fanin(coo, qoo));
runProc(joo, null, (...args) => console.log("joo:", args)); // Output: joo: [Left 5, Left 5]

// Execute deferred functions after 500ms
setTimeout(() => defer.forEach(x => x()), 500);