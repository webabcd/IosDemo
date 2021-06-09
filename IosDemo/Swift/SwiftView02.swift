//
//  Swift02View.swift
//  IosDemo
//
//  Created by 王磊 on 2021/6/9.
//

import SwiftUI

struct SwiftView02: View {
    
    var result: String = "";
    
    init() {
        
        
        
        result = sample1();
        result += "\n";
        result += sample2();
        result += "\n";
        result += sample3();
        result += "\n";
        result += sample4();
    }

    var body: some View {
        Text(result);
    }
    
    func sample1() -> String {
        return "";
    }

    func sample2() -> String {
        return "";
    }

    func sample3() -> String {
        return "";
    }

    func sample4() -> String {
        return "";
    }
}


