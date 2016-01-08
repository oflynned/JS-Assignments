package com.glassbyte.wingsuit;

import com.badlogic.gdx.assets.AssetManager;
import com.badlogic.gdx.graphics.g3d.Model;
import com.badlogic.gdx.graphics.g3d.ModelBatch;
import com.badlogic.gdx.graphics.g3d.ModelInstance;
import com.badlogic.gdx.graphics.g3d.model.Node;
import com.badlogic.gdx.utils.Array;

/**
 * Created by ed on 17/10/15.
 */

/**
 * List of assets
 * Where graphics such as map and trees
 * are loaded into the game
 */
public final class Assets {

    public AssetManager assetManager;
    public ModelBatch modelBatch;

    public Array<ModelInstance> modelInstances = new Array<ModelInstance>();
    public Array<ModelInstance> treeInstanceArray = new Array<ModelInstance>();
    public Array<ModelInstance> groundInstanceArray = new Array<ModelInstance>();

    public ModelInstance playerInstance;
    public ModelInstance treeInstance;
    public ModelInstance groundInstance;
    public ModelInstance skyboxInstance;

    private Model sceneModel;

    private final String scene = "Models/MAPTREE1.g3db";

    private boolean loading;

    public Assets() {
        modelBatch = new ModelBatch();
        assetManager = new AssetManager();
        setLoading(false);
    }

    private void load() {
        //load models
        assetManager.load(scene, Model.class);
    }

    /**
     * OpenGL requires rendering most efficiently from the largest to the smallest object
     */
    private void renderOptimisedScene() {
        //retrieve entire scene from 3d model indexed with object groups
        sceneModel = assetManager.get(scene, Model.class);
        for (int i = 0; i < sceneModel.nodes.size; i++) {
            String id = sceneModel.nodes.get(i).id;
            ModelInstance instance = new ModelInstance(sceneModel, id);
            Node node = instance.getNode(id);

            instance.transform.set(node.globalTransform);
            node.translation.set(0, 0, 0);
            node.scale.set(1, 1, 1);
            node.rotation.idt();
            instance.calculateTransforms();

            if (id.equals("space")) {
                treeInstance = instance;
                continue;
            }
            modelInstances.add(instance);

            if (id.equals("Environment"))
                groundInstanceArray.add(instance);
            else if (id.startsWith("Tree01"))
                treeInstanceArray.add(instance);
            else if (id.startsWith("Tree02"))
                treeInstanceArray.add(instance);
            else if (id.startsWith("Gwilin01"))
                treeInstanceArray.add(instance);
            else if (id.startsWith("Gwilin02"))
                treeInstanceArray.add(instance);
        }
        setLoading(false);
    }

    public void loadScene() {
        setLoading(true);
        load();
    }

    public void isLoaded() {
        if (isLoading() && assetManager.update()) {
            renderOptimisedScene();
        }
    }

    public boolean isLoading() {
        return loading;
    }

    public void setLoading(boolean loading) {
        this.loading = loading;
    }
}
