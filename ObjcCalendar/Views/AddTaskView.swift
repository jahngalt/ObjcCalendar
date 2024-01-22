//
//  AddTaskView.swift
//  ObjcCalendar
//
//  Created by mike on 17.01.24.
//

import UIKit

class AddTaskView: UIView {
     var taskNameLabel: UILabel = createLabel(withText: "Name:")
     var taskDescriptionLabel: UILabel = createLabel(withText: "Description:")
     var startLabel: UILabel = createLabel(withText: "Start date:")
     var finishLabel: UILabel = createLabel(withText: "Finish date:")

     var nameTextField: UITextField = createTextField(withPlaceholder: "Task name")
     var descriptionTextField: UITextField = createTextField(withPlaceholder: "Description")

     var startDatePicker: UIDatePicker = createDatePicker()
     var finishDatePicker: UIDatePicker = createDatePicker()

     var addTaskButton: UIButton = createButton(withTitle: "Add task")

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    private func setUp() {
        [taskNameLabel, taskDescriptionLabel, startLabel, finishLabel,
         nameTextField, descriptionTextField, startDatePicker, finishDatePicker, addTaskButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate(makeConstraints())
    }

    private func makeConstraints() -> [NSLayoutConstraint] {
        let margin = layoutMarginsGuide
        return   [
            taskNameLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

            nameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            nameTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),

            taskDescriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

            descriptionTextField.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            descriptionTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            descriptionTextField.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            descriptionTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),

            startLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 10),
            startLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

            startDatePicker.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 10),
            startDatePicker.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            startDatePicker.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

            finishLabel.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 10),
            finishLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

            finishDatePicker.topAnchor.constraint(equalTo: finishLabel.bottomAnchor, constant: 10),
            finishDatePicker.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            finishDatePicker.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

            addTaskButton.topAnchor.constraint(greaterThanOrEqualTo: finishDatePicker.bottomAnchor, constant: 20),
            addTaskButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            addTaskButton.bottomAnchor.constraint(lessThanOrEqualTo: margin.bottomAnchor)
        ]
    }

    // MARK: - Helper Methods
    private static func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }

    private static func createTextField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        configureTextFieldAppearance(textField)
        return textField
    }

    private static func configureTextFieldAppearance(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 6.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }

    private static func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        return datePicker
    }

    private static func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Add task", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        return button
    }
}
