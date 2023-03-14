//
//  Constants.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

class AppState: ObservableObject {
    @AppStorage("demoloop on") var demoloopon: Bool = false
    @AppStorage("button text") var ButtonText: String = ("Restore DemoLoop")
    @AppStorage("selected theme") var selectedtheme: String = ("Pommes")
    @AppStorage("custom app id") var customappid: Bool = false
    @AppStorage("app id string") var appidstring: String = ("")
    @AppStorage("lario trolled") var lariotheme: Bool = false
    var operationStatusSymbol = ("ellipsis")
}
