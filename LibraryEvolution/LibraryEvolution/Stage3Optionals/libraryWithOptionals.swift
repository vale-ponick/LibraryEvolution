//
//  libraryWithOptionals.swift
//  LibraryEvolution
//
//  Created by Валерия Пономарева on 01.11.2025.
//

import Foundation

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
    
    var takenDate: Date? // опциональные свойства
    var dueDate: Date? // когда должны вернуть (дедлайн)
    var returnDate: Date? // когда фактически вернули
    
    init(title: String, author: String, category: BookCategory, isAvailable: Bool, id: UUID) {
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
            print("✅ The book \(title) succesfully taken.") // книга ВЗЯТА
            } else {
                print("❌ The book \(title) already taken someone") // книга УЖЕ у ДРУГОГО читателя на руках - НИКТО НЕ может ее взять
        }
    }
    
    func returnBook() {
        if !isAvailable { // книга УЖЕ взята
            isAvailable = true // меняем статус - можем вернуть
            returnDate = Date()
            print("✅ The book \(title) successfully returned")
        } else { // книга УЖЕ в библиотеке - НЕЧЕГО возвращать
            print("The book \(title) was already in library.")
            
        }
    }
}
    

