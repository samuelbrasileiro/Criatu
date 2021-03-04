//
//  SetSimilarity.swift
//  Criatu
//
//  Created by Luis Pereira on 04/03/21.
//

import Foundation


class SetSimilarity{
    
    func setMagnitude(set:[String]) -> Int{
        return set.count
    }
    
    func setIntersectionMagnutude(firstSet:[String],secondSet:[String]) -> Int{
        
        var magnutde:Int = 0
        for element in firstSet{
            for secondElement in secondSet{
                if element == secondElement{
                    magnutde = magnutde + 1
                    break
                }
            }
        }
        
        return magnutde
    }
    
    func JaccardSimilarity(firstSet:[String],secondSet:[String]) -> Float{
        
        let firstSetMag = Float(setMagnitude(set: firstSet))
        let secondSetMag = Float(setMagnitude(set: secondSet))
        let intersec = Float(setIntersectionMagnutude(firstSet: firstSet, secondSet: secondSet))
        return intersec/(firstSetMag+secondSetMag-intersec)
    }
    
    func SorensenCoefficient(firstSet:[String],secondSet:[String]) -> Float{
        
        let firstSetMag = Float(setMagnitude(set: firstSet))
        let secondSetMag = Float(setMagnitude(set: secondSet))
        let intersec = Float(setIntersectionMagnutude(firstSet: firstSet, secondSet: secondSet))
        
        return 2*intersec/(firstSetMag+secondSetMag)
    }
    
    func OverlapCoefficient(firstSet:[String],secondSet:[String]) -> Float{
        
        let firstSetMag = Float(setMagnitude(set: firstSet))
        let secondSetMag = Float(setMagnitude(set: secondSet))
        let intersec = Float(setIntersectionMagnutude(firstSet: firstSet, secondSet: secondSet))
        
        return intersec/min(firstSetMag, secondSetMag)
    }
}
