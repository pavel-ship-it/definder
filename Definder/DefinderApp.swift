//
//  DefinderApp.swift
//  Definder
//
//  Created by Pavel Yakimenko on 29/06/2022.
//

import SwiftUI

@main
struct DefinderApp: App {
    var body: some Scene {
        WindowGroup {
            DefinderAppView()
        }
    }
}

struct DefinderAppView: View {
    var body: some View {
        HStack {
            FolderView()
        }
    }
}

struct DefinderAppView_Previews: PreviewProvider {
    static var previews: some View {
        DefinderAppView()
    }
}
