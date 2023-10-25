//
//  JumpingBookIcon.swift
//  LuBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//

import SwiftUI

struct JumpingBookIcon: View {
    @State private var isJumping = false

    var body: some View {
        Image(systemName: "book.fill")
            .font(.largeTitle)
            .rotationEffect(.degrees(isJumping ? 0 : -360))
            .animation(Animation.easeOut(duration: 0.5).repeatCount(1))
            .onAppear {
                self.isJumping.toggle()
            }
    }
}



