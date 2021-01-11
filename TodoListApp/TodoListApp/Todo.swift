//
//  Todo.swift
//  TodoList
//
//  Created by joonwon lee on 2020/03/19.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit


// TODO: Codable과 Equatable 추가
struct Todo: Codable, Equatable {
    let id: Int         // 구분자, PK
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        // [완료] TODO: update 로직 추가
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        /**
         객체 간의 동등 비교를 하기 위해 Equatable 프로토콜을 따라야 하고,
         '==' 연산자를 정의할 수 있다.
        */
        // [완료] TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }
}

/**
 ViewModel이 TodoList에 대한 정보를 TodoManager에게 물어볼 것이다.
 */
class TodoManager {
    
    // 앱 내에서 한 개의 객체만 있으면 되고 이 객체가 여기저기서 불리면 되겠다 라는 판단이 설 때.
    static let shared = TodoManager()   // 싱글톤 객체
    
    static var lastId: Int = 0          // 새로운 Task를 만들 때 참고.
    
    var todos: [Todo] = []
    
    func createTodo(detail: String, isToday: Bool) -> Todo {
        // [완료] TODO: create로직 생성
        let nextId = TodoManager.lastId + 1
        TodoManager.lastId = nextId
        return Todo(id: nextId, isDone: false, detail: detail, isToday: isToday)
    }
    
    func addTodo(_ todo: Todo) {
        // [완료] TODO: add로직 추가
        todos.append(todo)
        // 바로 디스크에 저장.
        saveTodo()
    }
    
    func deleteTodo(_ todo: Todo) {
        // [완료] TODO: delete 로직 추가
        /**
         퍼포먼스가 높은 코드와 읽기 좋은 코드에 대해선 퍼포먼스 이슈가 큰 것이 아닌 이상 가독성이 높은 코드를 써보는게 어떠겠냐.
         */
        // 같지 않은 애들만 찾아서 리턴한다. (걸러내는 개념임.)
        todos = todos.filter { $0.id != todo.id }
//        // 이게 더 효율적.
//        if let index = todos.firstIndex(of: todo) {
//            todos.remove(at: index)
//        }
        saveTodo()
    }
    
    func updateTodo(_ todo: Todo) {
        // [완료] TODO: updatee 로직 추가
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
        saveTodo()
    }
    
    func saveTodo() {
        // 디스크에 저장
        Storage.store(todos, to: .documents, as: "todos.json")
    }
    
    func retrieveTodo() {
        // 파일을 읽어와서 Todo 객체로 변환. (메모리에 올림)
        todos = Storage.retrive("todos.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}

// ViewController에서 ViewModel을 사용함.
class TodoViewModel {
    
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    
    private let manager = TodoManager.shared
    
    var todos: [Todo] {
        return manager.todos
    }
    
    var todayTodos: [Todo] {
        return todos.filter { $0.isToday == true }
    }
    
    var upcompingTodos: [Todo] {
        return todos.filter { $0.isToday == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addTodo(_ todo: Todo) {
        manager.addTodo(todo)
    }
    
    func deleteTodo(_ todo: Todo) {
        manager.deleteTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        manager.updateTodo(todo)
    }
    
    func loadTasks() {
        manager.retrieveTodo()
    }
}

