//
//  ExerciseDataSource.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/8/9.
//
import Foundation
import SQLite

enum DBError: Error {
    case fileNotFound(String)
    case rowNotFound(String)
}

actor ExerciseDataSource {
    static let shared = ExerciseDataSource()
    
    let idCol = Expression<String>("id")
    let slug = Expression<String>("slug")
    let title = Expression<String>("title")
    let summary = Expression<String?>("summary")
    let keywords = Expression<String?>("keywords")
    let iconSfSymbol = Expression<String?>("icon_sf_symbol")
    let iconLatex = Expression<String?>("icon_latex")
    let iconText = Expression<String?>("icon_text")
    let contentVersion = Expression<Int>("content_version")
    let courseKindCol = Expression<String>("course_kind")
    
    let course_table = SQLite.Table("course")
    
    // Level table
    let courseId = Expression<String>("course_id")
    let courseSlug = Expression<String>("course_slug")
    let articleId = Expression<String>("article_id")
    let articleSlug = Expression<String>("article_slug")
    let index = Expression<Int>("index")
    
    let levelTable = SQLite.Table("exercise_level")
    
    // Exercise table
    let levelId = Expression<String>("level_id")
    let prompts = Expression<String>("prompts")
    let multipleChoice = Expression<String>("multiple_choice")
    let explanation = Expression<String>("explanation")
    
    let exerciseTable = SQLite.Table("exercise")
    
    func getConn() throws -> Connection {
        guard let dbPath = Bundle.main.webAssetsBundle?.path(forResource: "db", ofType: "sqlite3") else {
            throw DBError.fileNotFound("DB path not found at WebAssets.bundle/db.sqlite3")
        }
        
        return try Connection(dbPath, readonly: true)
    }
    
    func newIcon(row: SQLite.Row) -> IconSymbol? {
        if let sf = row[iconSfSymbol] {
            return .sfSymbol(sf)
        } else if let latex = row[iconLatex] {
            return .latex(latex)
        } else if let text = row[iconText] {
            return .text(text)
        }
        return nil
    }
    
    func loadCourse() throws -> [Course] {
        
        let conn = try getConn()
        
        let mapRowIterator = try conn.prepareRowIterator(course_table)
        let courses = try mapRowIterator.map{ row in
            return Course(
                id: row[idCol],
                slug: row[slug],
                title: row[title],
                summary: row[summary],
                keywords: row[keywords],
                icons: newIcon(row: row),
                contentVersion: row[contentVersion],
            )
        }
        return courses
    }
    
    func loadLevels(for course: Course) throws -> [ExerciseLevel] {
        print("Loading levels from SQLite...")
        let query_level = levelTable
            .filter(courseId == course.id)
            .order(index.asc)
        
        let conn = try getConn()
        
        let mapRowIterator = try conn.prepareRowIterator(query_level)
        let levels = try mapRowIterator.map(toLevel)
        
        return levels
    }
    
    private func toLevel(row: SQLite.Row) -> ExerciseLevel {
        return ExerciseLevel(
            id: row[idCol],
            courseID: row[courseId],
            courseSlug: row[courseSlug],
            chapterID: row[articleId],
            chapterSlug: row[articleSlug],
            title: row[title],
            index: row[index],
            contentVersion: row[contentVersion]
        )
    }
    
    private func decodePrompts(row: SQLite.Row) throws -> [PromptBlock] {
        let rawPrompts = row[prompts]
        
        if let data = rawPrompts.data(using: .utf8) {
            let result: Swift.Result<[PromptBlock], JSONError> = JSONParser.decode(data: data)
            
            switch result {
            case .success(let prompts):
                return prompts
            case .failure(let error):
                throw error
            }
        } else {
            throw JSONError.convertDataFailed
        }
    }
    
    private func decodeMultipleChoce(row: SQLite.Row) throws -> MultipleChoice {
        let rawValue = row[multipleChoice]
        if let data = rawValue.data(using: .utf8) {
            let result: Swift.Result<MultipleChoice, JSONError> = JSONParser.decode(data: data)
            
            switch result {
            case .success(let multipleChoice):
                return multipleChoice
            case .failure(let error):
                throw error
            }
        } else {
            throw JSONError.convertDataFailed
        }
    }
    
    func loadExercises(for course: Course, level: ExerciseLevel) throws -> [Exercise] {
        let exerciseQuery = exerciseTable
            .filter(levelId == level.id)
            .order(index.asc)

        let conn = try getConn()
        
        let mapRowIterator = try conn.prepareRowIterator(exerciseQuery)
        let exercises = try mapRowIterator.map(toExercise)
        
        return exercises
    }
    
    private func toExercise(row: SQLite.Row) throws -> Exercise {
        
        let prompts = try decodePrompts(row: row)
        let multipleChoice = try decodeMultipleChoce(row: row)
        
        return Exercise(
            id: row[idCol],
            levelId: row[levelId],
            prompts: prompts,
            multipleChoice: multipleChoice,
            explanation: row[explanation]
        )
    }
    
    private func fetchExercise(_ query: QueryType) throws -> Exercise {
        let conn = try getConn()
        conn.trace { print($0) }
        let exercise = try conn.pluck(query)
        
        if let ex = exercise {
            return try toExercise(row: ex)
        }
        
        throw DBError.rowNotFound("random exercise not found")
    }
    
    func fetchRandomExercise(kind: CourseKind) throws -> Exercise {
        var query = exerciseTable
            .order(Expression<Int>.random())
            .limit(1)
        
        if kind != .all {
            query = query.filter(courseKindCol == kind.rawValue)
        }
        
        return try fetchExercise(query)
    }
    
    
    
    func fetchExerciseByID(id: String) throws -> Exercise {
        let query = exerciseTable.filter(idCol == id)
        return try fetchExercise(query)
    }
    
    func fetchLevelByID(id: String) throws -> ExerciseLevel {
        let queryLevel = levelTable.filter(idCol == id)
        
        let conn = try getConn()
        
        let levelRow = try conn.pluck(queryLevel)
        
        if let row = levelRow {
            return toLevel(row: row)
        }
        
        throw DBError.rowNotFound("Exercise level not found: \(id)")
    }
    
    func countAll() throws {
        let conn = try getConn()
        
        let exCount = try conn.scalar(exerciseTable.select(idCol.count))
        
        print("Exercise rows: \(exCount)")
    }
    
    func manulRandomExercise() throws -> Exercise? {
        let conn = try getConn()
        let count = try conn.scalar(exerciseTable.count)
        
        guard count > 0 else {
            return nil // No rows in the table.
        }
        
        // Generate a random offset.
        let randomOffset = Int.random(in: 0..<count)
        
        // SELECT * FROM "exercise" LIMIT 1 OFFSET <randomOffset>
        let query = exerciseTable.limit(1, offset: randomOffset)
        
        conn.trace { print($0) }
        
        // Fetch one row using LIMIT and OFFSET.
        if let randomRow = try conn.pluck(query) {
            return try toExercise(row: randomRow)
        }
        
        return nil
    }
}
