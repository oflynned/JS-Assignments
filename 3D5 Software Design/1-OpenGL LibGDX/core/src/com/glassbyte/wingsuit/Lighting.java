package com.glassbyte.wingsuit;

import com.badlogic.gdx.graphics.g3d.Environment;
import com.badlogic.gdx.graphics.g3d.attributes.ColorAttribute;
import com.badlogic.gdx.graphics.g3d.environment.DirectionalLight;

/**
 * Created by ed on 17/10/15.
 */

/**
 * Sets lighting in game
 * Difused or direct
 */
public class Lighting {

    Environment environment = new Environment();

    /**
     * Sets ambient lighting for the scene
     * so that it can be viewed under effects of directional lighting from a source
     */
    public void illuminateScene(){
        environment.set(new ColorAttribute(ColorAttribute.AmbientLight,
                0.4f,
                0.4f,
                0.4f,
                1f));
        environment.add(new DirectionalLight().set(
                0.8f,
                0.8f,
                0.8f,
                -1f,
                -0.8f,
                -0.2f));
    }
}
