//
//  main.swift
//  Protocols
//
//  Created by Denis Bystruev on 08/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

class Shoe: CustomStringConvertible {
    var description: String {
        return "Туфли, цвет: \(color), размер: \(size)"
    }
    
    let color: String
    let size: Int
    let hasLaces: Bool
    
    init(color: String, size: Int, hasLaces: Bool) {
        self.color = color
        self.size = size
        self.hasLaces = hasLaces
    }
}

let shoe = Shoe(color: "Красный", size: 44, hasLaces: true)

print(shoe)

struct Employee {
    let firstName: String
    let lastName: String
    let jobTitle: String
    let phoneNumber: String
}

extension Employee: Equatable {
    static func == (left: Employee, right: Employee) -> Bool {
        return left.firstName == right.firstName && left.lastName == right.lastName
    }
}

extension Employee: Comparable {
    static func < (left: Employee, right: Employee) -> Bool {
        if left.lastName == right.lastName {
            return left.firstName < right.firstName
        } else {
            return left.lastName < right.lastName
        }
    }
}

extension Employee: Codable { }

struct Company {
    let name: String
    let employees: [Employee]
}

extension Company: Codable { }

let director = Employee(firstName: "Вася", lastName: "Пупкин", jobTitle: "Директор", phoneNumber: "222-22-22")
let designer = Employee(firstName: "Вася", lastName: "Пупкин", jobTitle: "Дизайнер", phoneNumber: "333-33-33")
let secretary = Employee(firstName: "Василиса", lastName: "Тараканова", jobTitle: "Секретарь", phoneNumber: "444-44-44")

let company = Company(name: "Рога и копыта", employees: [director, designer, secretary])

print(company.employees)
print(company.employees.sorted(by: >))

let encoder = JSONEncoder()

do {
    let data = try encoder.encode(company)
    
    print(String(data: data, encoding: .utf8) ?? "nil")
} catch {
    print(error)
}

protocol FullyNamed {
    var fullName: String { get }
    
    func sayFullName()
}

extension FullyNamed {
    func sayFullName() {
        print(fullName)
    }
}

struct Person: FullyNamed {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    var firstName: String
    var lastName: String
}

let person = Person(firstName: "Коля", lastName: "Герасимов")
person.sayFullName()

protocol ButtonDelegate {
    func userTappedButton(_ button: Button)
}

class GameController: ButtonDelegate {
    func userTappedButton(_ button: Button) {
        print("Пользователь нажал кнопку \(button.title)")
    }
    
    
}

class Button {
    let title: String
    var delegate: ButtonDelegate?
    
    init(title: String) {
        self.title = title
    }
    
    func tapped() {
        delegate?.userTappedButton(self)
    }
}

let startButton = Button(title: "Начать игру")
let gameController = GameController()
startButton.delegate = gameController

startButton.tapped()
