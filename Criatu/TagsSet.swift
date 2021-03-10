//
//  SetSimilarity.swift
//  Criatu
//
//  Created by Luis Pereira on 04/03/21.
//

import Foundation

class TagsSet<SetType: Comparable> {
    var data: [SetType]
    var magnitude: Float {
        get {
            return Float(self.data.count)
        }
    }
    
    init(_ data: [SetType] = []) {
        self.data = data
    }
    
    func jaccardSimilarity(to secondSet: TagsSet<SetType>) -> Float{
        let intersec = self.setIntersectionMagnitude(to: secondSet)
        return intersec/(self.magnitude + secondSet.magnitude - intersec)
    }
    
    func overlapCoefficient(to secondSet: TagsSet<SetType>) -> Float{
        let intersec = self.setIntersectionMagnitude(to: secondSet)
        return intersec/min(self.magnitude, secondSet.magnitude)
    }
    
    func sorensenCoefficient(to secondSet: TagsSet<SetType>) -> Float{
        let intersec = self.setIntersectionMagnitude(to: secondSet)
        return 2 * intersec/(self.magnitude + secondSet.magnitude)
    }
    
    private func setIntersectionMagnitude(to secondSet: TagsSet<SetType>) -> Float{
        return Float(self.data.filter({ secondSet.data.contains($0)}).count)
    }
}

