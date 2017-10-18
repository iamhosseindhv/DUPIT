//
//  ModelViewerController.swift
//  DUPME
//
//  Created by Hossein on 27/05/2017.
//  Copyright © 2017 Dupify. All rights reserved.
//

import UIKit
import ModelIO
import SceneKit
import SceneKit.ModelIO

class ModelViewerController: UIViewController {
    
    var modelURL: URL!
    var textureURL: URL!
    
    var sceneView: SCNView {
        return self.view as! SCNView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let modelurl = modelURL else {
            fatalError("3D model url not provided")
        }
        guard let textureurl = textureURL else {
            fatalError("3D texture url not provided")
        }
        
        //loads in into a MDLAsset
        let asset = MDLAsset(url:modelurl)
        
        //extracts the mesh from the asset
        guard let object = asset.object(at: 0) as? MDLMesh else {
            fatalError("Failed to get mesh from asset.")
        }
        //Create a material from the various textures
        let scatteringFunction = MDLScatteringFunction()
        let material = MDLMaterial(name: "baseMaterial", scatteringFunction: scatteringFunction)
        material.setTextureProperties(textures: [.baseColor : textureurl])
        
        //Apply the texture to every submesh of the asset
        for submesh in object.submeshes!  {
            if let submesh = submesh as? MDLSubmesh {
                submesh.material = material
            }
        }
        
        //create a sceneView
        let node = SCNNode(mdlObject: object)
        let scene = SCNScene()
        scene.rootNode.addChildNode(node)

        //set up the SceneView
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        
        
    }
    
}


extension MDLMaterial {
    func setTextureProperties(textures: [MDLMaterialSemantic:URL]) -> Void {
        for (key,value) in textures {
            let name = value.path
            let property = MDLMaterialProperty(name:name, semantic: key, url: value)
            self.setProperty(property)
        }
    }
}

