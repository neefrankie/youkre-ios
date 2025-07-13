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
        states[id] ?? ExerciseState()
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

struct ExerciseModel {
    var allExercises: [Exercise]
    
    func forCourse(_ course: Course) -> [Exercise] {
        allExercises.filter { $0.course == course }
    }
}

class ExerciseSessionModel: ObservableObject {
    
    @Published var selectedCourse: Course {
        didSet {
            print("Course changed: \(selectedCourse)")
            reset()
            AppSettings.selectedCourse = selectedCourse
        }
    }
    
    @Published var currentIndex: Int = 0
    @Published var model: ExerciseModel
    @Published var session: SessionState = SessionState()
    
    init(allExercises: [Exercise]) {
        self.model = ExerciseModel(allExercises: allExercises)
        self.selectedCourse = AppSettings.selectedCourse
    }
    
    var exercises: [Exercise] {
        model.forCourse(selectedCourse)
    }
    
    var currentExercise: Exercise? {
        guard currentIndex >= 0, currentIndex < exercises.count else {
            return nil
        }
        return exercises[currentIndex]
    }
    
    var currentState: ExerciseState {
        get {
            guard let id = currentExercise?.id else { return ExerciseState() }
            return session.state(for: id)
        }
        set {
            guard let id = currentExercise?.id else { return }
            session.add(id: id, newState: newValue)
        }
    }
    
    var progressText: String {
        "\(currentIndex + 1) / \(exercises.count)"
    }
    
    var score: Int {
        session.score(for: exercises)
    }
    
    func submitAnswer(correct: Bool, answer: AnswerData) {
        guard let id = currentExercise?.id else { return }
        session.markAnswered(
            id: id,
            correct: correct,
            answer: answer
        )
    }
    
    func skipCurrent() {
        guard let id = currentExercise?.id else {
            return
        }
        
        session.skip(id: id)
    }
    
    func next() {
        if currentIndex < exercises.count - 1 {
            currentIndex += 1
        }
    }
    
    func retryIncorrectOnly() {
        let incorrect = exercises.filter {
            session.state(for: $0.id).isAnswered &&
            !session.state(for: $0.id).isCorrect
        }
        model = ExerciseModel(allExercises: incorrect)
        session.reset()
    }
    
    func reset() {
        print("Resetting ...")
        currentIndex = 0
        session.reset()
        
        print("Now current index \(currentIndex)")
    }
}


