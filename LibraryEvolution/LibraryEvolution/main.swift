//
//  main.swift
//  LibraryEvolution
//
//  Created by Валерия Пономарева on 01.11.2025.
//

import Foundation

print("📒✨ LibraryEvolution Project")
print("----------")
print("Stage1: libraryBasicImplementation.swift")
print("Stage2: libraryWithEnums.swift")
print("Stage3: libraryWithOptionals.swift")
print("Stage4: libraryWithArchitecture.swift")
print("Stage5: libraryProduction.swift")
print("----------")

enum BookCategory: String, CaseIterable {
    case fantasy = "Fantasy" // ✅ case с raw value
    case horror = "Horror"
    case romance = "Romance"
    case mystery = "Mystery"
    case scienceFiction = "Science Fiction"
    case biography = "Biography"
    case history = "History"
    case novel = "Novel"
}

class Book {
    let title: String
    let author: String
    var category: BookCategory
    var isAvailable: Bool
    let id: UUID
    
    var takenDate: Date?   // ✅ Опциональная - nil когда книга в библиотеке
    var dueDate: Date?     // ✅ Опциональная - nil когда книга не взята
    var returnDate: Date?  // ✅ Опциональная - nil когда книга не возвращена
    
    var daysBorrowed: Int? { // сколько дней книга была взята
        guard let taken = takenDate, let returned =  returnDate else { return nil }
            return Calendar.current.dateComponents([.day], from: taken, to: returned).day
            }
    
    var isOverdue: Bool { // просрочена ли книга
        guard !isAvailable, let due = dueDate else { return false }
        return Date() > due
    }
    
    
    var detailStatus: String  { // статус с подробной инфой
        if isAvailable {
            return "The book is available in library"
        } else if isOverdue {
            return "The book is overdue"
        } else {
            return "The book has been issued on time \(dueDate?.formatted() ?? "unknown")"
        }
    }
    
    init(title: String, author: String, category: BookCategory, isAvailable: Bool = true, id: UUID) {
        self.title = title
        self.author = author
        self.category = category
        self.isAvailable = isAvailable
        self.id = id
    }
    
    func takeBook() {
        if isAvailable { // книга ДОСТУПНА -> ЛЮБОЙ МОЖЕТ ее взять
            isAvailable = false // поменяли статус - ВЗЯЛИ - стала НЕдоступна
            takenDate = Date()
            dueDate = Calendar.current.date(byAdding: .day, value: 14, to: Date()) // + 14 days
            print("✅ The book \(title) successfully taken.") // книга ВЗЯТА
            } else {
                print("❌ The book \(title) already taken by someone") // книга УЖЕ взята кем-то -> НИКТО НЕ может ее взять
        }
    }
    
    func returnBook() {
        if !isAvailable { // книга УЖЕ взята
            isAvailable = true // меняем статус - МОЖЕМ вернуть
            returnDate = Date()
            print("✅ The book \(title) successfully returned")
        } else { // книга УЖЕ в библиотеке - НЕЧЕГО возвращать
            print("The book \(title) was already in library.")
            
        }
    }
}
    
// tests
var books: [Book] = [
    Book(title: "Hobbit", author: "J.R.R. Tolkien", category: .fantasy, isAvailable: true, id: UUID()),
    Book(title: "Treasure Island", author: "R. Stevenson", category: .novel, isAvailable: true, id: UUID()),
    Book(title: "The White Company", author: "A. Conan Doyle", category: .novel, isAvailable: true, id: UUID()),
    Book(title: "The Hound of the Baskervilles", author: "A. Konan Doyle", category: .novel, isAvailable: true, id: UUID()),
    Book(title: "Dune", author: "Frank Herbert", category: .scienceFiction, isAvailable: true, id: UUID()),
    Book(title: "The Shining", author: "Stephen King", category: .horror, isAvailable: true, id: UUID()),
    Book(title: "Steve Jobs", author: "Walter Isaacson", category: .biography, isAvailable: true, id: UUID())
]

print(" 📚 The Library:")
for (index, book) in books.enumerated() {
    print("\(index + 1). \(book.title) - \(book.detailStatus)")
}
books[0].takeBook() // берем 'Hobbit'
books[3].takeBook() // // Берем 'The Hound of the Baskervilles'
books[0].takeBook() // пытаемся взять 'Hobbit' еще раз - error!

print("\n📊 Статусы книг после операций:")
for book in books {
    print("\(book.title): \(book.detailStatus)")
}

print("\n🔄 Тестируем возврат книг:")
books[0].returnBook()  // Возвращаем Hobbit
books[3].returnBook()  // Возвращаем The Hound of the Baskervilles

print("\n📊 Финальные статусы книг:")
for book in books {
    print("\(book.title): \(book.detailStatus)")
}

print("\n⏰ Тест просрочки:")
let testBook = books[1] // Treasure Island
testBook.takeBook()

// Имитируем просрочку - устанавливаем прошедшую дату
testBook.dueDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
print("\(testBook.title): \(testBook.detailStatus)")
print("Is overdue: \(testBook.isOverdue)")

/*   📚 The Library:
 1. Hobbit - The book is available in library
 2. Treasure Island - The book is available in library
 3. The White Company - The book is available in library
 4. The Hound of the Baskervilles - The book is available in library
 5. Dune - The book is available in library
 6. The Shining - The book is available in library
 7. Steve Jobs - The book is available in library
 ✅ The book Hobbit successfully taken.
 ✅ The book The Hound of the Baskervilles successfully taken.
 ❌ The book Hobbit already taken by someone

 "📊 Статусы книг после операций:":
 Hobbit: The book has been issued on time 18.11.2025, 8:03
 Treasure Island: The book is available in library
 The White Company: The book is available in library
 The Hound of the Baskervilles: The book has been issued on time 18.11.2025, 8:03
 Dune: The book is available in library
 The Shining: The book is available in library
 Steve Jobs: The book is available in library

 🔄 Тестируем возврат книг:
 ✅ The book Hobbit successfully returned
 ✅ The book The Hound of the Baskervilles successfully returned

 📊 Финальные статусы:
 Hobbit: The book is available in library
 Treasure Island: The book is available in library
 The White Company: The book is available in library
 The Hound of the Baskervilles: The book is available in library
 Dune: The book is available in library
 The Shining: The book is available in library
 Steve Jobs: The book is available in library

 ⏰ Тест просрочки:
 ✅ The book Treasure Island successfully taken.
 Treasure Island: The book is overdue
 Is overdue: true */
