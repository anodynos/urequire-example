({ urequire: { rootExports: ['urequireExample'], noConflict: true }}); // uRequire Module Configuration

define(['models/Person'], function (Person) {
    var add = require('calc/add');  // bundleRelative works fine

    var person = new Person('John', 'Doe');
    person.age = 18;
    person.age = add(person.age, 2);

    var calc = require('./calc'); // loads 'calc/index.js'

    person.age = calc.multiply(person.age, 2);

    if (__isNode) {
        var nodeOnlyVar = require('nodeOnly/runsOnlyOnNode');
        console.log("Runs only on node:", require('util').inspect(nodeOnlyVar));
    }

    return _.clone({      // `_` is injected by `dependencies: imports`
        person: person,
        add: add,
        calc: calc,
        VERSION: VERSION  // `var VERSION = 'xx';` injected by `urequire-rc-inject-version`
    });
});
