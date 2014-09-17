({ urequire: {  // uRequire Module Configuration
     rootExports: ['urequireExample', 'uEx'],
     noConflict: true
}})

define(['./models/person'], function (person) {

    var add = require('calc/add');
    person.age = add(person.age, 2);

    var calc = require('calc'); // loads 'calc/index.js'
    person.age = calc.multiply(person.age, 2);

    return {
        person: _.clone(person), // _ is injected by uRequire in the whole bundle
        add: add,
        VERSION: VERSION         // `var VERSION = 'xx';` injected by urequire
    }
});
