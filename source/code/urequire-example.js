({ urequire: {  // uRequire Module Configuration
     rootExports: ['urequireExample', 'uEx'],
     noConflict: true
}});


define(['./models/Person'], function (Person) {
    var add = require('calc/add');

    var person = new Person('John', 'Doe');
    person.age = 18;
    person.age = add(person.age, 2);

    var calc = require('calc'); // loads 'calc/index.js'
    person.age = calc.multiply(person.age, 2);

    return _.clone({ // _ is injected by uRequire in the whole bundle
        person: person,
        add: add,
        calc: calc,
        VERSION: VERSION         // `var VERSION = 'xx';` injected by urequire
    });
});