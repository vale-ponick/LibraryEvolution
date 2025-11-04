//
//  libraryWithArchitecture.swift
//  LibraryEvolution
//
//  Created by Валерия Пономарева on 01.11.2025.
//

import Foundation

enum BookCategory: String, CaseIterable {
    case fantasy = "Fantasy"
    case history = "History"
    case novel = "Novel"
    case horror = "Horror"
    case biography = "Biography"
    case scienceFiction = "ScienceFiction"
}

class Book {
    let title: String
    let author: String
    let id: UUID
    let category: BookCategory
    var isAvailable: Bool
    
    init(title: String, author: String, id: UUID = UUID(), category: BookCategory, isAvailable: Bool = true) {
        self.title = title
        self.author = author
        self.id = id
        self.category = category
        self.isAvailable = isAvailable
    }
    
    func markAsBorrowed() {
        isAvailable = false
    }
    
    func markAsReturned() {
        isAvailable = true
    }
}
class Reader {
    let name: String
    let id: UUID
    var borrowedBooks: [UUID] // взятые книги
    var readingHistory: [UUID]
    var age: Int
    
    init(name: String, age: Int) { // 1️⃣ упрощенный init() для НОВЫХ читателей
        self.name = name
        self.age = age
        self.id = UUID() // генерируем НОВЫЙ id
        self.borrowedBooks = [] // пустой массив для НОВЫХ книг
        self.readingHistory = [] // пустая история
    }
    
    init(name: String, id: UUID, borrowedBooks: [UUID], readingHistory: [UUID], age: Int) { // 2️⃣ init() для СТАРЫХ читателей
        self.name = name
        self.id = id
        self.borrowedBooks = borrowedBooks
        self.readingHistory = readingHistory
        self.age = age
    }
    
  func canBorrowBook(withAgeRestriction restriction: Int) -> Bool { // 3️⃣ ✅ Проверка возрастных ограничений — ОТДЕЛЬНЫЙ МЕТОД
        return age >= restriction
    }
}
 
// tests
var books = [
    Book(title: "Hobbit", author: "J.R.R. Tolkien", id: UUID(), category: .fantasy, isAvailable: true),
    Book(title: "Treasure Island", author: "R. Stevenson", id: UUID(), category: .novel, isAvailable: true),
    Book(title: "The White Company", author: "A. Conan Doyle", id: UUID(), category: .novel, isAvailable: true),
    Book(title: "The Hound of the Baskervilles", author: "A. Konan Doyle", id: UUID(), category: .novel, isAvailable: true),
    Book(title: "Dune", author: "Frank Herbert", id: UUID(), category: .scienceFiction, isAvailable: true),
    Book(title: "The Shining", author: "Stephen King", id: UUID(), category: .horror, isAvailable: true),
    Book(title: "Steve Jobs", author: "Walter Isaacson", id: UUID(), category: .biography, isAvailable: true),
    Book(title: "Гарри Поттер", author: "Дж. К. Роулинг", id: UUID(), category: .fantasy,  isAvailable: true)
    ]

// Создание книг и читателей
// ✅ Способ 1: Автоматическая генерация ID
let harryPotter = Book(title: "Harry Potter and Philosopher's Stone", author: "J.K. Rouling", category: .fantasy, isAvailable: true)
let deathlyHallows = Book(title: "Harry Potter and the Deathly Hallows", author: "J.K. Rouling", category: .fantasy, isAvailable: true)

let vale = Reader(name: "Vale", age: 7)

// Проверяем возрастные ограничения
if vale.canBorrowBook(withAgeRestriction: 6) {
    print("✅ \(vale.name) (age \(vale.age)) can borrow '\(harryPotter.title)'.")
} else {
    print("❌ \(vale.name) (age \(vale.age)) is too young for '\(harryPotter.title)'.")
}

if vale.canBorrowBook(withAgeRestriction: 12) {
    print("✅ \(vale.name) (age \(vale.age)) can borrow '\(deathlyHallows.title)'.")
} else {
    print("❌ \(vale.name) (age \(vale.age)) is too young for '\(deathlyHallows.title)'.")
}
 /* ✅ Vale (age 7) can borrow 'Harry Potter and Philosopher's Stone'.
  ❌ Vale (age 7) is too young for 'Harry Potter and the Deathly Hallows'. */
