//
//  BundleExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

extension Bundle {

    static var version: String? { return main.infoDictionary?["CFBundleShortVersionString"] as? String }
}
