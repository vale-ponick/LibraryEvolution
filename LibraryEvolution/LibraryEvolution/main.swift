//
//  main.swift
//  LibraryEvolution
//
//  Created by Валерия Пономарева on 01.11.2025.
//

import Foundation

class Book {
    let title: String
    let author: String
    private(set) var isAvailable: Bool // Защита от случайных изменений
    
    init(title: String, author: String, isAvailable: Bool = true) {
        self.title = title
        self.author = author
        self.isAvailable = isAvailable
    }
    
    var status: String { isAvailable ? "✅ available" : "❌ borrowed" }
    
    func takeBook() -> Bool {
        guard isAvailable else { return false }
        isAvailable = false
        return true
    }
    
    func returnBook() -> Bool {
        guard !isAvailable else { return false }
        isAvailable = true
        return true
    }
}

let books = [
    Book(title: "Treasure Island", author: "R. Stevenson"),
    Book(title: "Witcher", author: "A. Sapkowski"),
    Book(title: "What Dead Nan Said", author: "J. Chmielewska")
]

if books[0].takeBook() { print("✅ \(books[0].title) taken") }
if books[1].takeBook() { print("✅ \(books[1].title) taken") }

print("\n📚 Library:")
for book in books {
    print("📖 \(book.title)\n👤 \(book.author)\n📊 \(book.status)\n-------------")
}
/* ✅ Treasure Island taken
 ✅ Witcher taken

 📚 Library:
 📖 Treasure Island
 👤 R. Stevenson
 📊 ❌ borrowed
 -------------
 📖 Witcher
 👤 A. Sapkowski
 📊 ❌ borrowed
 -------------
 📖 What Dead Nan Said
 👤 J. Chmielewska
 📊 ✅ available
 ------------- */
