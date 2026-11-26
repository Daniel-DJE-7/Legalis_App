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
  var clientId: Int?

  private var isCreatingAppointment = false

  private var registeredAppointment: AppointmentResponseModel?
  private var selectedSlot: LawyerAvailableSlotModel?
  private var selectedModality: AppointmentModality?

  private var displayedMonth = Date()

  private var dayStates: [String: CalendarDayState] = [:]
  private var availableSlots: [LawyerAvailableSlotModel] = []

  private var isLoadingAvailability = false

  private let colombiaTimeZone = TimeZone(identifier: "America/Bogota")!
  
  private var lawyerSchedules: [LawyerScheduleModel] = []

  private var isLoadingSchedules = false

  private var requestedAvailabilityDate: String?

  private var bookingCalendar: Calendar {
      var calendar = Calendar(identifier: .gregorian)
      calendar.timeZone = colombiaTimeZone
      calendar.firstWeekday = 2
      calendar.minimumDaysInFirstWeek = 4
      return calendar
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.backgroundColor = .systemGray6
      navigationItem.title = "Citas"
      navigationController?.navigationBar.prefersLargeTitles = true
      navigationItem.largeTitleDisplayMode = .always
      navigationController?.navigationBar.topItem?.backButtonTitle = "Volver"
      registerCells()
      configureLayout()
      loadLawyerSchedules()
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

  
  private func loadLawyerSchedules() {

      guard lawyerId > 0 else {
          showScheduleError("No se encontró el abogado.")
          return
      }

      isLoadingSchedules = true
      dayStates = [:]

      Task { @MainActor [weak self] in

          guard let self = self else { return }

          do {
              let schedules = try await APICaller.shared.getLawyerSchedules(
                  lawyerId: self.lawyerId
              )

              self.lawyerSchedules = schedules
              self.isLoadingSchedules = false

              self.updateCalendarDays()

          } catch {
              self.isLoadingSchedules = false
              self.showScheduleError(error.localizedDescription)
          }
      }
  }

  // MARK: - Actualizar días disponibles del calendario
  private func updateCalendarDays() {

      let calendar = bookingCalendar
      let today = calendar.startOfDay(for: Date())

      // Obtener la semana actual
      guard let currentWeek = calendar.dateInterval(of: .weekOfYear, for: today) else {
          return
      }

      // Permitir reservas durante la semana actual y la siguiente semana
      guard let bookingEnd = calendar.date(byAdding: .day, value: 14, to: currentWeek.start) else {
          return
      }

      // Obtener los días que tienen horas registradas
      let workingDays = Set(
          lawyerSchedules
              .filter { !$0.hours.isEmpty }
              .map { $0.weekday }
      )

      var states: [String: CalendarDayState] = [:]

      var date = today

      while date < bookingEnd {

          // UIKit: domingo = 1, sábado = 7
          let calendarWeekday = calendar.component(.weekday, from: date)

          // FastAPI: lunes = 0, domingo = 6
          let backendWeekday = (calendarWeekday + 5) % 7

          let components = calendar.dateComponents([.year, .month, .day], from: date)

          let key = String(
              format: "%04d-%02d-%02d",
              components.year ?? 0,
              components.month ?? 0,
              components.day ?? 0
          )

          // Habilitar únicamente días con horarios registrados
          states[key] = workingDays.contains(backendWeekday) ? .available : .unavailable

          guard let nextDate = calendar.date(byAdding: .day, value: 1, to: date) else {
              break
          }

          date = nextDate

      }

      dayStates = states

      collectionView.reloadSections(
          IndexSet(
              integer: SectionTypeAppointment.calendar.rawValue
          )
      )

  }
  

  private func loadAvailability(for date: String) {

    guard case .available? = dayStates[date] else {
        return
    }
    
    guard lawyerId > 0 else {
        showScheduleError("No se encontró el abogado.")
        return
    }

      requestedAvailabilityDate = date
      isLoadingAvailability = true

      Task { @MainActor [weak self] in

          guard let self = self else { return }

          do {
              let response = try await APICaller.shared.getLawyerAvailability(
                  lawyerId: self.lawyerId,
                  date: date
              )

              // Ignorar respuestas de fechas seleccionadas anteriormente.
              guard self.requestedAvailabilityDate == date else {
                  return
              }

              self.isLoadingAvailability = false

              let now = Date()

              self.availableSlots = response.availableSlots
                  .filter { $0.startTime > now }
                  .sorted { $0.startTime < $1.startTime }

              if self.availableSlots.isEmpty {

                  self.dayStates[date] = .unavailable
                  self.selectedDate = nil
                  self.selectedSlot = nil

                  self.showScheduleError(
                      "No hay horarios disponibles para esta fecha."
                  )

              } else {
                  self.dayStates[date] = .available
              }

              self.collectionView.reloadSections(
                  IndexSet([
                      SectionTypeAppointment.calendar.rawValue,
                      SectionTypeAppointment.hours.rawValue
                  ])
              )

          } catch {

              guard self.requestedAvailabilityDate == date else {
                  return
              }

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
  
  // MARK: - Restablecer interfaz después del registro
  @MainActor
  private func finishCreatingAppointment() {

      isCreatingAppointment = false

      navigationItem.hidesBackButton = false

      navigationController?
          .interactivePopGestureRecognizer?.isEnabled = true

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
    guard !isLoadingAvailability,
          !isCreatingAppointment,
          registeredAppointment == nil else {
        return
    }
    
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

    guard !isLoadingSchedules,
          !isCreatingAppointment,
          registeredAppointment == nil else {
        return
    }

      guard let date = date else { return }

      let dateString = String(
          format: "%04d-%02d-%02d",
          date.year ?? 0,
          date.month ?? 0,
          date.day ?? 0
      )

      // Solo permitir fechas habilitadas.
      guard case .available? = dayStates[dateString] else {
          return
      }

      selectedDate = date
      selectedSlot = nil
      availableSlots = []

      collectionView.reloadSections(
          IndexSet(integer: SectionTypeAppointment.hours.rawValue)
      )

      loadAvailability(for: dateString)
  }

  func calendar(cell: CalendarCollectionViewCell, didChangeMonth date: Date) {

      displayedMonth = date

      // No necesitamos consultar un endpoint mensual.
      // Los estados se calcularon a partir del horario semanal.
  }

}

extension AppointmentScheduleCollectionViewController: ModalityCollectionViewCellDelegate {

    func modalityCell(_ cell: ModalityCollectionViewCell,didSelect modality: AppointmentModality) {
      guard !isCreatingAppointment,
            registeredAppointment == nil else {
          return
      }
      selectedModality = modality
      collectionView.reloadSections(IndexSet(integer: SectionTypeAppointment.modality.rawValue))
    }
}


// MARK: - Registrar cita y continuar al pago
extension AppointmentScheduleCollectionViewController: ContinueButtonCollectionViewCellDelegate {

    func onContinueBtnTapped() {

        // Evitar solicitudes simultáneas
        guard !isCreatingAppointment else {
            return
        }

        guard let coordinator = coordinator else {
            showScheduleError("No se encontró el coordinador.")
            return
        }

        // Si la cita ya fue creada, volver al resumen sin registrar una segunda cita.
        if let appointment = registeredAppointment {
            coordinator.didCreateAppointment(appointment)
            return
        }

        guard !isLoadingSchedules, !isLoadingAvailability else {
            showScheduleError( "Espera a que termine la consulta de disponibilidad.")
            return
        }

        guard lawyerId > 0 else {
            showScheduleError("No se encontró el abogado.")
            return
        }

        guard let clientId = clientId, clientId > 0 else {
            showScheduleError("No se encontró el identificador del cliente.")
            return
        }

        guard selectedDate != nil else {
            showScheduleError("Selecciona una fecha.")
            return
        }

        guard let slot = selectedSlot else {
            showScheduleError("Selecciona una hora disponible.")
            return
        }

        guard slot.startTime > Date() else {
            selectedSlot = nil
            collectionView.reloadSections(IndexSet(integer: SectionTypeAppointment.hours.rawValue))

            showScheduleError("La hora seleccionada ya no está disponible.")
            return
        }

        guard let modality = selectedModality else {
            showScheduleError("Selecciona una modalidad.")
            return
        }

        // Construir la solicitud para FastAPI

        let appointment = AppointmentCreateModel(
            startTime: slot.startTime,
            durationHours: 1,
            modality: modality.rawValue,
            idLawyer: lawyerId,
            idClient: clientId
        )

        isCreatingAppointment = true

        navigationItem.hidesBackButton = true

        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

      // Registrar la cita en PostgreSQL
      Task { @MainActor [weak self] in

          guard let self = self else {
              return
          }

          do {

              let response = try await APICaller.shared.createAppointment(
                  appointment: appointment
              )

              // Conservar la cita para evitar duplicados
              self.registeredAppointment = response

              print("Cita registrada:", response.idAppointment)
              print("Precio total:", response.price)
              print("Estado:", response.appointmentStatus)

              // Restablecer la interfaz
              self.finishCreatingAppointment()

              // Guardar la cita y abrir el resumen de pago
              coordinator.didCreateAppointment(response)

          } catch {

              // Restablecer la interfaz si ocurre un error
              self.finishCreatingAppointment()

              self.showScheduleError(
                  error.localizedDescription
              )

          }

      }

    }

}
