package com.glassbyte.wingsuit;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.PerspectiveCamera;
import com.badlogic.gdx.graphics.g3d.Environment;
import com.badlogic.gdx.graphics.g3d.utils.CameraInputController;

/**
 * Created by ed on 17/10/15.
 */

public class Camera {

    public Environment environment;
    public PerspectiveCamera perspectiveCamera;
    public CameraInputController cameraInputController;

    //class objects
    Assets assets;
    UI ui;
    Player player;
    Lighting lighting;

    /**
     * initialises class objects and sets up scene for rendering and perspective handling
     */
    public void create() {
        environment = new Environment();
        ui = new UI();
        assets = new Assets();
        player = new Player();
        lighting = new Lighting();

        lighting.illuminateScene();
        setupCamera();
        perspectiveCamera.update();
        setupController();

        assets.loadScene();
    }

    /**
     * loads assets and renders vertices through batch rendering
     */
    public void render() {
        assets.isLoaded();
        cameraInputController.update();
        player.setTouched(false);

        Gdx.gl.glViewport(0, 0, Global.SCREEN_WIDTH, Global.SCREEN_HEIGHT);
        Gdx.gl.glClearColor(1f, 0f, 0f, 1f);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT | GL20.GL_DEPTH_BUFFER_BIT);

        assets.modelBatch.begin(perspectiveCamera);
        assets.modelBatch.render(assets.modelInstances, lighting.environment);
        ui.displayFPS();
        assets.modelBatch.end();
    }

    /**
     * clears resources for assets acquired for rendering
     */
    public void dispose() {
        assets.modelBatch.dispose();
        assets.modelInstances.clear();
        assets.assetManager.dispose();
    }

    /**
     * initialises the camera's perspective to global variables defined for perspective, depth
     * of field, position and view focus
     */
    private void setupCamera(){
        perspectiveCamera = new PerspectiveCamera(
                Global.FIELD_OF_VIEW,
                Global.SCREEN_WIDTH,
                Global.SCREEN_HEIGHT);
        perspectiveCamera.position.set(
                player.getX(),
                player.getY(),
                player.getZ());
        //Start up camera facing direction
        perspectiveCamera.lookAt(1,1,1);
        perspectiveCamera.near = Global.PERSPECTIVE_NEAR;
        perspectiveCamera.far = Global.PERSPECTIVE_FAR;
    }

    /**
     * enabled a touch-based camera controller that pivots around (0,0,0)
     */
    private void setupController(){
        cameraInputController = new CameraInputController(perspectiveCamera);
        Gdx.input.setInputProcessor(cameraInputController);
    }
}
