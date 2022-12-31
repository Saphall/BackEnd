// ==== Print helloworld
console.log('Hello World!')

// ==== General code syntax
const user = 'Saphall'
let age = 23
const isGood = true

// ==== Function
function summary1(user, age, isGood) {
  return (
    'Your name is : ' +
    user +
    ', age is : ' +
    age +
    ' and you are Good? : ' +
    isGood
  )
}

// function type-2 (arrow funciton)
// (a+b)
const summary2 = (a, b) => a + b
// (a)
const sumOne = a => a + 1
// ()
const summary3 = () => 'No argument function!'

// ==== Object
const obj = {
  name: 'Saphall',
  age: 23,
  summary04: function () {
    console.log('Key function from ' + this.name)
  },
  summary4() {
    console.log(this.name, this.age)
  },
}

// Print Statements
console.log(summary1(user, age, isGood))

console.log(summary2(3, 4))
console.log(sumOne(9))
console.log(summary3())

console.log(obj.name)
obj.summary04()
obj.summary4()
