//
//  MainCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/7/26.
//

import UIKit

@MainActor
class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    // MARK: - PANTALLA DE BIENVENIDA

    func start() {

        let welcomeVC = WelcomeViewController()

        welcomeVC.mainCoordinator = self

        navigationController?.setViewControllers(
            [welcomeVC],
            animated: false
        )
    }

    // MARK: - INICIAR SESIÓN

    func goToLogin() {

        let loginVC = LoginCollectionViewController()

        loginVC.delegate = self

        navigationController?.pushViewController(
            loginVC,
            animated: true
        )
    }

    // MARK: - NAVEGACIÓN SEGÚN EL PERFIL

    func switchToFlow(
        for userType: UserType,
        userID: Int? = nil
    ) {

        guard let userID = userID else {
            print("Error: no se recibió el ID del usuario.")
            return
        }

        guard let window = getMainWindow() else {
            print("Error: no se encontró la ventana principal.")
            return
        }

        childCoordinators.removeAll()

        let configureTabBar: MainTabBarItemNavigationController?

        switch userType {

        case .client:

            let clientTabBarCoordinator =
                MainClientTabBarCoordinator(
                    navigationController: navigationController
                        ?? UINavigationController(),
                    userID: userID
                )

            clientTabBarCoordinator.parentCoordinator = self

            childCoordinators.append(clientTabBarCoordinator)

            clientTabBarCoordinator.start()

            configureTabBar =
                clientTabBarCoordinator.tabBarController

        case .lawyer:

            let lawyerTabBarCoordinator =
                MainLawyerTabBarCoordinator(
                    navigationController: navigationController
                        ?? UINavigationController(),
                    userID: userID
                )

            lawyerTabBarCoordinator.parentCoordinator = self

            childCoordinators.append(lawyerTabBarCoordinator)

            lawyerTabBarCoordinator.start()

            configureTabBar =
                lawyerTabBarCoordinator.tabBarController
        }

        guard let tabBarToPresent = configureTabBar else {
            return
        }

        window.rootViewController = tabBarToPresent

        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }

    // MARK: - CERRAR SESIÓN

    func logout() {

        guard let window = getMainWindow() else {
            print("Error: no se encontró la ventana principal.")
            return
        }

        // Eliminar los perfiles y tokens de la memoria
        SessionManager.shared.logout()

        // Liberar los coordinadores del flujo anterior
        childCoordinators.removeAll()

        // Crear una nueva pantalla de login
        let loginVC = LoginCollectionViewController()

        loginVC.delegate = self

        // Crear una nueva navegación
        let newNavigationController = UINavigationController(
            rootViewController: loginVC
        )

        navigationController = newNavigationController

        // Establecer el login como nueva raíz
        window.rootViewController = newNavigationController

        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }

    // MARK: - OBTENER VENTANA PRINCIPAL

    private func getMainWindow() -> UIWindow? {

        if let window = navigationController?.viewIfLoaded?.window {
            return window
        }

        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}

// MARK: - LOGIN DELEGATE

extension AppCoordinator: LoginCollectionViewControllerDelegate {

    func loginDidFinish(
        with profile: AuthenticatedProfileModel
    ) {

        switch profile.user.accountType {

        case "client":

            switchToFlow(
                for: .client,
                userID: profile.user.id
            )

        case "lawyer":

            switchToFlow(
                for: .lawyer,
                userID: profile.user.id
            )

        default:

            SessionManager.shared.logout()

            print("Error: tipo de cuenta desconocido.")
        }
    }
}
