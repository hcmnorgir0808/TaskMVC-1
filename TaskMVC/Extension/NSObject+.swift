//
//  NSObject+.swift
//  TaskMVC
//
//  Created by 岩本康孝 on 2021/05/02.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
