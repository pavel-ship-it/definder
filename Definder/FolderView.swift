//
//  ContentView.swift
//  Definder
//
//  Created by Pavel Yakimenko on 29/06/2022.
//

import SwiftUI

struct ListableFile: Identifiable, Hashable {

    let icon: Image
    let id: UUID
    let title: String
    let attributes: [FileAttributeKey : Any]
    let path: URL

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(_ root: URL,
         _ item: String,
         _ fileManager: FileManager = FileManager.default,
         _ iconService: IconService = IconService.default) {
        if item != ".." {
            path = root.appendingPathComponent(item)
        }
        else {
            path = root.deletingLastPathComponent()
        }
        id = UUID()
        title = item
        attributes = try! fileManager.attributesOfItem(atPath: String(path.absoluteString.dropFirst(7)))
        icon = iconService.icon(attributes[FileAttributeKey.type] as? FileAttributeType)
//        print(title, attributes)
    }

    static func == (lhs: ListableFile, rhs: ListableFile) -> Bool {
        lhs.path == rhs.path
    }
}

struct FolderView: View {
    let fileManager = FileManager.default
    
    @State private var path: URL = FileManager.default.homeDirectoryForCurrentUser
    @State private var selection = Set<ListableFile>()
    @State private var listOfFiles = [ListableFile]()

    func refreshFiles() {
        var items = try! fileManager.contentsOfDirectory(atPath: String(path.absoluteString.dropFirst(7))).map { ListableFile(path, $0, fileManager) }
        if path.absoluteString != "/" {
            items.insert(ListableFile(path, ".."), at: 0)
        }
        listOfFiles = items
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if selection.count == 0,
               let first = listOfFiles.first {
                selection.insert(first)
            }
        }
    }
    
    var body: some View {
        VStack {
            PathView(path: path, pathAction: openDir)
            List(listOfFiles, id: \.self, selection: $selection) { item in
                HStack {
                    item.icon
                    Text(item.title)
                }
                .onTapGesture(count:2) { //<- Needed to be first!
                    selection.removeAll()
                    selection.insert(item)
                    path = item.path
                }
            }
        }
        .onAppear {
            refreshFiles()
        }
    }
    
    func openDir(_ path: URL) {
        self.path = path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
