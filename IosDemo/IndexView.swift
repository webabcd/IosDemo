//
//  IndexView.swift
//  IosDemo
//
//  Created by 王磊 on 2021/6/15.
//

import SwiftUI

struct IndexView: View {
    
   
    
    var body: some View {
        let siteMap: [SiteMap] = load("site_map.json")

        List {
            ForEach(siteMap, id: \.self) { parent in
                Section(header: Text("\(parent.title)")) {
                    ForEach(parent.items, id: \.self) { child in
             
                        Row(name: child.title)
                    }
                }
            }
        }
    }
    
    struct Row: View {
        @State private var xxx = false
        
        var name: String
        
        var body: some View {
            Button("\(name)") {
                self.xxx = true
            }.sheet(isPresented: $xxx) {
                SwiftView01()
            }
        }
    }
    
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    
    struct SiteMap: Hashable, Codable {
        var title: String
        var items: [Item]
    }
    
    struct Item: Hashable, Codable {
        var title: String
        var url: String
    }
}
