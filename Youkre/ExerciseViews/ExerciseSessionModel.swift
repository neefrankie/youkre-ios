//
//  ExerciseSessionModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/12.
//

import SwiftUI

struct SessionState {
   
    var states: [String: ExerciseProgress] = [:]
    
    mutating func markAnswered(id: String, correct: Bool, answer: Int) {
        if let current = states[id] {
            states[id]?.answered(correct: correct, selectedIndex: answer)
        } else {
            var ex = ExerciseProgress.new(exerciseID: id)
            ex.answered(correct: correct, selectedIndex: answer)
            states[id] = ex
        }
    }
    
    mutating func skip(id: String) {
        states[id] = ExerciseProgress.new(exerciseID: id)
    }
    
    mutating func add(id: String, newState: ExerciseProgress) {
        states[id] = newState
    }
    
    func state(for id: String) -> ExerciseProgress {
        // By default we assume all questions are skipped.
        states[id] ?? ExerciseProgress.new(exerciseID: id)
    }
    
    func score(for exercises: [ExerciseV2]) -> Int {
        exercises.reduce(0) { total, ex in
            if states[ex.id]?.isCorrect == true {
                return total + 1
            } else {
                return total
            }
        }
    }
    
    mutating func reset() {
        states = [:]
    }
}

class ExerciseSessionModel: ObservableObject {
    
    @Published var selectedCourse: CourseKind {
        didSet {
            print("Course changed: \(selectedCourse)")
            switchCourse(course: selectedCourse)
        }
    }
    
    @Published var currentIndex: Int = 0 {
        didSet {
            print("Current index changed \(currentIndex)")
            finished = false
        }
    }
    @Published var session: SessionState = SessionState()
    @Published var exercises: [ExerciseV2]
    @Published var finished: Bool = false
    
    var progressText: String {
        "\(currentIndex + 1) / \(exercises.count)"
    }
    
    var score: Int {
        session.score(for: exercises)
    }
    
    var hasIncorrect: Bool {
        exercises.filter {
            !session.state(for: $0.id).isCorrect
        }.count > 0
    }
    
    private var currentExercise: ExerciseV2? {
        guard currentIndex >= 0, currentIndex < exercises.count else {
            return nil
        }
        return exercises[currentIndex]
    }
    
    private var currentState: ExerciseProgress? {
        if let id = currentExercise?.id {
            return session.state(for: id)
        }
        
        return nil
    }
    
    init() {
        print("Initializing exercise session model")
        let course = CourseSettings.selectedCourse
        self.exercises = LevelData.cme[0].exercises
        // 这里似乎不会触发 didSet
        self.selectedCourse = course
        print("Couse initialized \(self.selectedCourse)")
    }
    
    func switchCourse(course: CourseKind) {
        print("Resetting exercise and state")
        CourseSettings.selectedCourse = selectedCourse
//        You must reset currentIndex = 0 before updating exercises.
        currentIndex = 0
        session.reset()
//        to be extra safe, you can wrap it with DispatchQueue.main.async to ensure the reset happens after layout:
        DispatchQueue.main.async {
            self.exercises = LevelData.cme[0].exercises
        }
        
    }
    
    func reset() {
        print("Resetting ...")
        currentIndex = 0
        session.reset()
        
        print("Now current index \(currentIndex)")
    }
    
    func restart() {
        print("Restarting all exercises...")
        let course = CourseSettings.selectedCourse
        switchCourse(course: course)
    }
    
    func retryIncorrectOnly() {
        let incorrect = exercises.filter {
            !session.state(for: $0.id).isCorrect
        }
        
        currentIndex = 0
        session.reset()
        
        DispatchQueue.main.async {
            self.exercises = incorrect
        }
    }
    
    func next() {
        print("Current index \(currentIndex)")
        if let completed = currentState?.isCompleted, !completed {
            skipCurrent()
        }
        if currentIndex < exercises.count - 1 {
            currentIndex += 1
            finished = false
        } else {
            // 到了最后一个tab，需要多点击一次才能显示总结。
            finished = true
        }
        print("Progressed to \(currentIndex)")
    }
    
    func binding(for exerciseID: String) -> Binding<ExerciseProgress> {
        Binding(
            get: {
                self.session.state(for: exerciseID)
            },
            set: {
                self.session.add(id: exerciseID, newState: $0)
            }
        )
    }
    
    private func submitAnswer(correct: Bool, answer: Int) {
        guard let id = currentExercise?.id else { return }
        session.markAnswered(
            id: id,
            correct: correct,
            answer: answer
        )
    }
    
    private func skipCurrent() {
        guard let id = currentExercise?.id else {
            return
        }
        
        session.skip(id: id)
    }
}


