package com.glassbyte.wingsuit;

import com.badlogic.gdx.Application;
import com.badlogic.gdx.Gdx;

/**
 * Created by ed on 17/10/15.
 */

public final class Global{
    //check device
    public static Application.ApplicationType platform = Gdx.app.getType();

    //perspective
    public static final float FIELD_OF_VIEW = 67; // 67 degrees is common apparently
    public static final float PERSPECTIVE_NEAR = 1f;
    public static final float PERSPECTIVE_FAR = 1000f;
    public static final float START_X = 150f;
    public static final float START_Y = 400f;
    public static final float START_Z = -150f;

    //screen
    public static int SCREEN_WIDTH = Gdx.graphics.getWidth();
    public static int SCREEN_HEIGHT = Gdx.graphics.getHeight();

    //fps & collision maintenance
    public static float DELTA = Math.min(1f / 30f, Gdx.graphics.getDeltaTime());

    //physics constants
    public static final float TERMINAL_VELOCITY_RATIO = 0.5f; // unitless
    public static final float GRAVITY = -9.81f; // m/s^2
    public static final float MASS = 90f; // kg
    public static final float DRAG_COEFFICIENT = 1.0f; // unitless
    public static final float SURFACE_AREA = 0.84f; // m^2
    public static final float AIR_DENSITY = 1.2f; // kg/m^3
    public static final float FLUID_DENSITY = 0.004f; // kg/mdr^3

    public static final float VOLUME = 1f;
    public static final float PRESSURE = 1f;
    public static final float LIFT = 1f;
    public static final float THRUST = 1f;
    public static final float GLIDE_RATIO = 2.5f;

    public static boolean isAndroid(){
        return platform == Application.ApplicationType.Android;
    }
}
