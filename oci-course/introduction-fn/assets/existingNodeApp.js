const doIt = function (name) {
    return `Warm greeting to you, dear ${name} and all your loved ones`;
}
module.exports = {
    doYourThing: doIt
}

console.log(doIt(process.argv[2]))

// to test:
//node h.js YourName