define ['./Animal'], (Animal)->

  class Person extends Animal

    (@name, @surname)->

    fullName: -> @name + ' ' + @surname