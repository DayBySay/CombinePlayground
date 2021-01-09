//: [Previous](@previous)

import Combine

let subject = PassthroughSubject<Int, Never>()
let publisher = subject.eraseToAnyPublisher()
    .makeConnectable()
var cancellables = [AnyCancellable]()

publisher
    .sink { (val) in
        print(val)
    }
    .store(in: &cancellables)

subject.send(1)
subject.send(2)
subject.send(3)

publisher
    .sink { (val) in
        print(val)
    }
    .store(in: &cancellables)

let cancellable = publisher.connect()

subject.send(4)
subject.send(5)
subject.send(6)

cancellable.cancel()

subject.send(7)
subject.send(8)
subject.send(9)

/*
 outputs
 4
 4
 5
 5
 6
 6
 */

//: [Next](@next)
    
