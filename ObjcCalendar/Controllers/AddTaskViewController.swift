//
//  AddTaskViewController.swift
//  ObjcCalendar
//
//  Created by mike on 22.01.24.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController {
    private var addTaskView: AddTaskView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        setupHideKeyboardByTap()
        addTaskView.addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }

    private func configureView() {
        addTaskView = AddTaskView()
        addTaskView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTaskView)

        let closeButton = UIButton(type: .custom)
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(UIColor.black, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            addTaskView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addTaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    private func setupHideKeyboardByTap() {
        let tg = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tg)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func addTaskButtonTapped() {
        guard let name = addTaskView.nameTextField.text, !name.isEmpty else {
            showAlert(message: "Please check your task name field.")
            return
        }

        guard let description = addTaskView.descriptionTextField.text, !description.isEmpty else {
            showAlert(message: "Please check your task description field.")
            return
        }

        let startDate = addTaskView.startDatePicker.date
        let finishDate = addTaskView.finishDatePicker.date


        guard startDate <= finishDate else {
            showAlert(message: "Start date must be before finish date.")
            return
        }

        let event = EventModel()
        event.id = IDManager.shared.getUniqueID()
        event.name = name
        event.date_start = startDate
        event.date_finish = finishDate
        event.descriptionText = addTaskView.descriptionTextField.text ?? ""
        let realm = try! Realm()
        try! realm.write {
              realm.add(event)
        }
        NotificationCenter.default.post(name: NSNotification.Name("NewTaskAdded"), object: nil)
        dismiss(animated: true, completion: nil)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
