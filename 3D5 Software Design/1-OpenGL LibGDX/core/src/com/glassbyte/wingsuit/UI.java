package com.glassbyte.wingsuit;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.files.FileHandle;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.freetype.FreeTypeFontGenerator;

/**
 * Created by ed on 17/10/15.
 * handles the display of info on the
 * user side,
 */
public class UI {
    private int FPS;
    private SpriteBatch spriteBatch;

    public BitmapFont bitmapFont;
    Player player;

    public UI() {
        player = new Player();
        loadFont();
    }

    /**
     * Loads fonts
     */
    private void loadFont(){
        spriteBatch = new SpriteBatch();
        FileHandle fontFile = Gdx.files.internal("Fonts/libelsuit.ttf");
        FreeTypeFontGenerator generator = new FreeTypeFontGenerator(fontFile);
        bitmapFont = generator.generateFont(120);
        bitmapFont.setColor(1f, 1f, 1f, 1f);
    }

    /**
     * Displays frames per second
     */
    public void displayFPS() {
        spriteBatch.begin();
        setFPS(Gdx.graphics.getFramesPerSecond());
        bitmapFont.draw(
                spriteBatch,
                "FPS: " + getFPS() + "\n" +
                        "X: " + player.getX() + ", Y: " + player.getY() + ", Z: " + player.getZ() + "\n" +
                        "Touched: " + player.isTouched(),
                Global.SCREEN_WIDTH * 0.03f,
                Global.SCREEN_HEIGHT * 0.95f);
        spriteBatch.end();
    }

    public void setFPS(int FPS) {
        this.FPS = FPS;
    }

    public int getFPS() {
        return FPS;
    }
}
