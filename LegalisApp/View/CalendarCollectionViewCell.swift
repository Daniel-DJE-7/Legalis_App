//
//  CalendarCollectionViewCell.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/6/26.
//

import UIKit

protocol CalendarCollectionViewCellDelegate: AnyObject {
    func calendar(
        cell: CalendarCollectionViewCell,
        didSelect date: DateComponents?
    )

    func calendar(
        cell: CalendarCollectionViewCell,
        didChangeMonth date: Date
    )
}

enum CalendarDayState {
    case available
    case unavailable
    case holiday
}

final class CalendarCollectionViewCell: UICollectionViewCell {

    static let identifier = "CalendarCollectionViewCell"

    weak var delegate: CalendarCollectionViewCellDelegate?

    private let calendar = Calendar(
        identifier: .gregorian
    )

    private var displayedMonth = Date()
    private var selectedDate: DateComponents?

    private var dayStates: [String: CalendarDayState] = [:]

    private let containerView = UIView()
    private let monthLabel = UILabel()
    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let daysStack = UIStackView()
    private let datesGrid = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        renderCalendar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(containerView)

        monthLabel.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
        monthLabel.textAlignment = .center

        previousButton.setImage(
            UIImage(systemName: "chevron.left"),
            for: .normal
        )

        nextButton.setImage(
            UIImage(systemName: "chevron.right"),
            for: .normal
        )

        previousButton.tintColor = UIColor(
            red: 0,
            green: 0.14,
            blue: 0.29,
            alpha: 1
        )

        nextButton.tintColor = previousButton.tintColor

        previousButton.addTarget(
            self,
            action: #selector(previousMonth),
            for: .touchUpInside
        )

        nextButton.addTarget(
            self,
            action: #selector(nextMonth),
            for: .touchUpInside
        )

        let headerStack = UIStackView(
            arrangedSubviews: [
                previousButton,
                monthLabel,
                nextButton
            ]
        )

        headerStack.axis = .horizontal
        headerStack.alignment = .center
        headerStack.distribution = .fill

        previousButton.widthAnchor.constraint(
            equalToConstant: 36
        ).isActive = true

        nextButton.widthAnchor.constraint(
            equalToConstant: 36
        ).isActive = true

        daysStack.axis = .horizontal
        daysStack.distribution = .fillEqually

        for title in ["L", "M", "M", "J", "V", "S", "D"] {

            let label = UILabel()
            label.text = title
            label.font = .systemFont(
                ofSize: 13,
                weight: .medium
            )
            label.textColor = .secondaryLabel
            label.textAlignment = .center

            daysStack.addArrangedSubview(label)
        }

        datesGrid.axis = .vertical
        datesGrid.spacing = 4
        datesGrid.distribution = .fillEqually

        let mainStack = UIStackView(
            arrangedSubviews: [
                headerStack,
                daysStack,
                datesGrid
            ]
        )

        mainStack.axis = .vertical
        mainStack.spacing = 14
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(mainStack)

        NSLayoutConstraint.activate([

            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            containerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),

            mainStack.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 16
            ),
            mainStack.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 12
            ),
            mainStack.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -12
            ),
            mainStack.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -16
            ),

            daysStack.heightAnchor.constraint(
                equalToConstant: 24
            )
        ])
    }

    func configure(
        month: Date,
        selectedDate: DateComponents?,
        dayStates: [String: CalendarDayState]
    ) {
        displayedMonth = month
        self.selectedDate = selectedDate
        self.dayStates = dayStates

        renderCalendar()
    }

    private func renderCalendar() {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_CO")
        formatter.dateFormat = "LLLL yyyy"

        monthLabel.text = formatter
            .string(from: displayedMonth)
            .capitalized

        datesGrid.arrangedSubviews.forEach {
            datesGrid.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        guard let monthInterval = calendar.dateInterval(
            of: .month,
            for: displayedMonth
        ),
        let dayRange = calendar.range(
            of: .day,
            in: .month,
            for: displayedMonth
        ) else {
            return
        }

        let firstWeekday = calendar.component(
            .weekday,
            from: monthInterval.start
        )

        let leadingEmptyDays = (firstWeekday + 5) % 7
        let totalCells = leadingEmptyDays + dayRange.count
        let rowCount = (totalCells + 6) / 7

        for rowIndex in 0..<rowCount {

            let row = UIStackView()
            row.axis = .horizontal
            row.distribution = .fillEqually
            row.spacing = 2

            for column in 0..<7 {

                let index = rowIndex * 7 + column
                let day = index - leadingEmptyDays + 1

                if day < 1 || day > dayRange.count {
                    row.addArrangedSubview(UIView())
                    continue
                }

                let button = makeDayButton(day: day)
                row.addArrangedSubview(button)
            }

            datesGrid.addArrangedSubview(row)

            row.heightAnchor.constraint(
                equalToConstant: 38
            ).isActive = true
        }
    }

    private func makeDayButton(day: Int) -> UIButton {

        let button = UIButton(type: .system)
        button.tag = day
        button.layer.cornerRadius = 8

        let components = calendar.dateComponents(
            [.year, .month],
            from: displayedMonth
        )

        var dateComponents = components
        dateComponents.day = day

        let key = dateKey(dateComponents)

        let state = dayStates[key] ?? .unavailable

        let isSelected =
            selectedDate?.year == dateComponents.year &&
            selectedDate?.month == dateComponents.month &&
            selectedDate?.day == day

        let color: UIColor
        let isEnabled: Bool

        switch state {
        case .available:
            color = .label
            isEnabled = true

        case .unavailable:
            color = .systemGray3
            isEnabled = false

        case .holiday:
            color = .systemRed
            isEnabled = false
        }

        let textColor = isSelected
            ? UIColor.systemBlue
            : color

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: UIFont.systemFont(
                ofSize: 15,
                weight: isSelected ? .semibold : .regular
            ),
            .underlineStyle: isSelected ? 1 : 0,
            .strikethroughStyle: stateIsUnavailable(state) ? 1 : 0
        ]

        button.setAttributedTitle(
            NSAttributedString(
                string: "\(day)",
                attributes: attributes
            ),
            for: .normal
        )

        button.backgroundColor = isSelected
            ? UIColor.systemBlue.withAlphaComponent(0.12)
            : .clear

        button.isEnabled = isEnabled

        button.addTarget(
            self,
            action: #selector(dayTapped(_:)),
            for: .touchUpInside
        )

        return button
    }

    private func stateIsUnavailable(
        _ state: CalendarDayState
    ) -> Bool {
        if case .unavailable = state {
            return true
        }
        return false
    }

    private func dateKey(
        _ components: DateComponents
    ) -> String {
        String(
            format: "%04d-%02d-%02d",
            components.year ?? 0,
            components.month ?? 0,
            components.day ?? 0
        )
    }

    @objc private func dayTapped(_ sender: UIButton) {

        var components = calendar.dateComponents(
            [.year, .month],
            from: displayedMonth
        )

        components.day = sender.tag

        selectedDate = components
        renderCalendar()

        delegate?.calendar(
            cell: self,
            didSelect: components
        )
    }

    @objc private func previousMonth() {
        changeMonth(by: -1)
    }

    @objc private func nextMonth() {
        changeMonth(by: 1)
    }

    private func changeMonth(by value: Int) {

        guard let newMonth = calendar.date(
            byAdding: .month,
            value: value,
            to: displayedMonth
        ) else {
            return
        }

        displayedMonth = newMonth
        renderCalendar()

        delegate?.calendar(
            cell: self,
            didChangeMonth: newMonth
        )
    }
}
