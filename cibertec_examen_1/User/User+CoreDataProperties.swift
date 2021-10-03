//
//  User+CoreDataProperties.swift
//  cibertec_examen_1
//
//  Created by Global66 on 2/10/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int16
    @NSManaged public var lastName: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var account: Account?

}

extension User : Identifiable {

}
