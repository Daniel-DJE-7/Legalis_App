//
//  SessionManager.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 25/11/26.
//

import Foundation

@MainActor
final class SessionManager {

    static let shared = SessionManager()

    private init() {}

    // MARK: - PERFILES AUTENTICADOS

    private(set) var profiles: [AuthenticatedProfileModel] = []

    private(set) var activeProfile: AuthenticatedProfileModel?

    // MARK: - USUARIO ACTUAL

    var currentUser: UserModel? {
        activeProfile?.user
    }

    var accessToken: String? {
        activeProfile?.accessToken
    }

    var clientId: Int? {

        guard let user = currentUser,
              user.accountType == "client" else {
            return nil
        }

        return user.id
    }

    var lawyerId: Int? {

        guard let user = currentUser,
              user.accountType == "lawyer" else {
            return nil
        }

        return user.id
    }

    var isAuthenticated: Bool {
        activeProfile != nil
    }

    var hasMultipleProfiles: Bool {
        profiles.count > 1
    }

    // MARK: - INICIAR SESIÓN

    func startSession(with response: LoginResponseModel) {

        profiles = response.profiles

        activeProfile = nil

        if profiles.count == 1 {
            activeProfile = profiles.first
        }
    }

    // MARK: - CAMBIAR PERFIL

    @discardableResult
    func selectProfile(userId: Int) -> Bool {

        guard let profile = profiles.first(
            where: { $0.user.id == userId }
        ) else {
            return false
        }

        activeProfile = profile

        return true
    }

    // MARK: - CERRAR SESIÓN GLOBAL

    func logout() {

        activeProfile = nil

        profiles.removeAll()
    }
}
