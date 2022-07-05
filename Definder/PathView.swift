//
//  PathView.swift
//  Definder
//
//  Created by Pavel Yakimenko on 30/06/2022.
//

import SwiftUI

struct PathView: View {
    @State var path: URL
    let pathAction: (URL) -> ()
    
    func pathElements() -> [(String, URL)] {
        if path.isFileURL {
            var pathComponents = [(String, URL)]()
            var decomposedPath = path
            repeat {
                decomposedPath = decomposedPath.deletingLastPathComponent()
                pathComponents.append((decomposedPath.lastPathComponent, decomposedPath))
            } while decomposedPath.lastPathComponent != "/"
            return pathComponents.reversed()
        }
        return [(path.absoluteString, path)]
    }

    var body: some View {
        HStack{
            ForEach(pathElements(), id: \.self.0) { pathElement in
                Text(">")
                Button(pathElement.0) {
                    pathAction(pathElement.1)
                }
            }
        }
    }
}

struct PathView_Previews: PreviewProvider {
    static var previews: some View {
        PathView(path: FileManager.default.homeDirectoryForCurrentUser) { _ in
        }
    }
}
