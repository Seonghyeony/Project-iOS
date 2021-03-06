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
        
        // [o] TODO: 키보드 Detection.
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)     // keyboardWillShowNotification이 감지가 되면 selector의 adjustInputView가 호출 된다.
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // [완료] TODO: 데이터 불러오기
        todoListViewModel.loadTasks()
        
        // 데이터 저장 Test
//        let todo = TodoManager.shared.createTodo(detail: "Corona 싫어!", isToday: true)
//        Storage.saveTodo(todo, fileName: "test.json")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 데이터 불러오기 Test
//        let todo = Storage.restoreTodo("test.json")
//        print("---> restore from disk: \(todo)")
    }
    
    @IBAction func isTodayButtonTapped(_ sender: Any) {
        // [o] TODO: 투데이 버튼 토글 작업
        isTodayButton.isSelected = !isTodayButton.isSelected
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        // [o] TODO: Todo 태스크 추가
        // add task to view model
        // and tableview reload or update
        
        guard let detail = inputTextField.text, detail.isEmpty == false else { return }
        let todo = TodoManager.shared.createTodo(detail: detail, isToday: isTodayButton.isSelected)
        
        todoListViewModel.addTodo(todo)
        collectionView.reloadData()     // reload.
        inputTextField.text = ""
        isTodayButton.isSelected = false
    }
    
    // TODO: BG 탭했을때, 키보드 내려오게 하기 - Tap Gesture Recognizer.
    @IBAction func tapBG(_ sender: Any) {
        inputTextField.resignFirstResponder()   // 사용자한테 제일 먼저 반응하는 녀석이였는데 그것을 resign 한다.
    }
}

extension TodoListViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }  // userInfo: 딕셔너리 타입.
        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        // 키보드가 다 올라왔을 때, 나 내려갔을 때 위치와 크기 정보를 달라!
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if noti.name == UIResponder.keyboardWillShowNotification {  // 키보드가 보여지는 noti면,
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom   // view.safeAreaInsets 아이폰 X 부터 노치가 생기면서 위 아래에 safeArea가 생겼다. 이 부분을 빼줘야 한다.
            
            inputViewBottom.constant = adjustmentHeight
        } else {
            inputViewBottom.constant = 0
        }
        
        print("---> Keyboard End Frame: \(keyboardFrame)")
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
        // [o] TODO: doneButtonHandler 작성
        // [o] TODO: deleteButtonHandler 작성
        
        cell.doneButtonTapHandler = { isDone in
            todo.isDone = isDone
            self.todoListViewModel.updateTodo(todo)
            self.collectionView.reloadData()
        }
        cell.deleteButtonTapHandler = {
            self.todoListViewModel.deleteTodo(todo)
            self.collectionView.reloadData()
        }
        
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
