//
//  ContactsServicePermissions.swift
//  SKUtilsSwift
//
//  Created by Sergey Kostyan on 01.10.16.
//  Copyright © 2016 Sergey Kostyan. All rights reserved.
//

import UIKit
import Contacts
import AddressBook

public protocol ContactsPermissions {
    
    typealias PermissionsState = CNAuthorizationStatus
    
    func requestPermissions(handler: @escaping (PermissionsState) -> Void)
    func permissionsState() -> PermissionsState
    
}

open class DefaultContactsPermissions: ContactsPermissions {
    
    public init() {}
    
    public func requestPermissions(handler: @escaping (PermissionsState) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { _, _ in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                handler(self.permissionsState())
            }
        }
    }
    
    public func permissionsState() -> PermissionsState {
        return CNContactStore.authorizationStatus(for: .contacts)
    }
    
}
