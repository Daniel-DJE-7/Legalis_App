//
//  AppointmentScheduleCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 24/6/26.
//

import UIKit

enum SectionTypeAppointment: Int, CaseIterable {
  case calendar = 0
  case hours = 1
  case modality = 2
  case continueBtn = 3
}

class AppointmentScheduleCollectionViewController: CoreCollectionViewController {

  weak var coordinator: BookingCoordinator?
  var selectedDate: DateComponents?
  
  var lawyerId: Int = 0
  private var selectedSlot: LawyerAvailableSlotModel?
  private var selectedModality: AppointmentModality?

  private var displayedMonth = Date()

  private var dayStates: [String: CalendarDayState] = [:]
  private var availableSlots: [LawyerAvailableSlotModel] = []

  private var isLoadingAvailability = false

  private let colombiaTimeZone = TimeZone(identifier: "America/Bogota")!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.backgroundColor = .systemGray6
      navigationItem.title = "Citas"
      navigationController?.navigationBar.prefersLargeTitles = true
      navigationItem.largeTitleDisplayMode = .always
      navigationController?.navigationBar.topItem?.backButtonTitle = "Volver"
      registerCells()
      configureLayout()
    }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  private func registerCells() {
    collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    
    collectionView.register(HoursCollectionViewCell.self, forCellWithReuseIdentifier: HoursCollectionViewCell.identifier)
    
    collectionView.register(ModalityCollectionViewCell.self, forCellWithReuseIdentifier: ModalityCollectionViewCell.identifier)
    
    collectionView.register(ContinueButtonCollectionViewCell.self, forCellWithReuseIdentifier: ContinueButtonCollectionViewCell.identifier)
  }
  
  private func configureLayout() {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSection(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
  }
  
  private func createSection(section: Int) -> NSCollectionLayoutSection {
   
    let header = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(22)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading)
    ]
    
    switch section {
    //MARK: - CALENDAR SECTION
    case 0:
    //firstItem
      let firstItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(350)
        )
      )
    //firstGroup
      let firstGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: firstItem.layoutSize,
        subitems: [firstItem]
      )
      
    //firstSection
      let firstSection = NSCollectionLayoutSection(group: firstGroup)

      firstSection.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 17, bottom: 15, trailing: 0)
      return firstSection
      
      
    //MARK: - HOURS SECTION
    case 1:
      //secondItem
        let secondItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(45)
          )
        )
      secondItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
      
      //secondGroup
      
        let secondVerticalGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(45)
          ),
          subitem: secondItem,
          count: 1
        )
      
//      secondVerticalGroup.contentInsets = .init(top: 0, leading: 17, bottom: 0, trailing: 16)
      
      let secondHorizontalGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(45)
        ),
        subitem: secondVerticalGroup,
        count: 3
      )
      secondHorizontalGroup.contentInsets = .init(top: 0, leading: 17, bottom: 0, trailing: 16)
      
      //secondSection
        let secondSection = NSCollectionLayoutSection(group: secondHorizontalGroup)
            secondSection.interGroupSpacing = 5
       
        return secondSection
      
    //MARK: - MODALITY SECTION
    case 2:
      //thirdItem
        let thirdItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(105)
          )
        )
      
      //thirdGroup
        let thirdGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: thirdItem.layoutSize,
          subitem: thirdItem,
          count: 1
        )
      
      thirdGroup.interItemSpacing = .fixed(5)
      //thirdSection
        let thirdSection = NSCollectionLayoutSection(group: thirdGroup)
      thirdSection.contentInsets = .init(top: 16, leading: 17, bottom: 16, trailing: 16)
        return thirdSection
      
    //MARK: - btn
    case 3:
      let fourthtItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(54)
        )
      )
      //group
      let fourhtGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: fourthtItem.layoutSize,
        subitems: [fourthtItem]
      )
      fourhtGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
      //section
      let fourthSection = NSCollectionLayoutSection(group: fourhtGroup)
          
      return fourthSection
      
    //MARK: - DEFAULT SECTION
    default:
      //item
      let defautltItem = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .estimated(140),
          heightDimension: .absolute(200)
        )
      )
      //group
      let defaultGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: defautltItem.layoutSize,
        subitems: [defautltItem]
      )
      //section
      let defaultSection = NSCollectionLayoutSection(group: defaultGroup)
          
      return defaultSection
    }
  }

  private func loadAvailability(for date: String) {

      guard lawyerId > 0 else {
          showScheduleError("No se encontró el abogado.")
          return
      }

      isLoadingAvailability = true

      Task { @MainActor [weak self] in

          guard let self = self else { return }

          do {
              let response = try await APICaller.shared.getLawyerAvailability(
                  lawyerId: self.lawyerId,
                  date: date
              )

              self.isLoadingAvailability = false

              self.availableSlots = response.availableSlots

              self.dayStates[date] = response.isHoliday
                  ? .holiday
                  : response.availableSlots.isEmpty
                      ? .unavailable
                      : .available

              self.collectionView.reloadSections(
                  IndexSet([
                      SectionTypeAppointment.calendar.rawValue,
                      SectionTypeAppointment.hours.rawValue
                  ])
              )

          } catch {
              self.isLoadingAvailability = false
              self.showScheduleError(error.localizedDescription)
          }
      }
  }

  private func formatHour(_ date: Date) -> String {

      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "es_CO")
      formatter.timeZone = colombiaTimeZone
      formatter.dateFormat = "h:mm a"

      return formatter.string(from: date)
  }

  private func showScheduleError(_ message: String) {

      let alert = UIAlertController(
          title: "Disponibilidad",
          message: message,
          preferredStyle: .alert
      )

      alert.addAction(
          UIAlertAction(title: "Aceptar", style: .default)
      )

      present(alert, animated: true)
  }
  
}

