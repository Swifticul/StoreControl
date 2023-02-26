//
//  RootView.swift
//  StoreControl
//
//  Created by Tristan on 25/02/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("DemoLoop Enabled?") private var demoloopon = false
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Version \(appVersion ?? "AppVersion") - MDC and TCCD exploits by Ian Beer & zhuowei")
                }
                Section {
                    NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                        Text("Enable DemoLoop")
                    }
                } footer: {
                    Text("You might need to approve the sandbox escape if this is the first time you're running StoreControl.")
                }
                Button("Change DemoLoop Icon") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                } .disabled(demoloopon == false)
            } .navigationTitle("StoreControl")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
