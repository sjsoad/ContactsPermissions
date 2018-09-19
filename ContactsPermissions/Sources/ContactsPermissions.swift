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
import SKServicePermissions

open class ContactsPermissions: NSObject, ServicePermissions {

    public typealias PermissionsState = CNAuthorizationStatus
    
    public func requestPermissions(handler: @escaping (PermissionsState) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { [weak self] _, _ in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                handler(self.permissionsState())
            }
        }
    }
    
    public func permissionsState() -> PermissionsState {
        return CNContactStore.authorizationStatus(for: .contacts)
    }
    
}
