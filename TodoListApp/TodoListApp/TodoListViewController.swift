//
//  TodoListViewController.swift
//  TodoList
//
//  Created by joonwon lee on 2020/03/19.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var isTodayButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    
    // [완료] TODO: TodoViewModel 만들기
    let todoListViewModel = TodoViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 키보드 디텍션
        
        
        // [완료] TODO: 데이터 불러오기
        todoListViewModel.loadTasks()
        
        let todo = TodoManager.shared.createTodo(detail: "Corona 싫어!", isToday: true)
        Storage.saveTodo(todo, fileName: "test.json")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let todo = Storage.restoreTodo("test.json")
        print("---> restore from disk: \(todo)")
    }
    
    @IBAction func isTodayButtonTapped(_ sender: Any) {
        // TODO: 투데이 버튼 토글 작업
        
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        // TODO: Todo 태스크 추가
        // add task to view model
        // and tableview reload or update
    }
    
    // TODO: BG 탭했을때, 키보드 내려오게 하기
}

extension TodoListViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        
    }
}

extension TodoListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // [완료] TODO: 섹션 몇개
        return todoListViewModel.numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // [완료] TODO: 섹션별 아이템 몇개
        if section == 0 {
            // section == 0 이면 todayTodos만.
            return todoListViewModel.todayTodos.count
        } else {
            return todoListViewModel.upcompingTodos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCell", for: indexPath) as? TodoListCell else {
            return UICollectionViewCell()
        }
        
        var todo: Todo
        if indexPath.section == 0 {
            todo = todoListViewModel.todayTodos[indexPath.item]
        } else {
            todo = todoListViewModel.upcompingTodos[indexPath.item]
        }
        cell.updateUI(todo: todo)
        
        
        
        // [완료] TODO: 커스텀 셀
        // [완료] TODO: todo 를 이용해서 updateUI
        // [] TODO: doneButtonHandler 작성
        // [] TODO: deleteButtonHandler 작성
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodoListHeaderView", for: indexPath) as? TodoListHeaderView else {
                return UICollectionReusableView()
            }
            
            guard let section = TodoViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
            header.sectionTitleLabel.text = section.title
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension TodoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // [완료] TODO: 사이즈 계산하기
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}

// View 객체.
class TodoListCell: UICollectionViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var strikeThroughView: UIView!
    
    @IBOutlet weak var strikeThroughWidth: NSLayoutConstraint!
    
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    // 스토리보드에서 깨어났을 때
    override func awakeFromNib() {
        super.awakeFromNib()
        // 리셋을 해야한다.
        reset()
    }
    // 화면 밖으로 나가서 셀이 재사용 될 때
    override func prepareForReuse() {
        super.prepareForReuse()
        // 리셋을 해줘야 한다.
        reset()
    }
    
    func updateUI(todo: Todo) {
        // [o] TODO: 셀 업데이트 하기
        checkButton.isSelected = todo.isDone
        descriptionLabel.text = todo.detail
        descriptionLabel.alpha = todo.isDone ? 0.2 : 1
        deleteButton.isHidden = todo.isDone == false
        showStrikeThrough(todo.isDone)      // 밑줄 쫘악
    }
    
    private func showStrikeThrough(_ show: Bool) {
        if show {
            // 보여줄 때
            strikeThroughWidth.constant = descriptionLabel.bounds.width
        } else {
            // 보여주지 않을 때
            strikeThroughWidth.constant = 0
        }
    }
    
    func reset() {
        // [o] TODO: reset로직 구현
        // reset은 일단 초기값으로 할당한다.
        // 왜냐하면 나중에 updateUI()로 셀을 업데이트 하면 된다.
        descriptionLabel.alpha = 1
        deleteButton.isHidden = true
        showStrikeThrough(false)
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        // [o] TODO: checkButton 처리
        checkButton.isSelected = !checkButton.isSelected
        let isDone = checkButton.isSelected
        showStrikeThrough(isDone)
        descriptionLabel.alpha = isDone ? 0.2 : 1
        deleteButton.isHidden = !isDone
        
        // isDone 이냐 아니냐를 넘겨주면 그 Todo 객체를 업데이트 하던지 안하던지.
        doneButtonTapHandler?(isDone)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        // [o] TODO: deleteButton 처리
        // delete 기능은 view에서 하는 것이 아니고 클로저로 TodoManager에게 넘긴다. 데이터를 삭제하기만.
        deleteButtonTapHandler?()
    }
}

class TodoListHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
