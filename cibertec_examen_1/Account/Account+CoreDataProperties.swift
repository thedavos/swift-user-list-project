//
//  Account+CoreDataProperties.swift
//  cibertec_examen_1
//
//  Created by Global66 on 2/10/21.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var amount: Double
    @NSManaged public var openingDate: Date?
    @NSManaged public var name: String?

}

extension Account : Identifiable {

}
