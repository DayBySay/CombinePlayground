//: [Previous](@previous)

import Combine

let subject1 = PassthroughSubject<Int, Error>()
let subject2 = PassthroughSubject<String, Error>()
var cancellables = [AnyCancellable]()

subject1.eraseToAnyPublisher()
    .combineLatest(subject2)
    .sink { (error) in
        print(error)
    } receiveValue: { (int, string) in
        print("\(int) \(string)")
    }
    .store(in: &cancellables)

subject1.send(1)
subject1.send(2)
subject2.send("hoge")
subject1.send(3)
subject2.send("fuga")
subject1.send(completion: .finished)
subject1.send(4)
subject2.send("nyassu")
subject2.send(completion: .finished)

//: [Next](@next)
