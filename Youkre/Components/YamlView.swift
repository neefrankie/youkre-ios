//
//  YamlView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/13.
//

import SwiftUI

struct YamlView: View {
    var body: some View {
        List {
            Section("CME") {
                ForEach(ExampleData.cmeLevels) { level in
                    Button(level.id) {
                        print(level.yaml())
                    }
                }
            }
            
            Section("Algebra") {
                ForEach(ExampleData.algebra) { level in
                    Button(level.id) {
                        print(level.yaml())
                    }
                }
            }
            
            Section("Probability") {
                ForEach(ExampleData.stats) { level in
                    Button(level.id) {
                        print(level.yaml())
                    }
                }
            }
            
            Section("Trigonometry") {
                ForEach(ExampleData.trignometry) { level in
                    Button(level.id) {
                        print(level.yaml())
                    }
                }
            }
            
            Section("Test DB") {
                Button("Load Courses") {
                    Task {
                        print("Loading courses")
                        let courses = try await ExerciseDataSource.shared.loadCourse()
                        for course in courses {
                            print("id: \(course.id), slug: \(course.slug)")
                        }
                    }
                }
                
                Button("Load Levels") {
                    Task {
                        let courses = try await ExerciseDataSource.shared.loadCourse()
                        
                        let levels = try await ExerciseDataSource.shared.loadLevels(for: courses[0])
                        print("Levels of \(courses[0].slug)")
                        for level in levels {
                            print("id: \(level.id), index: \(level.index)")
                        }
                    }
                }
                
                Button("Load Exercies") {
                    Task {
                        let courses = try await ExerciseDataSource.shared.loadCourse()
                        
                        
                        let levels = try await ExerciseDataSource.shared.loadLevels(for: courses[0])
                        
                        if levels.count == 0 {
                            print("No exercise loaded")
                            return
                        }
                        
                        let exercises = try await ExerciseDataSource.shared.loadExercises(for: courses[0], level: levels[0])
                        print(exercises)
                    }
                }
            }
            
            Section("JSON") {
                Button("Decode Prompts") {
                    let rawJson = """
            [{"kind": "text", "value": "𝑑𝑥 在微积分中表示什么？", "table": null}]
            """
                    let decoder = JSONDecoder()
                    guard let data = rawJson.data(using: .utf8) else {
                        return
                    }
                    
                    do {
                        let prompts = try decoder.decode([PromptBlock].self, from: data)
                        print(prompts)
                    } catch {
                        print(error)
                    }
                }
                
                Button("Decode multiple choice") {
                    let rawJson = """
            {"choices": ["𝑑 乘以 𝑥", "𝑥 的微小部分", "一个函数", "函数在 𝑥 点的值"], "correct_index": 1, "is_latex": false}
            """
                    let decoder = JSONDecoder()
                    guard let data = rawJson.data(using: .utf8) else {
                        return
                    }
                    
                    do {
                        let multipleChoice: MultipleChoice = try decoder.decode(MultipleChoice.self, from: data)
                        print(multipleChoice)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
    }
    
    
}

#Preview {
    YamlView()
}
