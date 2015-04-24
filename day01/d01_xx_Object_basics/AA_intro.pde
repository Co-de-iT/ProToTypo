// ________________________________________

// this is a single line comment

/* < begin multi-line comment

multi-line comment

 end of multi-line comment > */
 
 // ________________________________________

/*

Processing itself is an object, therefore it has its own fields and methods,
to which we usually refer as "global variables" and "functions"

Right now as you are reading, you are inside an object, the Processing object,
which is defined in Java (the general programming language Processing uses).

Objects and Classes

Imagine you just bought a LEGO car construction kit, one that you picked among many
LEGO cars in the color and properties you like. It is comprised of the pieces
you need (which have certain shapes, colors, etc), the instructions on how to build one 
and once it is built, it can move, steer, maybe has lights, etc.

A Class can be seen as the blueprint of all possible LEGO cars such as the one
you picked. The one you picked is an Object or an instantiation of that class.

The pieces you need to build it and their properties are the FIELDS
The instructions on how to build it is the CONSTRUCTOR
Moving, steering, flashing lights are all METHODS or BEHAVIORS

FIELDS are properties, such as chassis color, number of wheels, height, length, etc.
------ and are usually described as nouns

BEHAVIORS are actions, and are usually described as verbs
---------

Context

A couple of curly brackets {} defines a context. What is it? Imagine it as 
The Green Mile: "What happens in the mile stays in the mile", so whatever you
define in a context exist only there and cannot exist outside. You can, however,
bring in a context anything you want from the outside.
You can put a context within a context (also called "nesting") and do it multiple
times.
Imagine that this interface is inside a couple of curly brackets: this is also 
known as the general context. Anything you define here is also available in any
sub-context.

Like this:

Processing (the general context)
{ // < you don't see this, it's just to give you the idea
|
|  // first sub-context
|  {
|  |
|  |  // second sub-context
|  |  {
|  |  |  
|  |  |  {
|  |  |    .... well, you get the idea, don't you?
|  |  |   }
|  |  |
|  |  }
|  |  
|  }
|
|
} // < you don't see this either, it's the Processing window!


*/
