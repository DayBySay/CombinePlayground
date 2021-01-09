//: [Previous](@previous)

import Foundation
import Combine

let timer = Timer.publish(every: 1, on: .main, in: .default)
let publisher = timer
//    .autoconnect() // 大体のケースでは connect() をコールするよりは autoconnect() を使ったほうが楽そう
    .eraseToAnyPublisher()
var cancellables = [AnyCancellable]()

publisher
    .sink { (completion) in
        print(completion)
    } receiveValue: { (date) in
        print(date)
    }
    .store(in: &cancellables)

let cancellable = timer.connect()

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
    cancellable.cancel()
    _ = timer.connect() // cancellでリソースが開放されているのでこのコードは意味がない
}

/*
 2021-01-09 06:01:51 +0000
 2021-01-09 06:01:52 +0000
 2021-01-09 06:01:53 +0000
 **/

//: [Next](@next)
