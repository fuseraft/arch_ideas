# Ruby-GoF-Patterns

GoF patterns + other patterns in Ruby.

Design patterns provide a way to design more modular, flexible, and maintainable software. They help to organize code in a way that makes it easier to understand, modify, and extend. They also promote code reuse and reduce the likelihood of introducing bugs or errors into the codebase.

These patterns are typically categorized into three main categories based on their purpose and the problem they solve: **Creational**, **Structural**, and **Behavioral**.

#### Creational Design Patterns:

Creational design patterns are a group of design patterns that focus on object creation mechanisms, trying to create objects in a manner suitable to the situation. This group of patterns provide object creation mechanisms that increase flexibility and reuse of existing code. They provide ways to create objects while hiding the creation logic, rather than instantiating objects directly using the `new` keyword.

**Abstract Factory**
> Provides an interface for creating families of related objects without specifying their concrete classes. The Abstract Factory pattern is useful when a system needs to be able to create different families of objects based on different configurations or requirements.

**Builder**
> Provides a way to create complex objects step by step, allowing the builder to control the order and process of construction. The Builder pattern is useful when creating complex objects with many parts or when the construction process needs to be flexible or extensible.

**Factory Method**
> Provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created. The Factory Method pattern is useful when a system needs to be able to create different types of objects without changing the code that uses them.

**Prototype**
> Provides a way to create new objects by cloning existing ones, allowing the new object to start with the same state as the original. The Prototype pattern is useful when creating new objects is expensive or complex, and when there are only a few variations in the objects being created.

**Singleton**
> Ensures that a class can only have one instance, and provides a way to access that instance globally. The Singleton pattern is useful when a system needs to ensure that only one instance of a class exists, such as when managing a shared resource or controlling access to a critical section of code.

#### Structural Design Patterns:

Structural design patterns are a group of design patterns that focus on object composition, providing ways to manage object relationships to form larger, more complex structures. They deal with the composition of classes and objects to form larger structures, and aim to make those structures more flexible and efficient.

**Adapter**
> Allows two incompatible interfaces to work together by wrapping an existing object with a new interface. The Adapter pattern is useful when a system needs to be able to use existing objects that do not have the required interface, or when a system needs to be able to work with multiple types of objects that have different interfaces.

**Bridge**
> Separates the abstraction of an object from its implementation, allowing them to vary independently. The Bridge pattern is useful when a system needs to be able to work with different types of objects that have different implementations, or when a system needs to be able to switch between different implementations of an object without changing the code that uses it.

**Composite**
> Allows a group of objects to be treated as a single object, using a tree-like structure to organize the objects. The Composite pattern is useful when a system needs to be able to work with objects that may be made up of other objects, without having to treat each object separately.

**Decorator**
> Allows behavior to be added to an object dynamically, without affecting the behavior of other objects of the same class. The Decorator pattern is useful when a system needs to be able to add or modify the behavior of an object at runtime, without changing the code that uses the object.

**Facade**
> Provides a simple interface to a complex system, hiding the complexity of the system behind a single interface. The Facade pattern is useful when a system needs to be able to interact with a complex system in a simple way, or when a system needs to be able to hide the details of a complex system from other parts of the system.

**Flyweight**
> Allows a large number of objects to be created and managed efficiently by sharing common data between them. The Flyweight pattern is useful when a system needs to be able to create a large number of objects that are similar, but that differ in only a few ways.

**Proxy**
> Provides a surrogate or placeholder for another object, allowing control over access to the original object. The Proxy pattern is useful when a system needs to be able to control access to an object, or when a system needs to be able to perform additional tasks before or after accessing an object.

#### Behavioral Design Patterns:

Behavioral design patterns are a group of design patterns that focus on communication between objects and the delegation of responsibilities among objects. These patterns provide solutions to problems that arise in the interactions between objects and aim to make those interactions more efficient and effective.

**Chain of Responsibility**
> Allows a chain of objects to handle a request, with each object in the chain having the opportunity to handle the request or pass it on to the next object in the chain. The Chain of Responsibility pattern is useful when a system needs to be able to handle requests in a flexible way, with the ability to add or remove objects from the chain at runtime.

**Command**
> Encapsulates a request as an object, allowing it to be treated as a first-class object in the system. The Command pattern is useful when a system needs to be able to support undo and redo operations, or when a system needs to be able to execute requests at different times or in different contexts.

**Interpreter**
> Used to define a language or grammar and provide a way to interpret and execute expressions written in that language. Interpreters are often used in compilers, query languages, and other applications that need to process complex expressions.

**Iterator**
> Provides a way to access the elements of a collection in a sequential manner, without exposing the underlying structure of the collection. The Iterator pattern is useful when a system needs to be able to work with collections of objects in a flexible way, without having to know the details of how the collection is implemented.

**Mediator**
> Defines an object that controls the interactions between a set of objects, allowing them to communicate in a controlled and decoupled manner. The Mediator pattern is useful when a system needs to be able to handle complex interactions between objects, without having to have direct knowledge of the details of each object.

**Memento**
> Allows an object to capture its internal state, and to restore that state later. The Memento pattern is useful when a system needs to be able to undo or redo operations, or when a system needs to be able to restore an object to a previous state.

**Observer**
> Defines a one-to-many relationship between objects, where a change to one object results in a notification being sent to all the other objects that are observing it. The Observer pattern is useful when a system needs to be able to notify a group of objects about changes to an object, without having to tightly couple the objects together.

**State**
> Allows an object to change its behavior based on changes to its internal state, without changing its class. The State pattern is useful when a system needs to be able to change the behavior of an object at runtime, based on changes to its internal state.

**Strategy**
> Allows an object to encapsulate a particular behavior, allowing it to be swapped out at runtime with a different behavior. The Strategy pattern is useful when a system needs to be able to change the behavior of an object at runtime, without changing the code that uses the object.

**Template Method**
> Defines the skeleton of an algorithm in a base class, with specific steps of the algorithm being deferred to subclasses. The Template Method pattern is useful when a system needs to be able to define a generic algorithm that can be customized by subclasses, without having to rewrite the entire algorithm each time.

**Visitor**
> Allows new operations to be added to an object structure without changing the classes of the objects in the structure. The Visitor pattern is useful when a system needs to be able to perform operations on a group of objects that have different classes, without having to modify the classes of the objects themselves.

#### Other Patterns:

The "Other Patterns" category includes specialized patterns that solve specific problems or address specific needs. They can be valuable tools for improving the design and functionality of software systems.

**Double Dispatch**
> Extends the Visitor pattern by taking into account the type of both the visitor and the visited object during method dispatch.

**Event Sourcing**
> Used to capture all changes to an application's state as a series of events that can be used to reconstruct the state at any point in time. Event sourcing is often used in complex systems where audit trails and rollback capabilities are important.

**Fluent Interface**
> Used to create an object-oriented interface that is easy to read and write, and that can be chained together to form complex expressions. This is typically done by returning the object itself from each method call, allowing subsequent method calls to be chained together in a readable way.

**Lazy Initialization**
> Used to defer the creation of an object until it is needed, in order to improve performance and reduce memory usage. This is typically done by creating a proxy object that only instantiates the actual object when it is accessed.

**Pipes and Filters**
> Used to process a stream of data by passing it through a series of independent filters that each perform a specific operation. Each filter takes input data, performs a transformation, and passes the output to the next filter in the pipeline.
