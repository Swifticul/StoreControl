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
        VStack(spacing: 25) {
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
            } .buttonStyle(ButtonFromInteractfulROFL()) .frame(maxWidth: 350) .sheet(isPresented: $isPresented) {
                WebView(url: "https://github.com/Swifticul/StoreControl/blob/main/Documentation/provisioning.md#requirements")
            }
            NavigationLink(destination: DemoUpdateInstallerStep2()) {
                Text("Skip & Continue")
            }
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
}
