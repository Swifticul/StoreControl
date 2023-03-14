//
//  DemoUpdateSetup.swift
//  StoreControl
//
//  Created by Tristan on 04/03/2023.
//

import SwiftUI
import UIKit
import WebKit

let deviceName = UIDevice.current.name

struct DemoUpdateSetup: View {
    @State private var isPresented = false
    @State var showSuccess = false
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    VStack(spacing: 25) {
                        Spacer()
                            .frame(maxHeight: 10)
                        Image("ProfileInstallerIconInApp")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                            .clipped()
                            .shadow(color: .blue.opacity(0.38), radius: 18, x: 0, y: 12)
                        Text("Provisioning \(deviceName)")
                            .font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .frame(width: 350)
                        Text("In order to install DemoLoop authentically, you will need to install the Apple Partner Demo Profile.")
                            .font(.subheadline.weight(.regular))
                            .frame(width: 340)
                            .clipped()
                            .multilineTextAlignment(.center)
                        Button("Installation Instructions") {
                            isPresented = true
                        }
                        .buttonStyle(TintedButton(color: .blue, fullwidth: true))
                        .frame(maxWidth: 350)
                        .sheet(isPresented: $isPresented) {
                            WebView(url: "https://github.com/Swifticul/StoreControl/blob/main/Documentation/provisioning.md#requirements")
                        }
                        Spacer()
                            .frame(maxHeight: 25)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack(spacing: 25) {
                        Image("DemoLoopIcon")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                            .clipped()
                            .shadow(color: .accentColor.opacity(0.38), radius: 18, x: 0, y: 12)
                        Text("Installing DemoLoop")
                            .font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                            .frame(width: 350)
                        Text("Installing DemoLoop can be performed in StoreControl if the Apple Partner Demo Profile has been installed.")
                            .font(.subheadline.weight(.regular))
                            .frame(width: 340)
                            .clipped()
                            .multilineTextAlignment(.center)
                        Button("Install Demo Update") {
                            if let url = URL(string: "itms-services://?action=download-manifest&url=https://demoupdate.apple.com/install/6.1.2/demoupdate.plist") {
                                UIApplication.shared.open(url)
                            }
                        }
                        .buttonStyle(TintedButton(color: .blue, fullwidth: true))
                        .frame(maxWidth: 350)
                        Spacer()
                            .frame(maxHeight: 10)
                        NavigationLink(
                            destination: ThemeSelectorUI(),
                            label: {
                                Text("Continue to Themes")
                            }
                        )
                        Spacer()
                            .frame(maxHeight: 10)
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
            }
        }
        .navigationTitle("Provision & Install")
    }
}
    
struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: self.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
    
struct DemoUpdateSetup_Previews: PreviewProvider {
    static var previews: some View {
        DemoUpdateSetup()
    }
}
