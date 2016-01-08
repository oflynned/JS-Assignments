package com.glassbyte.wingsuit;

import com.badlogic.gdx.input.GestureDetector;

/**
 * Created by ed on 17/10/15.
 */

/**
 * Makes Palyer movement possible
 * Sets player position and camera
 */
public class Player {

    private float x, y, z = 0f;
    private boolean touched = false;

    /**
     * Defines player position
     */

    Camera camera = new Camera();


    public Player(){
        setX(Global.START_X);
        setY(Global.START_Y);
        setZ(Global.START_Z);
    }

    public void setX(float x){this.x=x;}
    public float getX(){return x;}
    public void setY(float y){this.y=y;}
    public float getY(){return y;}
    public void setZ(float z){this.z=z;}
    public float getZ(){return z;}
    public void setTouched(boolean touched){this.touched = touched;}
    public boolean isTouched(){return touched;}
}

