package com.glassbyte.wingsuit;

import com.badlogic.gdx.Gdx;

/**
 * Created by ed on 17/10/15.
 */

//To add bullet physics collidable mesh
public class Physics {
    float force, patagium, wrist, ankle;
    float delta_x, delta_y;
    float pitch, yaw, roll;
    double angle, velocity, height;
    boolean collision;

    public Physics(){
        setCollision(false);
    }

    public void rise(){}
    public void dip(){}
    public void collide(){
        setCollision(true);
    }
    public void resistance(){}
    public void bernoulliPrinciple(){}
    public void potentialEnergy(){}
    public void kineticEnergy(){}
    public void netForce(){}

    /** To do up after finishing up collision shapes
    @Override
    public void render () {
        final float delta = Math.min(1f/30f, Gdx.graphics.getDeltaTime());

        if (!collision) {
            ball.transform.translate(0f, -delta, 0f);
            collision = checkCollision();
        }

    }*/

    /**
     * return a handled event checking whether or not a collision has occurred
     * @return true or false with respect to boundary conditions
     */
    boolean checkCollision() {
        return false;
    }

    /**
     * returns the terminal velocity for the object falling to the earth
     * @return the maximum velocity achievable
     */
    public double getTerminalVelocity(){
        return Math.sqrt((2 * Global.MASS * Global.GRAVITY) /
                (Global.AIR_DENSITY * Global.SURFACE_AREA * Global.DRAG_COEFFICIENT));
    }

    /**
     * returns the forces of drag in a non-vacuum condition
     * @return the force in newtons experienced by the object via wind
     */
    public double getDragForce(){
        return 0.5 * Global.DRAG_COEFFICIENT * Global.FLUID_DENSITY
                * Math.pow(getVelocity(), 2) * Global.SURFACE_AREA;
    }

    public double getVelocity(){
        return 0;
    }

    public double getGlideRatio(){
        return getDelta_Y() / getDelta_X();
    }

    public void setDelta_X(float delta_x){
        this.delta_x = delta_x;
    }

    public float getDelta_X(){
        return delta_x;
    }

    public void setDelta_Y(float delta_y){
        this.delta_y = delta_y;
    }

    public float getDelta_Y(){
        return delta_y;
    }

    /**
     * get the weight of the object in kilograms
     * @return the weight of the object under effects of gravity
     */
    public double getWeight(){
        return Global.MASS * Global.GRAVITY; // w = mg
    }

    public void setCollision(boolean collision){
        this.collision = collision;
    }

    public boolean isCollision(){
        return collision;
    }

    public double getHeight(){return height;}
    public void setHeight(double height){this.height = height;}
    public void setVelocity(double velocity){this.velocity = velocity;}
    public void setAngle(double angle){this.angle = angle;}
    public double getAngle(){return angle;}
    public void setYaw(float yaw){this.yaw = yaw;}
    public void setYaw(float yaw, float delta_yaw){this.yaw = yaw + delta_yaw;}
    public float getYaw(){return yaw;}
    public void setPitch(float pitch){this.pitch = pitch;}
    public void setPitch(float pitch, float delta_pitch){this.pitch = pitch + delta_pitch;}
    public float getPitch(){return pitch;}
    public void setRoll(float roll){this.roll = roll;}
    public void setRoll(float roll, float delta_roll){this.roll = roll + delta_roll;}

}