extension AppointmentScheduleCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionTypeAppointment.allCases.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let section = SectionTypeAppointment(rawValue: section) else { return 0 }
    
    switch section {
    case .calendar:
      return 1
    case .hours:
      return availableSlots.count
    case .modality:
      return 1
    case .continueBtn:
      return 1
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let section = SectionTypeAppointment(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .calendar:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
          return UICollectionViewCell()
      }

      cell.delegate = self

      cell.configure(
          month: displayedMonth,
          selectedDate: selectedDate,
          dayStates: dayStates
      )

      return cell
      
    case .hours:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoursCollectionViewCell.identifier,for: indexPath) as? HoursCollectionViewCell else {
          return UICollectionViewCell()
      }

      let slot = availableSlots[indexPath.item]

      cell.configure(
          hour: formatHour(slot.startTime),
          isAvailable: true,
          isSelected: selectedSlot?.startTime == slot.startTime
      )

      return cell
      
    case .modality:
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModalityCollectionViewCell.identifier, for: indexPath) as? ModalityCollectionViewCell else {
          return UICollectionViewCell()
      }

      cell.delegate = self
      cell.configure(selected: selectedModality)

      return cell
    
    case .continueBtn:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueButtonCollectionViewCell.identifier, for: indexPath) as? ContinueButtonCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: Utilities().titleBtn)
      cell.delegate = self
      return cell
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard indexPath.section == SectionTypeAppointment.hours.rawValue,
          availableSlots.indices.contains(indexPath.item) else {
        return
    }

    selectedSlot = availableSlots[indexPath.item]

    collectionView.reloadSections(
        IndexSet(integer: SectionTypeAppointment.hours.rawValue)
    )
  }
  
  
}

extension AppointmentScheduleCollectionViewController: CalendarCollectionViewCellDelegate {

    func calendar(cell: CalendarCollectionViewCell, didSelect date: DateComponents?) {

        selectedDate = date
        selectedSlot = nil
        availableSlots = []

        collectionView.reloadSections(
            IndexSet(integer: SectionTypeAppointment.hours.rawValue)
        )

        guard let date = date else { return }

        let dateString = String(
            format: "%04d-%02d-%02d",
            date.year ?? 0,
            date.month ?? 0,
            date.day ?? 0
        )

        loadAvailability(for: dateString)
    }

    func calendar(cell: CalendarCollectionViewCell,didChangeMonth date: Date) {

        displayedMonth = date

        // Aquí consultaremos las fechas disponibles del mes.
        // El endpoint actual devuelve disponibilidad por día.
    }
}

extension AppointmentScheduleCollectionViewController: ModalityCollectionViewCellDelegate {

    func modalityCell(_ cell: ModalityCollectionViewCell,didSelect modality: AppointmentModality) {

        selectedModality = modality

        collectionView.reloadSections(
            IndexSet(integer: SectionTypeAppointment.modality.rawValue)
        )
    }
}


extension AppointmentScheduleCollectionViewController: ContinueButtonCollectionViewCellDelegate {

    func onContinueBtnTapped() {

        guard selectedDate != nil else {
            showScheduleError("Selecciona una fecha.")
            return
        }

        guard let slot = selectedSlot else {
            showScheduleError("Selecciona una hora disponible.")
            return
        }

        guard let modality = selectedModality else {
            showScheduleError("Selecciona una modalidad.")
            return
        }

        print("Inicio UTC:", slot.startTime)
        print("Final UTC:", slot.endTime)
        print("Modalidad:", modality.rawValue)

        // Siguiente integración:
        // POST /appointments/
        // Guardar id_appointment en BookingCoordinator.
        // Abrir PaymentSummary.
    }
}
