//
//  ExerciseSessionModel.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/12.
//

import SwiftUI

struct SessionState {
   
    var states: [String: ExerciseState] = [:]
    
    mutating func markAnswered(id: String, correct: Bool, answer: AnswerData) {
        states[id] = ExerciseState.answered(correct: correct, answer: answer)
    }
    
    mutating func skip(id: String) {
        states[id] = ExerciseState.skipped()
    }
    
    mutating func add(id: String, newState: ExerciseState) {
        states[id] = newState
    }
    
    func state(for id: String) -> ExerciseState {
        // By default we assume all questions are skipped.
        states[id] ?? ExerciseState.skipped()
    }
    
    func score(for exercises: [Exercise]) -> Int {
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
    
    @Published var selectedCourse: Course {
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
    @Published var exercises: [Exercise]
    @Published var finished: Bool = false
    
    var progressText: String {
        "\(currentIndex + 1) / \(exercises.count)"
    }
    
    var score: Int {
        session.score(for: exercises)
    }
    
    private var currentExercise: Exercise? {
        guard currentIndex >= 0, currentIndex < exercises.count else {
            return nil
        }
        return exercises[currentIndex]
    }
    
    private var currentState: ExerciseState {
        guard let id = currentExercise?.id else { return ExerciseState() }
        return session.state(for: id)
    }
    
    init() {
        print("Initializing exercise session model")
        let course = CourseSettings.selectedCourse
        self.exercises = ExerciseData.allExercises[course] ?? []
        // 这里似乎不会触发 didSet
        self.selectedCourse = course
        print("Couse initialized \(self.selectedCourse)")
    }
    
    func switchCourse(course: Course) {
        print("Resetting exercise and state")
        CourseSettings.selectedCourse = selectedCourse
//        You must reset currentIndex = 0 before updating exercises.
        currentIndex = 0
        session.reset()
//        to be extra safe, you can wrap it with DispatchQueue.main.async to ensure the reset happens after layout:
        DispatchQueue.main.async {
            self.exercises = ExerciseData.allExercises[course] ?? []
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
        
        exercises = incorrect
    }
    
    func next() {
        print("Current index \(currentIndex)")
        if !currentState.isAnswered {
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
    
    func binding(for exerciseID: String) -> Binding<ExerciseState> {
        Binding(
            get: {
                self.session.state(for: exerciseID)
            },
            set: {
                self.session.add(id: exerciseID, newState: $0)
            }
        )
    }
    
    private func submitAnswer(correct: Bool, answer: AnswerData) {
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


