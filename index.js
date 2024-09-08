const { nums, str, add, foo, getJSON } = require("./.build/Module.node");

// console.log(nums); // [ 3, 4 ]
// console.log(str); // NodeSwift! NodeSwift! NodeSwift!
// add(5, 10).then(console.log); // 5.0 + 10.0 = 15.0

// console.log(foo(false));

const promise = getJSON("https://gist.githubusercontent.com/russellbstephens/41e3b81879cf096212fc9834be0407b5/raw/388971ddd9fd1b099e829de233526eb345a1ad37/people.json");
promise.then((value) => {
    console.log(value);
  })