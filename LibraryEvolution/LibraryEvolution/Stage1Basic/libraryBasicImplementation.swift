//
//  LibraryBasicImplementation.swift
//  LibraryEvolution
//
//  Created by Валерия Пономарева on 01.11.2025.
//

import Foundation

print(" 📖 Задача: Создай класс Книга с свойствами: название, автор, статус доступности ✅ / ❌. Добавь методы для взятия и возврата книги. Создай несколько экземпляров книг, помести их в массив и выведи 📚 красивый список в консоль с текущими статусами.")

class Book {
    let title: String
    let author: String
    var isAvailable: Bool
    
    init(title: String, author: String, isAvailable: Bool) {
        self.title = title
        self.author = author
        self.isAvailable = isAvailable
    }
    
    func takeBook() {
        if isAvailable { // book in library -> ЛЮБОЙ МОЖЕТ ее взять
            isAvailable = false // теперь книга у читателя
            print("✅ The book \(title) succesfully taken.") // книга ВЗЯТА
        } else {
            print("❌ The book \(title) already taken someone") // книга УЖЕ у ДРУГОГО читателя на руках - НИКТО НЕ может ее взять
        }
    }
    
    func returnBook() {
        if !isAvailable { // книга у читателя - МОЖНО вернуть ✅
            isAvailable = true // теперь книга в библиотеке
            print("✅ The book \(title) successfully returned to the library") // УСПЕШНО вернули
        } else { // книга в библиотеке - НЕЧЕГО возвращать ❌
            print("❌ The book \(title) already in the library.") // возвращать НЕЧЕГО
        }
    }
}
    
let treasureIsland = Book(title: "Treasure Island", author: "R. Stevenson", isAvailable: true)
let witcher = Book(title: "Witcher", author: "A.Sapkovsky", isAvailable: true)
let whatDeadManSaid = Book(title: "What Dead Nan Said", author: "J. Chmielewska", isAvailable: true)

func createLibrary() {
    var books: [Book] = []
    
    books.append(treasureIsland)
    books.append(witcher)
    books.append(whatDeadManSaid)
    
    treasureIsland.takeBook()
    witcher.takeBook()
    
    print("\n📚 Library:")
    
    for book in books {
        let status = book.isAvailable ? "✅ book is available" : "❌ book is busy"
        print("📖 \(book.title)")
              print("👤 \(book.author)")
              print("📊 \(status)")
        print("-------------")
    }
}
createLibrary()

/* 📖 Задача: Создай класс Книга с свойствами: название, автор, статус доступности ✅ / ❌. Добавь методы для взятия и возврата книги. Создай несколько экземпляров книг, помести их в массив и выведи 📚 красивый список в консоль с текущими статусами.
 
✅ The book Treasure Island succesfully taken.
✅ The book Witcher succesfully taken.

📚 Library:
📖 Treasure Island
👤 R. Stevenson
📊 ❌ book is busy
-------------
📖 Witcher
👤 A.Sapkovsky
📊 ❌ book is busy
-------------
📖 What Dead Nan Said
👤 J. Chmielewska
📊 ✅ book is available
------------- */


/* 📚 Аналогия:
  Представь парковочное место:

  Свободно (isAvailable = true) → любой может занять

  Занято (isAvailable = false) → никто не может занять

  Не важно кто именно взял книгу - важно, что она УЖЕ занята. */


