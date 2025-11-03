//
//  libraryWithEnums.swift
//  LibraryEvolution
//
//  Created by Валерия Пономарева on 01.11.2025.
//

import Foundation

enum BookCategory: String, CaseIterable {
    case fantasy = "fantasy"
    case horror = "horror"
    case romance = "romance"
    case mystery = "mystery"
    case scienceFiction = "scienceFiction"
    case biography = "biography"
}

class Book {
    let title: String
    let author: String
    let category: BookCategory
    var isAvailable: Bool
    
    init(title: String, author: String, category: BookCategory, isAvailable: Bool) {
        self.title = title
        self.author = author
        self.category = category
        self.isAvailable = isAvailable
    }

    func takeBook() {
        if isAvailable {
            isAvailable = false
            print("✅ the book '\(title)' is now borrowed.")
        } else {
            print("❌ the book '\(title)' was borrowed by someone reader.")
        }
    }

    func returnBook() {
        if !isAvailable {
            isAvailable = true
            print("✅ the book '\(title)' is now returned to the library.")
        } else {
            print("❌ the book '\(title)' was already available in the library.")
        }
    }
    
    func displayInfo() {
        let status = isAvailable ? "✅ available" : "❌ borrowed"
        print("'\(title)' - \(author) (\(category)) - \(status)")
    }
}

// Тестовый код
let books = [
    Book(title: "Hobbit", author: "J.R.R.Tolkien", category: .fantasy, isAvailable: true),
    Book(title: "Shining", author: "Stephen King", category: .horror, isAvailable: true),
    Book(title: "Harry Potter", author: "J.K. Rowling", category: .fantasy, isAvailable: false)
]

print("📚 Testing Stage2Enums:")
books[0].takeBook()
books[1].takeBook()
books[0].takeBook()

print("\n📚 Final Status:")
for book in books {
    book.displayInfo()
}
/* 📚 Testing Stage2Enums:
 ✅ the book 'Hobbit' is now borrowed.
 ✅ the book 'Shining' is now borrowed.
 ❌ the book 'Hobbit' was borrowed by someone reader.

 📚 Final Status:
 'Hobbit' - J.R.R.Tolkien (fantasy) - ❌ borrowed
 'Shining' - Stephen King (horror) - ❌ borrowed
 'Harry Potter' - J.K.Rowling (fantasy) - ❌ borrowed */
