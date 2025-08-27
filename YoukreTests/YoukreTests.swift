//
//  YoukreTests.swift
//  YoukreTests
//
//  Created by Weiguo Ni on 2025/3/8.
//

import Testing
import Foundation
@testable import Youkre

struct YoukreTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let courses = try await ExerciseDataSource.shared.loadCourse()
        #expect(courses.count > 0)
    }

    @Test func decodeMultipleChoice() throws {
        let rawJson = """
{"choices": ["𝑑 乘以 𝑥", "𝑥 的微小部分", "一个函数", "函数在 𝑥 点的值"], "correct_index": 1, "is_latex": false}
"""
        let decoder = JSONDecoder()
        guard let data = rawJson.data(using: .utf8) else {
            return
        }
        
        let multipleChoice: MultipleChoice = try decoder.decode(MultipleChoice.self, from: data)
        print(multipleChoice)
    }
    
    @Test
    func decodePrompts() throws {
        let rawJson = """
[{"kind": "text", "value": "𝑑𝑥 在微积分中表示什么？", "table": null}]
"""
        let decoder = JSONDecoder()
        guard let data = rawJson.data(using: .utf8) else {
            return
        }
        
        let prompts = try decoder.decode([PromptBlock].self, from: data)
        print(prompts)
    }
}
