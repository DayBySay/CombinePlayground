import Combine

let subject = PassthroughSubject<Int, Error>()
let publisher = subject.eraseToAnyPublisher()
var cancellables = [AnyCancellable]()

publisher
    .prefix(1)
    .sink { (error) in
    print(error)
    } receiveValue: { (int) in
        print(int)
    }.store(in: &cancellables)

publisher
    .prefix(2)
    .sink { (error) in
    print(error)
    } receiveValue: { (int) in
        print(int)
    }.store(in: &cancellables)

subject.send(1)
subject.send(2)
subject.send(3)
