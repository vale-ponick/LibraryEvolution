//
//  libraryProduction.swift
//  LibraryEvolution
//
//  Created by Валерия Пономарева on 01.11.2025.
//

import Foundation

//📚 Задача: "Создай систему читателей и библиотеки для управления книгами и юзерами"

class Book {
    let title: String
    let author: String
    let id: UUID
    var isAvailable: Bool
    
    init(title: String, author: String, id: UUID = UUID(), isAvailable: Bool = true) {
        self.title = title
        self.author = author
        self.id = id
        self.isAvailable = isAvailable
    }

    var isBorrowed: Bool { // книга взята или доступна
        return !isAvailable
    }
}

class Reader {
    let name: String
    let readerID: UUID // уникальный идентификатор читателя
    var borrowedBooks: [UUID]// массив ID взятых книг
    var isActive: Bool // статус читателя: автивен / заблокирован
    
    init(name: String, readerID: UUID = UUID(), borrowedBooks: [UUID] = [], isActive: Bool = true) {
        self.name = name
        self.readerID = readerID
        self.borrowedBooks = borrowedBooks
        self.isActive = isActive
    }
    
    func borrowBook(_ book: Book) -> Bool { // ВЗЯТЬ книгу
        if book.isAvailable && isActive { // если книга ДОСТУПНА и читатель АКТИВЕН
            book.isAvailable = false // меняем статус книги
            borrowedBooks.append(book.id) // жлбавим ID книги
            print("✅ \(name) взял(а) книгу '\(book.title)'")
            return true
        } else {
            if !book.isAvailable {
                print("❌ the book '\(book.title)' is already borrowed")
            }
            if !isActive {
                print("❌ reader '\(name)' is blocked")
            }
            return false
        }
    }
}

class Library {
    var books: [Book]  = [] // ✅ УЖЕ инициализировано значением пустой массив всех книг
    var readers: [Reader] = []
    var lendingHistory: [(bookID: UUID, readerID: UUID, date: Date)] = [] // история выдачи
    
    init() {}
    
    func addReader(_ reader: Reader) {
        readers.append(reader)
    }
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func findBook(by title: String) -> Book? { // найти книгу по названию
        return books.first { $0.title == title && $0.isAvailable }
    }
    
    func lendBook(bookID: UUID, to readerID: UUID) -> Bool {
        if let book = books.first(where: { $0.id == bookID }),
           let reader = readers.first(where: { $0.readerID == readerID }) {
            
            if reader.borrowBook(book) {
                lendingHistory.append((bookID: book.id, readerID: reader.readerID, date: Date()))    // ✅ ДОБАВЛЯЕМ в историю
                return true
            }
        }
        return false
    }
    
    func returnBook(bookID: UUID, from readerID: UUID) -> Bool {
        if let book = books.first(where: { $0.id == bookID }),
           let reader = readers.first(where: { $0.readerID == readerID }) {
            
            guard reader.borrowedBooks.contains(bookID) else {  // 1. Проверяем, что книга действительно у этого читателя
                print("❌ Эта книга не у этого читателя")
                return false
            }
            
            book.isAvailable = true // 2. Делаем книгу доступной
            reader.borrowedBooks.removeAll { $0 == bookID } // 3. Убираем книгу у читателя
            print("✅ Книга '\(book.title)' возвращена")
            return true
        }
        return false
    }
    
    func showLendingHistory() {    // Показать историю выдачи
        for record in lendingHistory {
            print("Книга \(record.bookID) выдана читателю \(record.readerID) в \(record.date)")
        }
    }
    
    func findBooksByReader(_ readerID: UUID) -> [Book] {  // Найти все книги читателя
        return books.filter { book in
            !book.isAvailable && lendingHistory.contains {
                $0.bookID == book.id && $0.readerID == readerID
            }
        }
    }
}

// Создаем библиотеку и тестовые данные
let library = Library()
let book = Book(title: "Swift Programming", author: "Apple")
let reader = Reader(name: "Anna")

library.addBook(book)
library.addReader(reader)

print("=== ТЕСТ 1: Поиск книги ===")
if let foundBook = library.findBook(by: "Swift Programming") {
    print("✅ Найдена книга: '\(foundBook.title)'")
} else {
    print("❌ Книга не найдена")
}

print("\n=== ТЕСТ 2: Выдача книги ===")
let success = library.lendBook(bookID: book.id, to: reader.readerID)
print("Книга выдана: \(success)")
print("Книга доступна: \(book.isAvailable)")
print("Книги у читателя: \(reader.borrowedBooks.count)")

print("\n=== ТЕСТ 3: Возврат книги ===")
let returned = library.returnBook(bookID: book.id, from: reader.readerID)
print("Книга возвращена: \(returned)")
print("Книга доступна: \(book.isAvailable)")
print("Книги у читателя: \(reader.borrowedBooks.count)")

print("\n=== ТЕСТ 4: История ===")
library.showLendingHistory()

print("\n=== ТЕСТ 5: Повторная выдача ===")
let success2 = library.lendBook(bookID: book.id, to: reader.readerID)
print("Книга выдана повторно: \(success2)")

/* ----------
 === ТЕСТ 1: Поиск книги ===
 ✅ Найдена книга: 'Swift Programming'

 === ТЕСТ 2: Выдача книги ===
 ✅ Anna взял(а) книгу 'Swift Programming'
 Книга выдана: true
 Книга доступна: false
 Книги у читателя: 1

 === ТЕСТ 3: Возврат книги ===
 ✅ Книга 'Swift Programming' возвращена
 Книга возвращена: true
 Книга доступна: true
 Книги у читателя: 0

 === ТЕСТ 4: История ===
 Книга 36F0652B-C97F-423C-A71E-2D3A82B9DBE3 выдана читателю D8EDC3E0-6D53-4DE1-BBF5-D93682F6C530 в 2025-11-05 04:08:31 +0000

 === ТЕСТ 5: Повторная выдача ===
 ✅ Anna взял(а) книгу 'Swift Programming'
 Книга выдана повторно: true */
